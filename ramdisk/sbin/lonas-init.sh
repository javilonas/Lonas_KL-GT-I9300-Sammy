#!/sbin/busybox sh
#
# Script inicio lonas-init.sh
#

# If rom comes without mount command in /system/bin folder, create busybox symlinks for mount/umount
if [ ! -f /system/bin/mount ]; then
/sbin/busybox mount -o remount,rw rootfs /
/sbin/busybox ln /sbin/busybox /sbin/mount
/sbin/busybox ln /sbin/busybox /sbin/umount
/sbin/busybox mount -o remount,ro rootfs /
fi

# Correct /sbin and /res directory and file permissions
/sbin/busybox mount -o remount,rw rootfs /

# change permissions of /sbin folder and scripts in /res/bc
/sbin/busybox chmod -R 755 /sbin
/sbin/busybox chmod 755 /res/ext/*

/sbin/busybox sync
/sbin/busybox mount -o remount,ro rootfs /

sync

sleep 1

# Inicio lonas-init.sh
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

# Limpiador de otros kernel
/res/ext/limpiador.sh

# Detectar y generar INIT.D
/res/ext/init_d.sh

# Iniciar Bootanimation personalizado
/res/ext/bootanimation.sh

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

# Iniciar libera_ram
/res/ext/libera_ram.sh

# iniciar Usb Storage
/res/ext/usb_storage.sh

# soporte LPowerCC
/sbin/busybox rm /data/.lpowercc/lpowercc.xml
/sbin/busybox rm /data/.lpowercc/action.cache

sync

/res/init_uci.sh apply

if [ -d /system/etc/init.d ]; then
  /sbin/busybox run-parts /system/etc/init.d
fi;

/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,ro /system
