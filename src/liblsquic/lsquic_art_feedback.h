/* Copyright (c) 2017 - 2022 LiteSpeed Technologies Inc.  See LICENSE. */
/*
 * lsquic_packet_in.h
 */

#ifndef LSQUIC_ART_FEEDBACK_H
#define LSQUIC_ART_FEEDBACK_H 1

#include <sys/queue.h>

#include "lsquic_packet_out.h"
#include "lsquic_send_ctl.h"

struct lsquic_art_feedback;


typedef struct lsquic_art_feedback
{
    TAILQ_ENTRY(lsquic_art_feedback) af_next;
    short    feedback_value;
} lsquic_art_feedback_t;

unsigned
art_duplicate_number(struct lsquic_send_ctl *ctl,
                                   struct lsquic_packet_out *packet_out);
double
art_replica_loss_rate(struct lsquic_send_ctl *ctl);

#endif
