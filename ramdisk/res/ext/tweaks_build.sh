#!sh
#
# Tweaks Build - by Javilonas
#

# Fix para problemas Con aplicaciones
/sbin/busybox setprop ro.kernel.android.checkjni 0

# Aumenta el rendimiento de la respuesta táctil
/sbin/busybox setprop debug.performance.tuning 1
/sbin/busybox setprop video.accelerate.hw 1
/sbin/busybox setprop debug.sf.hw 1
/sbin/busybox setprop windowsmgr.max_events_per_sec 100

# Incremento de memoria ram
/sbin/busybox setprop dalvik.vm.heapsize 148m

# Salvar bateria ahorrando en el wifi 
/sbin/busybox setprop wifi.supplicant_scan_interval 310
/sbin/busybox setprop ro.ril.disable.power.collapse 0
/sbin/busybox setprop pm.sleep_mode 1

# Conectar la llamada mas rápido después de marcar
/sbin/busybox setprop ro.telephony.call_ring.delay 1000

/sbin/busybox sysctl -p

/sbin/busybox sync
/sbin/busybox setprop cm.filesystem.ready 1

