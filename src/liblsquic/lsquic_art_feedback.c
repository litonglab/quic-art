#include <assert.h>
#include <errno.h>
#include <inttypes.h>
#include <stdlib.h>
#include <string.h>
#include <sys/queue.h>

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
#include "lsquic_art_feedback.h"

#define LSQUIC_LOGGER_MODULE LSQLM_SENDCTL
#define LSQUIC_LOG_CONN_ID lsquic_conn_log_cid(ctl->sc_conn_pub->lconn)
#include "lsquic_logger.h"


unsigned
art_duplicate_number(struct lsquic_send_ctl *ctl, struct lsquic_packet_out *packet_out)
{
    unsigned temp_round = packet_out->po_retrans_times;
    unsigned temp_redundancy = ctl->sc_rounds_map[temp_round];
    double rlr = art_replica_loss_rate(ctl);
    if (rlr > (1-(1.0/temp_redundancy)))
        ctl->sc_rounds_map[temp_round] += 1;
    else if (rlr <= (1-(2.0/temp_redundancy)))
        ctl->sc_rounds_map[temp_round] -= 1;
    LSQ_DEBUG("art redundancy status: before is %u, after is %u", temp_redundancy, ctl->sc_rounds_map[temp_round]);
    return ctl->sc_rounds_map[temp_round];
}

double
art_replica_loss_rate(struct lsquic_send_ctl *ctl)
{
    lsquic_art_feedback_t *temp_feedback, *next_feedback;
    double result;
    double feedback_sum_of_1 = 0.0;

    if (ctl->sc_feedback_window_size == 0)
        return 0;

    for (temp_feedback = TAILQ_FIRST(&ctl->sc_feedback_window); temp_feedback;
                                                            temp_feedback = next_feedback)
    {
        next_feedback = TAILQ_NEXT(temp_feedback, af_next);
        if (temp_feedback->feedback_value == 1)
            feedback_sum_of_1 += 1.0;
    }
    result = (double)(feedback_sum_of_1/(double)ctl->sc_feedback_window_size);
    LSQ_DEBUG("replica loss rate is: %f, replica loss number: %f, window size: %u", result, feedback_sum_of_1, ctl->sc_feedback_window_size);
    return result;
}