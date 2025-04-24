#!/bin/bash

interface=delay-25924
dst_ip=100.64.0.2
#dst_ip=10.2.0.3
#dst_ip=ffff:dc1:b:5::43
#dev
#dst_ip=ffff:dc01:b:57::43
sport=443
bw=10
#bw=10000
delay=10
loss=0
maxq=1000

function usage()
{
	echo "$0 bw(Mbps) rtt(ms) loss(%) maxq(packet)"
}

#if [ $# -lt 4 ]; then
#	usage
#	exit
#fi

if [[ -n $1 ]]; then
	bw=$1
fi
if [[ -n $2 ]]; then
	delay=$2
fi
if [[ -n $3 ]]; then
	loss=$3
fi
if [[ -n $4 ]]; then
	maxq=$4
fi

#echo $*
#echo $bw,$delay,$loss,$maxq

echo "=========1. create root qdisc ==========="
tc qdisc del dev $interface root
tc qdisc add dev $interface root handle 1: htb default 2
echo "=========2. create class ==========="
tc class add dev $interface parent 1: classid 1:1 htb rate ${bw}mbit ceil ${bw}mbit burst 15k
tc class add dev $interface parent 1: classid 1:2 htb rate 10gbit
echo "=========3. create filter ==========="
#tc filter add dev $interface protocol ip parent 1:0 prio 1 u32 match ip dst ${dst_ip}/32 match ip sport ${sport} 0xffff match ip protocol 17 0xff flowid 1:1
tc filter add dev $interface protocol ip parent 1:0 prio 1 u32 match ip dst ${dst_ip}/32 flowid 1:1

#tc filter add dev $interface protocol ipv6 parent 1:0 prio 1 u32 match ip6 dst ${dst_ip}/128 flowid 1:1
#tc filter add dev $interface protocol ipv6 parent 1:0 prio 1 u32 match ip6 dst ${dst_ip}/128 match ip6 sport ${sport} 0xffff flowid 1:1
echo "=========4. create child qdisc ==========="
tc qdisc add dev $interface parent 1:1 handle 10: netem delay ${delay}ms ${delay}ms loss ${loss}% 25% limit ${maxq}
tc qdisc add dev $interface parent 1:2 handle 20: fq


