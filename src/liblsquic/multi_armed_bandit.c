#include <assert.h>
#include <errno.h>
#include <inttypes.h>
#include <stdlib.h>
#include <string.h>
#include <sys/queue.h>
#include <math.h>
#include <float.h>

#include <openssl/rand.h>

#include "lsquic_types.h"
#include "lsquic_int_types.h"
#include "lsquic.h"
#include "lsquic_mm.h"
#include "lsquic_engine_public.h"
#include "lsquic_packet_common.h"
#include "lsquic_alarmset.h"
#include "lsquic_parse.h"
#include "lsquic_packet_in.h"
#include "lsquic_packet_out.h"
#include "lsquic_packet_resize.h"
#include "lsquic_senhist.h"
#include "lsquic_rtt.h"
#include "lsquic_cubic.h"
#include "lsquic_pacer.h"
#include "lsquic_bw_sampler.h"
#include "lsquic_minmax.h"
#include "lsquic_bbr.h"
#include "lsquic_adaptive_cc.h"
#include "lsquic_util.h"
#include "lsquic_sfcw.h"
#include "lsquic_varint.h"
#include "lsquic_hq.h"
#include "lsquic_hash.h"
#include "lsquic_stream.h"
#include "lsquic_ver_neg.h"
#include "lsquic_ev_log.h"
#include "lsquic_conn.h"
#include "lsquic_send_ctl.h"
#include "lsquic_conn_flow.h"
#include "lsquic_conn_public.h"
#include "lsquic_cong_ctl.h"
#include "lsquic_enc_sess.h"
#include "lsquic_malo.h"
#include "lsquic_attq.h"
#include "lsquic_http1x_if.h"
#include "lsqpack.h"
#include "lsquic_frab_list.h"
#include "lsquic_qdec_hdl.h"
#include "lsquic_crand.h"
#include "multi_armed_bandit.h"

#define LSQUIC_LOGGER_MODULE LSQLM_SENDCTL
#define LSQUIC_LOG_CONN_ID lsquic_conn_log_cid(ctl->sc_conn_pub->lconn)
#include "lsquic_logger.h"

unsigned
select_arm_with_ucb_policy(struct lsquic_send_ctl *ctl)
{
    unsigned arm_index, sum_use_number;
    double temp_bonus, max_bonus;

    sum_use_number = 0;
    for (unsigned temp = 0; temp < NUM_OF_ARMS; temp++)
    {
        if (ctl->sc_all_arms[temp].use_number == 0)
        {
            arm_index = temp;
            LSQ_ERROR("Arm was chosen by firstly: %u", arm_index);
            return arm_index;
        }
        sum_use_number += ctl->sc_all_arms[temp].use_number;
    }

    max_bonus = DBL_MIN;
    for (unsigned temp = 0; temp < NUM_OF_ARMS; temp++)
    {
        // multipy a ratio
        temp_bonus = 0.5 * sqrt((2*log((double)sum_use_number))/(double)ctl->sc_all_arms[temp].use_number);
        temp_bonus += ctl->sc_all_arms[temp].expect;
        if (temp_bonus > max_bonus)
        {
            max_bonus = temp_bonus;
            arm_index = temp;
        }
    }
    LSQ_ERROR("Arm was chosen by UCB policy: %u", arm_index);
    return arm_index;
}

unsigned
select_arm_with_epsilon_greedy_policy(struct lsquic_send_ctl *ctl)
{
    unsigned arm_index;
    double random_var;

    srand((unsigned)time(NULL));
    random_var = (double)(rand()/RAND_MAX);

    if (random_var < EPSILON)
    {
        arm_index = rand()%NUM_OF_ARMS;
        LSQ_ERROR("Arm was chosen by randomly: %u", arm_index);
        return arm_index;
    }
    else
    {
        arm_index = 0;
        for (unsigned temp = 1; temp < NUM_OF_ARMS; temp++)
        {
            if (ctl->sc_all_arms[temp].expect > ctl->sc_all_arms[arm_index].expect)
                arm_index = temp;
        }
        LSQ_ERROR("Arm was chosen by greedy: %u", arm_index);
    }
    return arm_index;
}

void
calc_multi_armed_bandit_reward(struct lsquic_send_ctl *ctl,
                                   struct lsquic_packet_out *packet_out, lsquic_time_t now)
{
    unsigned cur_round, temp_arm_index, temp_use_number;
    double temp_reward, temp_expect;
    struct lsquic_packet_out *chain_cur, *chain_next;

    cur_round = packet_out->po_retrans_times;
    if (cur_round < 1)
        return;
    temp_arm_index = packet_out->po_need_retrans_number-1;
    temp_use_number = ctl->sc_all_arms[temp_arm_index].use_number;
    temp_expect = ctl->sc_all_arms[temp_arm_index].expect;
    temp_reward = (double) 1.0/(cur_round * packet_out->po_need_retrans_number);
    ctl->sc_all_arms[temp_arm_index].expect = 
            (temp_expect * temp_use_number + temp_reward)/(temp_use_number + 1);
    ctl->sc_all_arms[temp_arm_index].use_number += 1;
    LSQ_ERROR("Reward was calculated in %"PRIu64". reward: %f, round: %u, arm: %u, use_number: %u, expect: %f, packno: %"PRIu64", pack_retransno: %"PRIu64,
                now, temp_reward, cur_round, temp_arm_index+1, ctl->sc_all_arms[temp_arm_index].use_number,
                ctl->sc_all_arms[temp_arm_index].expect, packet_out->po_packno, packet_out->po_retrans_no);
    cur_round--;

    for (chain_cur = packet_out->po_loss_chain; chain_cur != packet_out && cur_round > 0;
                                                            chain_cur = chain_next)
    {
        chain_next = chain_cur->po_loss_chain;
        if (cur_round > 0 && chain_cur->po_retrans_times <= cur_round)
        {
            temp_arm_index = chain_cur->po_need_retrans_number-1;
            temp_use_number = ctl->sc_all_arms[temp_arm_index].use_number;
            temp_expect = ctl->sc_all_arms[temp_arm_index].expect;
            temp_reward = (double) -1.01 * (cur_round * chain_cur->po_need_retrans_number);
            ctl->sc_all_arms[temp_arm_index].expect = 
                    (temp_expect * temp_use_number + temp_reward)/(temp_use_number + 1);
            ctl->sc_all_arms[temp_arm_index].use_number += 1;
            LSQ_ERROR("Reward was calculated. reward: %f, round: %u, arm: %u, use_number: %u, expect: %f",
                temp_reward, cur_round, temp_arm_index+1, ctl->sc_all_arms[temp_arm_index].use_number,
                ctl->sc_all_arms[temp_arm_index].expect);
            cur_round--;
        }
    }

}


