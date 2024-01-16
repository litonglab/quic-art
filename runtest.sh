#!/bin/bash
trace=/home/ubuntu/mahimahi/traces/Verizon-LTE-driving
delay=30
loss_rate=0.1

password="$1"
if [ -z "$password" ]; then
	echo "请添加密码. please provide password"
	echo -e "usage: ./runtest.sh your_passwd"
	exit 1
fi

filelist=' -p test_fct.txt  -p test_fct2.txt '
reqs=2
# filelist=' -p boringssl.tar -p ART_modify.txt '

# server side
echo $password | sudo -S nohup /home/ubuntu/quic-art/bin/http_server -c www.litongquic.tk,/home/ubuntu/data-field.net_nginx/data-field.net_bundle.crt,/home/ubuntu/data-field.net_nginx/data-field.net.key -L error -r /home/ubuntu -s 0.0.0.0:5443 &
pid=$!
echo "pid is $pid"

# client side
echo "echo \$MAHIMAHI_BASE > client_test.txt ; /home/ubuntu/lsquic/bin/http_client -s \$MAHIMAHI_BASE:5443 -H www.litongquic.tk -L info -t -r $reqs -R $reqs $filelist > client_output.txt; sleep 5; exit"| mm-link ${trace}.up ${trace}.down mm-delay $delay mm-loss downlink $loss_rate

tracename=$(basename "$trace")
resultfile=./${tracename}_${delay}_${loss_rate}_ART.txt
mkdir -p /home/ubuntu/multi-armed-bandit-experiments
# save result
# echo $password | sudo -S chown ubuntu nohup.out
echo $password | sudo -S cp nohup.out $resultfile
echo $password | sudo -S chown ubuntu $resultfile

# save client result
tail -n31 client_output.txt >> $resultfile

# cleanup
echo $password | sudo -S kill $pid
