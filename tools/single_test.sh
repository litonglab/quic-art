delay=30
loss_rate=0.1
epoch=1
reqs=1
echo passwd | sudo -S nohup ./bin/http_server -c www.litongquic.tk,/etc/ssl/certs/litongquic.crt,/etc/ssl/private/litongquic.key -r /home/downloadFile/ -L debug -s 0.0.0.0:443 & 
pid=$!
echo $pid
number=1
filelist=''
while [ "$number" -le "$reqs" ]; do
	filelist="$filelist -p /gcc-11.2.0.tar "
	#filelist="$filelist -p /mahimahi.tar "
	((number++))
done
echo "/home/lsquic_client/bin/http_client -s www.litongquic.tk $filelist -L info -t -r $reqs -R $reqs -g /home/liuwei/sslkeyfiles > client_output.txt; sleep 5 ; exit" | mm-link /home/liuwei/mahimahi/traces/Verizon-LTE-driving.up /home/liuwei/mahimahi/traces/Verizon-LTE-driving.down --downlink-queue=droptail --downlink-queue-args=bytes=80000  mm-loss downlink ${loss_rate} mm-delay ${delay}
echo passwd | sudo -S killall http_server

sudo chown root nohup.out
tail -n31 client_output.txt >> nohup.out
mv nohup.out motivation/Verizon-LTE-drivingtrace_${delay}delay_${loss_rate}_$1.txt
