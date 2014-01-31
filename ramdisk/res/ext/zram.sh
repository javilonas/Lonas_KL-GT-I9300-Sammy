#!/sbin/busybox sh
#
# Zram 100Mb x 4 devices = 400Mb
#

#Zram0
/sbin/busybox swapoff /dev/block/zram0
echo 1 > /sys/block/zram0/reset
echo 104857600 > /sys/block/zram0/disksize
echo 1 > /sys/block/zram0/initstate
/sbin/busybox mkswap /dev/block/zram0
/sbin/busybox swapon -p 2 /dev/block/zram0

#Zram1
/sbin/busybox swapoff /dev/block/zram1
echo 1 > /sys/block/zram1/reset
echo 104857600 > /sys/block/zram1/disksize
echo 1 > /sys/block/zram1/initstate
/sbin/busybox mkswap /dev/block/zram1
/sbin/busybox swapon -p 2 /dev/block/zram1

#Zram2
/sbin/busybox swapoff /dev/block/zram2
echo 1 > /sys/block/zram2/reset
echo 104857600 > /sys/block/zram2/disksize
echo 1 > /sys/block/zram2/initstate
/sbin/busybox mkswap /dev/block/zram2
/sbin/busybox swapon -p 2 /dev/block/zram2

#Zram3
/sbin/busybox swapoff /dev/block/zram3
echo 1 > /sys/block/zram3/reset
echo 104857600 > /sys/block/zram3/disksize
echo 1 > /sys/block/zram3/initstate
/sbin/busybox mkswap /dev/block/zram3
/sbin/busybox swapon -p 2 /dev/block/zram3
