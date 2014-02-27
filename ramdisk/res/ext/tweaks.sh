#!/sbin/busybox sh
#
# Tweaks - by Javilonas
#

# CACHE AUTO CLEAN
sync
echo "3" > /proc/sys/vm/drop_caches
sleep 1
echo "0" > /proc/sys/vm/drop_caches

# remount partitions with noatime
for k in $(mount | grep relatime | cut -d " " -f3);
do
mount -o remount,noatime,nodiratime,noauto_da_alloc,barrier=0 $k
done;

#disable cpuidle log
echo "0" > /sys/module/cpuidle_exynos4/parameters/log_en

# Tweak kernel scheduler, less aggressive settings
echo "384" > /proc/sys/kernel/random/write_wakeup_threshold
echo "384" > /proc/sys/kernel/random/read_wakeup_threshold
echo "500000" > /proc/sys/kernel/sched_min_granularity_ns
echo "1000000" > /proc/sys/kernel/sched_latency_ns
echo "100000" > /proc/sys/kernel/sched_wakeup_granularity_ns

# Miscellaneous tweaks
echo "524288" > /proc/sys/fs/file-max
echo "33000" > /proc/sys/fs/inotify/max_queued_events
echo "384" > /proc/sys/fs/inotify/max_user_instances
echo "10496" > /proc/sys/fs/inotify/max_user_watches
echo "0" > /proc/sys/vm/block_dump
echo "5" > /proc/sys/vm/laptop_mode
echo "0" > /proc/sys/vm/panic_on_oom 
echo "8" > /proc/sys/vm/page-cluster
echo "10" > /proc/sys/fs/lease-break-time
echo "65636" > /proc/sys/kernel/msgmni
echo "65636" > /proc/sys/kernel/msgmax
echo "512 512000 128 2048" > /proc/sys/kernel/sem
echo "268535456" > /proc/sys/kernel/shmmax
echo "525288" > /proc/sys/kernel/threads-max
echo "1" > /proc/sys/vm/oom_kill_allocating_task
 
# Tweaks internos
echo "2" > /sys/devices/system/cpu/sched_mc_power_savings
echo "0" > /proc/sys/kernel/randomize_va_space
echo "3" > /sys/module/cpuidle_exynos4/parameters/enable_mask

# pegasusq tweaks
echo "20000" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_rate
echo "10" > /sys/devices/system/cpu/cpufreq/pegasusq/cpu_up_rate
echo "10" > /sys/devices/system/cpu/cpufreq/pegasusq/cpu_down_rate
echo "500000" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_1_1
echo "400000" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_2_0
echo "800000" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_2_1
echo "600000" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_3_0
echo "800000" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_3_1
echo "600000" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_4_0
echo "200" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_1_1
echo "200" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_2_0
echo "300" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_2_1
echo "300" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_3_0
echo "400" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_3_1
echo "400" > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_4_0
echo "2" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_down_factor
echo "37" > /sys/devices/system/cpu/cpufreq/pegasusq/freq_step
echo "85" > /sys/devices/system/cpu/cpufreq/pegasusq/up_threshold
 
# IPv6 privacy tweak
echo "2" > /proc/sys/net/ipv6/conf/all/use_tempaddr
 
# TCP tweaks
echo "0" > /proc/sys/net/ipv4/tcp_timestamps;
echo "1" > /proc/sys/net/ipv4/tcp_tw_reuse;
echo "1" > /proc/sys/net/ipv4/tcp_sack;
echo "1" > /proc/sys/net/ipv4/tcp_tw_recycle;
echo "1" > /proc/sys/net/ipv4/tcp_window_scaling;
echo "2" > /proc/sys/net/ipv4/tcp_syn_retries;
echo "2" > /proc/sys/net/ipv4/tcp_synack_retries;
echo "5" > /proc/sys/net/ipv4/tcp_keepalive_probes;
echo "10" > /proc/sys/net/ipv4/tcp_keepalive_intvl;
echo "10" > /proc/sys/net/ipv4/tcp_fin_timeout;
echo "524488" > /proc/sys/net/core/wmem_max;
echo "524488" > /proc/sys/net/core/rmem_max;
echo "262244" > /proc/sys/net/core/rmem_default;
echo "262244" > /proc/sys/net/core/wmem_default;
echo "6244 87480 524488" > /proc/sys/net/ipv4/tcp_wmem;
echo "6244 87480 524488" > /proc/sys/net/ipv4/tcp_rmem;

LOOP=`ls -d /sys/block/loop*`
RAM=`ls -d /sys/block/ram*`
MMC=`ls -d /sys/block/mmc*`
ZSWA=`ls -d /sys/block/vnswap*`

for i in $LOOP $RAM $MMC $ZSWA
do 
echo "row" > $i/queue/scheduler
echo "0" > $i/queue/add_random
echo "0" > $i/queue/rotational
echo "8192" > $i/queue/nr_requests
echo "0" > $i/queue/iostats
echo "1" > $i/queue/rq_affinity
echo "1" > $i/queue/iosched/back_seek_penalty
echo "2" > $i/queue/iosched/slice_idle
echo "1" > $i/queue/iosched/low_latency

done

# Turn off debugging for certain modules
echo "0" > /sys/module/wakelock/parameters/debug_mask
echo "0" > /sys/module/userwakelock/parameters/debug_mask
echo "0" > /sys/module/earlysuspend/parameters/debug_mask
echo "0" > /sys/module/alarm/parameters/debug_mask
echo "0" > /sys/module/alarm_dev/parameters/debug_mask
echo "0" > /sys/module/binder/parameters/debug_mask
echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
echo "0" > /sys/module/mali/parameters/mali_debug_level
echo "0" > /sys/module/ump/parameters/ump_debug_level
echo "0" > /sys/module/kernel/parameters/initcall_debug
echo "0" > /sys/module/xt_qtaguid/parameters/debug_mask

# Otros Misc tweaks
/sbin/busybox mount -t debugfs none /sys/kernel/debug
echo NO_NORMALIZED_SLEEPER > /sys/kernel/debug/sched_features
echo NO_GENTLE_FAIR_SLEEPERS > /sys/kernel/debug/sched_features
echo NO_START_DEBIT > /sys/kernel/debug/sched_features
echo NO_WAKEUP_PREEMPT > /sys/kernel/debug/sched_features
echo NEXT_BUDDY > /sys/kernel/debug/sched_features
echo ARCH_POWER > /sys/kernel/debug/sched_features
echo SYNC_WAKEUPS > /sys/kernel/debug/sched_features
echo HRTICK > /sys/kernel/debug/sched_features

# Fix para problemas Con aplicaciones
/sbin/busybox setprop ro.kernel.android.checkjni 0

# Incremento de memoria ram
/sbin/busybox setprop dalvik.vm.heapstartsize 6m
/sbin/busybox setprop dalvik.vm.heapgrowthlimit 48m
/sbin/busybox setprop dalvik.vm.heapsize 148m

/sbin/busybox setprop video.accelerate.hw 1
/sbin/busybox setprop persist.sys.use_dithering 0
/sbin/busybox setprop debug.egl.profiler 1
/sbin/busybox setprop debug.egl.hw 1
/sbin/busybox setprop debug.composition.type gpu
/sbin/busybox setprop persist.sys.ui.hw 1
/sbin/busybox setprop debug.sf.hw 1
/sbin/busybox setprop windowsmgr.max_events_per_sec 130

/sbin/busybox setprop ro.HOME_APP_ADJ -17

