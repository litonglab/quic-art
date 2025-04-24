# plr = 10%
loss_rate=0.1
# owd = 30ms
delay=30
# bw = 100Mbps
bandwidth=100

# multiple loss rate
# for loss_rate in {0.02,0.05,0.08,0.1}
# do
	echo $loss_rate
	for direct in `ls -d /home/downloadFile/files`
	do
		echo 'passwd' | sudo -S nohup /home/lsquic/bin/art_server -c www.litongquic.tk,/etc/ssl/certs/litongquic.crt,/etc/ssl/private/litongquic.key -r /home/downloadFile/ -L debug -s 0.0.0.0:443 & 
		pid=$!
		echo $pid
		echo 'hhh'
		files=''
		num=0
		dir=$(basename $direct)
		for file in `ls /home/downloadFile/$dir/`
		do
			files="$files,/$dir/$file"
			((num=num+1))
		done
		filelist=$(echo $files | python -c "s=raw_input();print(s.strip(','))")
		echo $filelist
		echo $num
		echo "/home/lsquic_client/bin/http_client -s www.litongquic.tk -p mahimahi.tar -t -L info -G /home/liuwei/sslkeyfiles > client_output.txt ; sleep 10; exit" | mm-link /home/liuwei/mahimahi/traces/100Mbps_trace.up /home/liuwei/mahimahi/traces/100Mbps_trace.down  mm-loss downlink $loss_rate mm-delay $delay 
		sleep 5
		echo 'passwd' | sudo -S killall art_server
		# 输出日志
		/home/lsquic/statistics.sh ${bandwidth}Mbps_${loss_rate}loss_${delay}delay_log.txt
	done
# done
