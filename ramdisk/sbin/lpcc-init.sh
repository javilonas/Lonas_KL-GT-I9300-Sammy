#!/sbin/busybox sh
#
# Script inicio LPowerCC
#

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
/sbin/busybox sleep 3
