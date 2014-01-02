#!/sbin/busybox sh
#
# Bootanimations 2.0 - by Javilonas
#

if /sbin/busybox [ -f /data/local/bootanimation.zip ] || /sbin/busybox [ -f /system/media/bootanimation.zip ]; then
        /sbin/bootanimation &
else
        /system/bin/bootanimation &
fi
