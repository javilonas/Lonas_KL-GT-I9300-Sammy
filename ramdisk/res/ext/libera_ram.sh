#!/sbin/busybox sh
#
# libera memoria y pagecache cada 3 horas si esta está por debajo de 5632 kbytes
# 

/sbin/busybox renice 19 `pidof libera_ram.sh`
FREE=`free -m | grep -i mem | awk '{print $4}'`  

while [ 1 ];
do
        if [ $FREE -lt 5632 ]; then
                sync
                echo "1" > /proc/sys/vm/drop_caches
                echo "2853,5632,24576,86016,96768,96768" > /sys/module/lowmemorykiller/parameters/minfree
        fi
sleep 10800
done
