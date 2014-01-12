#!/sbin/busybox sh
#
# Bootanimations - by Javilonas
#

if [ -f /data/local/bootanimation.zip ] || [ -f /system/media/bootanimation.zip ]; then
        /sbin/bootanimation &
fi
