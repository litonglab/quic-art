#ifndef LSQUIC_RL_AGENT_H
#define LSQUIC_RL_AGENT_H 1

#include <sys/mman.h>
#include <fcntl.h>

#include "lsquic_send_ctl.h"

#define ACTION_FILE "/home/ubuntu/quic-art/action.txt"
#define STATE_FILE "/home/ubuntu/quic-art/state.txt"
#define RECORD_FILE "/home/ubuntu/quic-art/records.txt"
#define ACTION_SHM_SIZE 1
#define STATE_SHM_SIZE sizeof(struct rl_state)
#define RECORD_MAX_INDEX 2048
#define RECORD_SHM_SIZE 2048 * sizeof(struct rl_record)

struct rl_state;

typedef struct rl_state
{
    //network state
    uint64_t send_rate;
    uint64_t ack_rate;
    uint64_t minrtt;
    uint64_t srtt;
    unsigned lost_packet_number;
    unsigned inflight;
    //lost packet info
    unsigned round;
}rl_state_t;

struct rl_record;

typedef struct rl_record
{
    struct rl_state state;
    //action
    unsigned dup_number;
    //result, 0 means not acked, 1 means acked.
    unsigned ack_or_not;
    //reward
    double reward;
    // next state
    struct rl_state next_state;
}rl_record_t;

void insert_records_to_shm(struct lsquic_send_ctl *ctl, struct rl_record *records, unsigned offset, struct lsquic_packet_out *packet_out);
unsigned get_action(struct lsquic_send_ctl *ctl);
void write_state_to_shm(struct lsquic_send_ctl *ctl, struct rl_state *state);


#endif