#!/bin/bash
# Build Script: Javilonas, 14-12-2013
# Javilonas <admin@lonasdigital.com>

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

make distclean
make clean

echo "#################### Preparando Entorno ####################"
export KERNELDIR=`readlink -f .`
export RAMFS_SOURCE=`readlink -f $KERNELDIR/ramdisk`
export USE_SEC_FIPS_MODE=true

echo "kerneldir = $KERNELDIR"
echo "ramfs_source = $RAMFS_SOURCE"

if [ "${1}" != "" ];then
  export KERNELDIR=`readlink -f ${1}`
fi

TOOLCHAIN="/home/lonas/android/omni/prebuilts/gcc/linux-x86/arm/arm-eabi-4.7/bin/arm-eabi-"
TOOLCHAIN_PATCH="/home/lonas/android/omni/prebuilts/gcc/linux-x86/arm/arm-eabi-4.7/bin"
ROOTFS_PATH="/home/lonas/Kernel_Lonas/Lonas_KL-GT-I9300-Sammy/ramdisk"
RAMFS_TMP="/home/lonas/Kernel_Lonas/tmp/ramfs-source-sgs3"
CONFIG_LOCALVERSION="Lonas-KL-5.2"
VERSION_KL="Sammy"
REVISION="RC"

export KBUILD_BUILD_VERSION="3"

echo "ramfs_tmp = $RAMFS_TMP"

echo "#################### Eliminando build anterior ####################"
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -j`grep 'processor' /proc/cpuinfo | wc -l` mrproper

find -name '*.ko' -exec rm -rf {} \;
rm -rf $KERNELDIR/arch/arm/boot/zImage

echo "#################### Make defconfig ####################"
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN lonas_defconfig

# nice -n 10 make -j6 ARCH=arm CROSS_COMPILE=$TOOLCHAIN >> compile.log 2>&1 || exit -1

# make -j`grep 'processor' /proc/cpuinfo | wc -l` ARCH=arm CROSS_COMPILE=$TOOLCHAIN >> compile.log 2>&1 || exit -1

make -j`grep 'processor' /proc/cpuinfo | wc -l` ARCH=arm CROSS_COMPILE=$TOOLCHAIN || exit -1

mkdir -p $KERNELDIR/ramdisk/lib/modules
find . -name '*.ko' -exec cp -av {} $KERNELDIR/ramdisk/lib/modules/ \;
$TOOLCHAIN_PATCH/arm-eabi-strip --strip-unneeded $KERNELDIR/ramdisk/lib/modules/*.ko
#unzip /home/lonas/Kernel_Lonas/proprietary-modules/proprietary-modules.zip -d $KERNELDIR/ramdisk/lib/modules

echo "#################### Update Ramdisk ####################"
rm -f $KERNELDIR/releasetools/tar/$CONFIG_LOCALVERSION-$REVISION$KBUILD_BUILD_VERSION-$VERSION_KL.tar
rm -f $KERNELDIR/releasetools/zip/$CONFIG_LOCALVERSION-$REVISION$KBUILD_BUILD_VERSION-$VERSION_KL.zip
cp -f $KERNELDIR/arch/arm/boot/zImage .

rm -rf $RAMFS_TMP
rm -rf $RAMFS_TMP.cpio
rm -rf $RAMFS_TMP.cpio.gz
rm -rf $KERNELDIR/*.cpio
rm -rf $KERNELDIR/*.cpio.gz
cd $ROOTFS_PATH
cp -ax $ROOTFS_PATH $RAMFS_TMP
find $RAMFS_TMP -name .git -exec rm -rf {} \;
find $RAMFS_TMP -name EMPTY_DIRECTORY -exec rm -rf {} \;
find $RAMFS_TMP -name .EMPTY_DIRECTORY -exec rm -rf {} \;
rm -rf $RAMFS_TMP/tmp/*
rm -rf $RAMFS_TMP/.hg

echo "#################### Build Ramdisk ####################"
cd $RAMFS_TMP
find . | fakeroot cpio -o -H newc > $RAMFS_TMP.cpio 2>/dev/null
ls -lh $RAMFS_TMP.cpio
gzip -9 -f $RAMFS_TMP.cpio

echo "#################### Compilar Kernel ####################"
cd $KERNELDIR

nice -n 10 make -j6 ARCH=arm CROSS_COMPILE=$TOOLCHAIN zImage || exit 1

echo "#################### Generar boot.img ####################"
./mkbootimg --kernel $KERNELDIR/arch/arm/boot/zImage --ramdisk $RAMFS_TMP.cpio.gz --board smdk4x12 --base 0x10000000 --pagesize 2048 --ramdiskaddr 0x11000000 -o $KERNELDIR/boot.img

echo "#################### Preparando flasheables ####################"

cp boot.img $KERNELDIR/releasetools/zip
cp boot.img $KERNELDIR/releasetools/tar

cd $KERNELDIR
cd releasetools/zip
zip -0 -r $CONFIG_LOCALVERSION-$REVISION$KBUILD_BUILD_VERSION-$VERSION_KL.zip *
cd ..
cd tar
tar cf $CONFIG_LOCALVERSION-$REVISION$KBUILD_BUILD_VERSION-$VERSION_KL.tar boot.img && ls -lh $CONFIG_LOCALVERSION-$REVISION$KBUILD_BUILD_VERSION-$VERSION_KL.tar

echo "#################### Eliminando restos ####################"

rm $KERNELDIR/releasetools/zip/boot.img
rm $KERNELDIR/releasetools/tar/boot.img
rm $KERNELDIR/boot.img
rm $KERNELDIR/zImage
rm -rf /home/lonas/Kernel_Lonas/tmp/ramfs-source-sgs3
rm /home/lonas/Kernel_Lonas/tmp/ramfs-source-sgs3.cpio.gz
echo "#################### Terminado ####################"
