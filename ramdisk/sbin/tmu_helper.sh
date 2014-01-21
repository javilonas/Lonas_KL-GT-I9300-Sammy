#!/res/busybox sh

export PATH=/sbin

MAX_FREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)

echo "$MAX_FREQ" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
