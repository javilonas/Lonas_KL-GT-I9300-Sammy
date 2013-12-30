#!/sbin/busybox sh

zram_size=100

	if [ $zram_size -gt 0 ]; then
		echo `expr $zram_size \* 1024 \* 1024` > /sys/devices/virtual/block/zram0/disksize
		mkswap /dev/block/zram0 > /dev/null 2>&1
		swapon /dev/block/zram0 > /dev/null 2>&1
                echo `expr $zram_size \* 1024 \* 1024` > /sys/devices/virtual/block/zram1/disksize
		mkswap /dev/block/zram1 > /dev/null 2>&1
		swapon /dev/block/zram1 > /dev/null 2>&1
                echo `expr $zram_size \* 1024 \* 1024` > /sys/devices/virtual/block/zram2/disksize
		mkswap /dev/block/zram2 > /dev/null 2>&1
		swapon /dev/block/zram2 > /dev/null 2>&1
                echo `expr $zram_size \* 1024 \* 1024` > /sys/devices/virtual/block/zram3/disksize
		mkswap /dev/block/zram3 > /dev/null 2>&1
		swapon /dev/block/zram3 > /dev/null 2>&1
	fi
