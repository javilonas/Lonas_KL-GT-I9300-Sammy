#!/bin/bash

TOOLCHAIN="/home/lonas/Kernel_Lonas/toolchains/android-ndk-r9c/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86/bin/arm-linux-androideabi-"
DIR="/home/lonas/Kernel_Lonas/Lonas_KL-GT-I9300-Sammy"

echo "#################### Eliminando Restos ####################"
if [ -e boot.img ]; then
	rm boot.img
fi

if [ -e compile.log ]; then
	rm compile.log
fi

if [ -e ramdisk.cpio ]; then
	rm ramdisk.cpio
fi

if [ -e ramdisk.cpio.gz ]; then
        rm ramdisk.cpio.gz
fi

# make distclean
make clean

echo "ramfs_tmp = $RAMFS_TMP"

echo "#################### Eliminando build anterior ####################"

echo "Cleaning latest build"
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -j`grep 'processor' /proc/cpuinfo | wc -l` mrproper

find -name '*.ko' -exec rm -rf {} \;
rm -f $DIR/releasetools/tar/*.tar
rm -f $DIR/releasetools/zip/*.zip
rm -rf $DIR/arch/arm/boot/zImage
