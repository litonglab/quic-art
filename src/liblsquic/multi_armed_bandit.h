#ifndef MULTI_ARMED_BANDIT_H
#define MULTI_ARMED_BANDIT_H 1

#define NUM_OF_ARMS 10
#define EPSILON 0.1

#include "lsquic_packet_out.h"
#include "lsquic_send_ctl.h"

struct arm_of_bandit;

typedef struct arm_of_bandit
{
    unsigned use_number;
    double expect;
}arm_of_bandit_t;

unsigned
select_arm_with_epsilon_greedy_policy(struct lsquic_send_ctl *ctl);

void
calc_multi_armed_bandit_reward(struct lsquic_send_ctl *ctl,
                               struct lsquic_packet_out *packet_out,
                               lsquic_time_t now);

#endif