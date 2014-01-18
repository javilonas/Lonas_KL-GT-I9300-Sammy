#!/sbin/busybox sh
#
# Script autoroot.sh
#

if [ ! -f /system/xbin/su ] && [ ! -f /system/bin/su ]; then

mount -o remount,rw -t ext4 /dev/block/mmcblk0p9 /system

/sbin/busybox mkdir /system/bin/.ext
/sbin/busybox cp /sbin/su /system/xbin/su
/sbin/busybox cp /sbin/daemonsu /system/xbin/daemonsu
/sbin/busybox cp /sbin/su /system/bin/.ext/.su
/sbin/busybox cp /res/install-recovery.sh /system/etc/install-recovery.sh
/sbin/busybox echo /system/etc/.installed_su_daemon

/sbin/busybox chown 0.0 /system/bin/.ext
/sbin/busybox chmod 0777 /system/bin/.ext
/sbin/busybox chown 0.0 /system/xbin/su
/sbin/busybox chmod 6755 /system/xbin/su
/sbin/busybox chown 0.0 /system/xbin/daemonsu
/sbin/busybox chmod 6755 /system/xbin/daemonsu
/sbin/busybox chown 0.0 /system/bin/.ext/.su
/sbin/busybox chmod 6755 /system/bin/.ext/.su
/sbin/busybox chown 0.0 /system/etc/install-recovery.sh
/sbin/busybox chmod 0755 /system/etc/install-recovery.sh
/sbin/busybox chown 0.0 /system/etc/.installed_su_daemon
/sbin/busybox chmod 0644 /system/etc/.installed_su_daemon

/system/bin/sh /system/etc/install-recovery.sh

mount -o remount,ro -t ext4 /dev/block/mmcblk0p9 /system
fi
