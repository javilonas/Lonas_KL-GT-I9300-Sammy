#!/sbin/busybox sh
#
# Limpiador cache- by Javilonas
#

#remove cache, tmp, and unused files
/sbin/busybox rm -f /cache/*.apk
/sbin/busybox rm -f /cache/*.tmp
/sbin/busybox rm -f /data/dalvik-cache/*.apk
/sbin/busybox rm -f /data/dalvik-cache/*.tmp

