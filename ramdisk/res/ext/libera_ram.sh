#!/sbin/busybox sh
#
# Idea extraida del script ramcheck.sh creado por NeoPhyTe.x360
# Modificado y adaptado a las necesidades del kernel Lonas por Javilonas.
# Ahora Libera RAM a la vez que ejecuta el lowmemorykiller
#

/sbin/busybox renice 19 `pidof libera_ram.sh`
FREE=`free -m | grep -i mem | awk '{print $4}'`  

while [ 1 ];
do
        if [ $FREE -lt 8192 ]; then
                echo "2853,5632,24576,86016,96768,96768" > /sys/module/lowmemorykiller/parameters/minfree
                echo "111" > /proc/sys/vm/vfs_cache_pressure
                sync
                echo "3" > /proc/sys/vm/drop_caches
        else
                echo "2853,5166,12288,21920,38678,73216" > /sys/module/lowmemorykiller/parameters/minfree
                echo "111" > /proc/sys/vm/vfs_cache_pressure
                sync
                echo "3" > /proc/sys/vm/drop_caches
        fi
sleep 3
done
