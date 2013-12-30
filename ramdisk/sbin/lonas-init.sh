#!/sbin/busybox sh
#
# Script inicio lonas-init.sh
#

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

# Limpiador de otros kernel
/res/ext/limpiador.sh

# Remontar y Optimizar particiones con EXT4
/res/ext/optimi_remount.sh

# Iniciar SQlite
/res/ext/sqlite.sh

# Iniciar Zipalign
/res/ext/zipalign.sh

# Iniciar Tweaks Lonas_KL
/res/ext/tweaks.sh
/res/ext/tweaks_build.sh

# Iniciar Zram
/res/ext/zram.sh

/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,ro /system
