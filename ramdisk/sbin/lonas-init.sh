#!/sbin/busybox sh
#
# Script inicio lonas-init.sh
#

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

# Hacer root si no detecta bianrio SU
if [ ! -f /system/xbin/su ] && [ ! -f /system/bin/su ]; then

/sbin/busybox mkdir /system/bin/.ext
/sbin/busybox cp /sbin/su /system/xbin/su
/sbin/busybox cp /sbin/daemonsu /system/xbin/daemonsu
/sbin/busybox cp /sbin/su /system/bin/.ext/.su
/sbin/busybox cp /res/ext/install-recovery.sh /system/etc/install-recovery.sh
/sbin/busybox cp /res/ext/99SuperSUDaemon /system/etc/init.d/99SuperSUDaemon
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

/sbin/busybox chattr +i /system/xbin/su
/sbin/busybox chattr +i /system/bin/.ext/.su
/sbin/busybox chattr +i /system/xbin/daemonsu

/system/bin/sh /system/etc/install-recovery.sh

fi

# Detectar y generar INIT.D
/res/ext/init_d.sh

# Iniciar Bootanimation personalizado
/res/ext/bootanimation.sh

# Iniciar SQlite
/res/ext/sqlite.sh

# Iniciar Zipalign
/res/ext/zipalign.sh

# Iniciar Tweaks Lonas_KL
/res/ext/tweaks.sh

# Iniciar liberador de RAM
/res/ext/libera_ram.sh

# iniciar Usb Storage
/res/ext/usb_storage.sh

# Soporte Init.d
if [ -d /system/etc/init.d ]; then
  /sbin/busybox run-parts /system/etc/init.d
fi;

# Esperar a que termine de iniciar la ROM
while ! /sbin/busybox pgrep com.android.systemui ; do
/sbin/busybox sleep 1
done
/sbin/busybox sleep 10

/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,ro /system
