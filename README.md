
# About

This repository contains the source code of ART, the implementation of QUIC-ART in paper "ART: Adaptive Retransmission for Wide-Area Loss Recovery in the Wild (IEEE ICNP'23)"

ART is a sender-side Adaptive ReTransmission scheme, which minimizes the recovery time of lost packets with minimal redundancy cost. Distinguishing itself from forward-error-correction (FEC), which preemptively sends redundant data packets to prevent loss, ART functions as an automatic-repeat-request (ARQ) scheme. It applies redundancy specifically to lost packets instead of unlost packets, thereby addressing the characteristic patterns of wide-area losses in real-world scenarios.

Please cite this paper as follows:

- Tong Li, Wei Liu, Xinyu Ma, Shuaipeng Zhu, Jinkun Cao, Senzhen Liu, Taotao Zhang, Yinfeng Zhu, Bo Wu, Ke Xu. ART: Adaptive Retransmission for Wide-Area Loss Recovery in the Wild. IEEE International Conference on Network Protocols (ICNP), pp.1-11, 2023.10.10.

