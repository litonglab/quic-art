#ifndef LSQUIC_CONFIG_H
#define LSQUIC_CONFIG_H

#define HAVE_SENDMMSG 1
#define HAVE_RECVMMSG 1
#define HAVE_OPEN_MEMSTREAM 1
/* #undef HAVE_IP_DONTFRAG */
#define HAVE_IP_MTU_DISCOVER 1
#define HAVE_REGEX 1
#define HAVE_PREADV 1

#define LSQUIC_DONTFRAG_SUPPORTED (HAVE_IP_DONTFRAG || HAVE_IP_MTU_DISCOVER || HAVE_IPV6_MTU_DISCOVER)

/* TODO: presumably it's the same on FreeBSD, test it.
 * See https://github.com/quicwg/base-drafts/wiki/ECN-in-QUIC
 */
#if __linux__ || defined(__FreeBSD__)
#define ECN_SUPPORTED 1
#else
#define ECN_SUPPORTED 0
#endif

#endif
