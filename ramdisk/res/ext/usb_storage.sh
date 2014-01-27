#!/sbin/busybox sh

/sbin/busybox umount -l /mnt/extSdCard/
/system/bin/setprop persist.sys.usb.config mass_storage,adb
/sbin/busybox echo /dev/block/vold/179:49 > /sys/devices/platform/s3c-usbgadget/gadget/lun0/file
