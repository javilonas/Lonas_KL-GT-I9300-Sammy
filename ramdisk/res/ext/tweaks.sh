#!/sbin/busybox sh
#
# Tweaks - by Javilonas
#

# CACHE AUTO CLEAN
sync
echo "3" > /proc/sys/vm/drop_caches
sleep 1
echo "0" > /proc/sys/vm/drop_caches

# Tweak kernel scheduler, less aggressive settings
echo "256" > /proc/sys/kernel/random/write_wakeup_threshold
echo "128" > /proc/sys/kernel/random/read_wakeup_threshold
echo "18000000" > /proc/sys/kernel/sched_latency_ns
echo "3000000" > /proc/sys/kernel/sched_wakeup_granularity_ns
echo "1500000" > /proc/sys/kernel/sched_min_granularity_ns

# Miscellaneous tweaks
echo "80" > /proc/sys/vm/swappiness
echo "524288" > /proc/sys/fs/file-max
echo "32000" > /proc/sys/fs/inotify/max_queued_events
echo "256" > /proc/sys/fs/inotify/max_user_instances
echo "10240" > /proc/sys/fs/inotify/max_user_watches
echo "0" > /proc/sys/vm/block_dump
echo "0" > /proc/sys/vm/laptop_mode
echo "0" > /proc/sys/vm/panic_on_oom 
echo "1" > /proc/sys/vm/page-cluster
echo "10" > /proc/sys/fs/lease-break-time
echo "2048" > /proc/sys/kernel/msgmni
echo "65536" > /proc/sys/kernel/msgmax
echo "500 512000 64 2048" > /proc/sys/kernel/sem
echo "268435456" > /proc/sys/kernel/shmmax
echo "524288" > /proc/sys/kernel/threads-max
echo "1" > /proc/sys/vm/oom_kill_allocating_task
 
# Tweaks internos
echo "2" > /sys/devices/system/cpu/sched_mc_power_savings
echo "0" > /proc/sys/kernel/randomize_va_space
echo "3" > /sys/module/cpuidle_exynos4/parameters/enable_mask
 
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
echo "524288" > /proc/sys/net/core/wmem_max;
echo "524288" > /proc/sys/net/core/rmem_max;
echo "262144" > /proc/sys/net/core/rmem_default;
echo "262144" > /proc/sys/net/core/wmem_default;
echo "6144 87380 524288" > /proc/sys/net/ipv4/tcp_wmem;
echo "6144 87380 524288" > /proc/sys/net/ipv4/tcp_rmem;

LOOP=`ls -d /sys/block/loop*`
RAM=`ls -d /sys/block/ram*`
MMC=`ls -d /sys/block/mmc*`
ZRM=`ls -d /sys/block/zram*`

for i in $LOOP $RAM $MMC $ZRM
do 
echo "row" > $i/queue/scheduler
echo "0" > $i/queue/add_random
echo "0" > $i/queue/rotational
echo "8192" > $i/queue/nr_requests
echo "0" > $i/queue/iostats
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

