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
#include "RL_Agent.h"

#define LSQUIC_LOGGER_MODULE LSQLM_SENDCTL
#define LSQUIC_LOG_CONN_ID lsquic_conn_log_cid(ctl->sc_conn_pub->lconn)
#include "lsquic_logger.h"

unsigned get_action(struct lsquic_send_ctl *ctl)
{
    char* addr = (char*)ctl->sc_action_addr;
    unsigned action = (unsigned)(*addr);
    LSQ_ERROR("action in shared memory is: %u", action);
    return action;
}

void insert_records_to_shm(struct lsquic_send_ctl *ctl, struct rl_record *records, unsigned index, struct lsquic_packet_out *packet_out)
{
    // if (index > RECORD_MAX_INDEX)
    //     index = index % RECORD_MAX_INDEX;
    LSQ_ERROR("write record to index: %u, addr: %p: send_rate: %"PRIu64", ack_rate: %"PRIu64", minrtt: %"PRIu64", srtt: %"PRIu64", lost_number: %u, inflight: %u, round: %u, dup_number: %u, ack_or_not: %u, reward: %lf, next_send_rate: %"PRIu64", next_ack_rate: %"PRIu64", next_minrtt: %"PRIu64", next_srtt: %"PRIu64", next_lost_number: %u, next_inflight: %u, next_round: %u, packno: %"PRIu64", pack_retransno: %"PRIu64,
                                    index, ctl->sc_records_addr+index*sizeof(struct rl_record), records->state.send_rate, records->state.ack_rate, records->state.minrtt, records->state.srtt, records->state.lost_packet_number, records->state.inflight, records->state.round, records->dup_number, records->ack_or_not, records->reward, records->next_state.send_rate, records->next_state.ack_rate, records->next_state.minrtt, records->next_state.srtt, records->next_state.lost_packet_number, records->next_state.inflight, records->next_state.round, packet_out->po_packno, packet_out->po_retrans_no);
    memcpy(ctl->sc_records_addr+index*sizeof(struct rl_record), records, sizeof(struct rl_record));
}

void write_state_to_shm(struct lsquic_send_ctl *ctl, struct rl_state *state)
{
    memcpy(ctl->sc_state_addr, state, sizeof(struct rl_state));
}