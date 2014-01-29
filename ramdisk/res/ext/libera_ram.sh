#!/sbin/busybox sh
#
# libera memoria cada hora si esta está por debajo de 8192 kbytes
# 

/sbin/busybox renice 19 `pidof libera_ram.sh`
FREE=`free -m | grep -i mem | awk '{print $4}'`  

while [ 1 ];
do
        if [ $FREE -lt 8192 ]; then
                sync
                echo "2853,5632,24576,86016,96768,96768" > /sys/module/lowmemorykiller/parameters/minfree
        fi
sleep 3600
done
