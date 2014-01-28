#!/sbin/busybox sh
#
# Script inicio LPowerCC
#

# si la APP LPerfilCC está instalada, no iniciamos el soporte para la APP LPowerCC
if [ ! -f /system/app/LPerfilCC.apk ] || [ ! -f /data/app/LPerfilCC.apk ]; then

# Inicio lpcc-init.sh
/sbin/busybox mount -o remount,rw /system
/sbin/busybox mount -t rootfs -o remount,rw rootfs

# soporte LPowerCC
/sbin/busybox rm /data/.lpowercc/lpowercc.xml
/sbin/busybox rm /data/.lpowercc/action.cache

/res/init_uci.sh select default
/res/init_uci.sh apply

/sbin/busybox sync

/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,ro /system

fi
