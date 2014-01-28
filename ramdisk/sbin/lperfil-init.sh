#!/sbin/busybox sh
#
# Script inicio LPerfilCC
#

# si la APP LPowerCC está instalada, no iniciamos el soporte para la APP LPerfilCC
if [ ! -f /system/app/LPowerCC.apk ] || [ ! -f /data/app/LPowerCC.apk ]; then

# Inicio lperfil-init.sh
/sbin/busybox mount -o remount,rw /system
/sbin/busybox mount -t rootfs -o remount,rw rootfs

# soporte LPerfilCC
/sbin/busybox rm /data/.lperfilcc/lperfilcc.xml
/sbin/busybox rm /data/.lperfilcc/action.cache

/res/init_uci2.sh select default
/res/init_uci2.sh apply

/sbin/busybox sync

/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,ro /system

fi

