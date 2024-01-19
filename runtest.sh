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
filelist=' -p ART.md -p ART_modify.txt '

# server side
echo $password | sudo -S nohup /home/ubuntu/quic-art-multi-armed-bandit/bin/http_server -c www.litongquic.tk,/home/ubuntu/data-field.net_nginx/data-field.net_bundle.crt,/home/ubuntu/data-field.net_nginx/data-field.net.key -L debug -r /home/ubuntu -s 0.0.0.0:443 &

# client side
echo "/home/ubuntu/lsquic/bin/http_client -s www.litongquic.tk -L info -t -r $reqs -R $reqs $filelist > client_output.txt; sleep 50; exit"| mm-link ${trace}.up ${trace}.down mm-delay $delay mm-loss downlink $loss_rate

while true
do
	if echo "$password" | sudo -S tail -n 20 nohup.out | grep -q "9th arm" ; then
		echo "server has finished"
		break
	else
		echo "wait finishing"
	fi
done

tracename=$(basename "$trace")
resultfile=/home/ubuntu/multi-armed-bandit-experiments/${tracename}_${delay}_${loss_rate}_multi-armed-bandit_ucb_$2.txt
mkdir -p /home/ubuntu/multi-armed-bandit-experiments
# save result
# echo $password | sudo -S chown ubuntu nohup.out
echo $password | sudo -S mv nohup.out $resultfile
echo $password | sudo -S chown ubuntu $resultfile

# save client result
tail -n31 client_output.txt >> $resultfile

# cleanup
echo $password | sudo -S killall http_server
