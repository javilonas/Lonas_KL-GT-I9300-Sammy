#!/sbin/busybox sh
#
# Script inicio LPowerCC
#

# Inicio lpcc-init.sh
/sbin/busybox mount -o remount,rw /system
/sbin/busybox mount -t rootfs -o remount,rw rootfs

if [ ! -f /system/xbin/busybox ]; then
/sbin/busybox ln -s /sbin/busybox /system/xbin/busybox
/sbin/busybox ln -s /sbin/busybox /system/xbin/pkill
fi

if [ ! -f /system/bin/busybox ]; then
/sbin/busybox ln -s /sbin/busybox /system/bin/busybox
/sbin/busybox ln -s /sbin/busybox /system/bin/pkill
fi

# Instalador de LPowerCC.apk
if [ ! -f /system/app/LPowerCC.apk ]; then
  cat /res/LPowerCC.apk > /system/app/LPowerCC.apk
/sbin/busybox chown 0.0 /system/app/LPowerCC.apk
/sbin/busybox chmod 644 /system/app/LPowerCC.apk
fi

# soporte LPowerCC
/sbin/busybox rm /data/.lpowercc/lpowercc.xml
/sbin/busybox rm /data/.lpowercc/action.cache

/res/init_uci.sh select default
/res/init_uci.sh apply

/sbin/busybox sync

/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,ro /system
