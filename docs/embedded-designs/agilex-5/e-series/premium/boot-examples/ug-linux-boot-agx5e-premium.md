##  Introduction

### Overview

This page contains instructions on how to build Linux systems from separate components: Hardware Design, U-Boot, Arm Trusted Firmware, Linux kernel and device tree, Linux root filesystem. This is different from the Golden System Reference Design, where all the software is built through Yocto. While the instructions use Yocto for building the root file system, alternatives could be used there, such as the buildroot utility for example.

The following scenarios are covered:

* HPS Enablement Board: boot from SD card, and boot from QSPI
* HPS NAND Board: boot from eMMC flash
* HPS Test Board: boot from SD card

The instructions on this page are based on the [GSRD](../../gsrd/ug-gsrd-agx5e-premium).

### Prerequisites

The following are required to be able to fully exercise the guides from this page:

* Altera Agilex 5 FPGA E-Series 065B Premium Development Kit, ordering code DK-A5E065BB32AES1. Refer to [board documentation](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a5e065b-premium.html) for more information about the development kit.
  * HPS Enablement  Expansion Board. Included with the development kit
  * HPS NAND Board. Enables eMMC storage for HPS. Orderable separately
  * HPS Test Board. Supports SD card boot, and external Arm tracing. Orderable separately
  * Mini USB Cable. Included with the development kit
  * Micro USB Cable. Included with the development kit
  * Ethernet Cable. Included with the development kit
  * Micro SD card and USB card writer. Included with the development kit
* Host PC with
  * 64 GB of RAM. Less will be fine for only exercising the binaries, and not rebuilding the GSRD.
  * Linux OS installed. Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too
  * Serial terminal (for example GtkTerm or Minicom on Linux and TeraTerm or PuTTY on Windows)
  * Intel Quartus Prime Pro Edition version 24.1. Used to recompile the hardware design. If only writing binaris is required, then the smaller Intel Quartus Prime Pro Edition Programmer version 24.1 is sufficient.
  * TFTP server. This used to download the eMMC binaries to board to be flashed by U-Boot
* Local Ethernet network, with DHCP server
* Internet connection. For downloading the files.

### Component Versions

The instructions on this page use the following component versions:

| Component | Location | Branch | Commit ID/Tag |
| :-- | :-- | :-- | :-- |
| GHRD | [https://github.com/altera-opensource/ghrd-socfpga](https://github.com/altera-opensource/ghrd-socfpga) | master | QPDS24.1_REL_AGILEX5_GSRD_PR |
| Linux | [https://github.com/altera-opensource/linux-socfpga](https://github.com/altera-opensource/linux-socfpga) | socfpga-6.1.68-lts | QPDS24.1_REL_AGILEX5_GSRD_PR |
| Arm Trusted Firmware | [https://github.com/altera-opensource/arm-trusted-firmware](https://github.com/altera-opensource/arm-trusted-firmware) | socfpga_v2.10.0 | QPDS24.1_REL_AGILEX5_GSRD_PR |
| U-Boot | [https://github.com/altera-opensource/u-boot-socfpga](https://github.com/altera-opensource/u-boot-socfpga) | socfpga_v2023.10   | QPDS24.1_REL_AGILEX5_GSRD_PR |
| Yocto Project: poky | [https://git.yoctoproject.org/poky](https://git.yoctoproject.org/poky) | nanbield | latest |
| Yocto Project: meta-intel-fpga | [https://git.yoctoproject.org/meta-intel-fpga](https://git.yoctoproject.org/meta-intel-fpga) | nanbield | QPDS24.1_REL_AGILEX5_GSRD_PR |

### Development Kit

Refer to [Development Kit](../../gsrd/ug-gsrd-agx5e-premium/#development-kit) for details about the board, including how to install the HPS Boards, and how to set MSEL dispswitches.

### Release Notes

Refer to [Release Notes](../../gsrd/ug-gsrd-agx5e-premium/#release-contents) for release readiness information and known issues.


## HPS Enablement Board

This section demonstrates how to build a Linux system from separate components, targetting the HPS Enablement Board. Both booting from SD card and booting from QSPI are covered.


### Boot from SD Card 
<!--{"type":"recipe", "name":"Bootloader.Enablement", "results":["$TOP_FOLDER/ghrd.hps.jic","$TOP_FOLDER/ghrd.hps.rbf","$TOP_FOLDER/sd_card/sdcard.img","$TOP_FOLDER/qspi-boot/flash_image.hps.jic"],"TOP_FOLDER":"artifacts.enablement", "board_keywords":["DK-A5E065BB32AES1","eMMC"], "test_commands":["write-sd=$TOP_FOLDER/sd_card/sdcard.img","write-jic=$TOP_FOLDER/ghrd.hps.jic","boot-linux-qspi","wipe-sd","write-jic=$TOP_FOLDER/qspi-boot/flash_image.hps.jic","boot-linux-qspi"]}-->

<h4>Setup Environment</h4>
<!--{"type":"step", "name":"Setup Environment"}-->

1\. Create the top folder to store all the build artifacts:
<!--{"type":"code" }-->

```bash
sudo rm -rf artifacts.enablement
mkdir artifacts.enablement
cd artifacts.enablement
export TOP_FOLDER=`pwd`
```
<!--{"type":"/code" }-->
2\. Download and setup the build toolchain. It will be used only by the GHRD makefile to build the debug HPS FSBL, to build the _hps_debug.sof file:
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel\
/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
```
<!--{"type":"/code" }-->
3\. Set up the Quartus tools in the PATH, so they are accessible without full path
<!--{"type":"code" }-->

```bash
export QUARTUS_ROOTDIR=~/intelFPGA_pro/24.1/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```
<!--{"type":"/code" }-->
<!--{"type":"/step" }-->

<h4>Build Hardware Design</h4>
<!--{"type":"step", "name":"Build Hardware Design", "results":["$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof","$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0_hps_debug.sof"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf ghrd-socfpga agilex5_soc_devkit_ghrd
git clone -b QPDS24.1_REL_AGILEX5_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga
mv ghrd-socfpga/agilex5_soc_devkit_ghrd .
rm -rf ghrd-socfpga
cd agilex5_soc_devkit_ghrd
make config
make DEVICE=A5ED065BB32AE6SR0 HPS_EMIF_MEM_CLK_FREQ_MHZ=800 HPS_EMIF_REF_CLK_FREQ_MHZ=100 generate_from_tcl
make all
cd ..
```
<!--{"type":"/code" }-->
The following files are created:

* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof`
* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0_hps_debug.sof`
<!--{"type":"/step" }-->

<h4>Build Arm Trusted Firmware</h4>
<!--{"type":"step", "name":"Build Arm Trusted Firmware", "results":["$TOP_FOLDER/arm-trusted-firmware/build/agilex5/release/bl31.bin"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf arm-trusted-firmware
git clone https://github.com/altera-opensource/arm-trusted-firmware
cd arm-trusted-firmware
git checkout -b test -t origin/socfpga_v2.10.0
make -j 48 PLAT=agilex5 bl31 
cd ..
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/arm-trusted-firmware/build/agilex5/release/bl31.bin`
<!--{"type":"/step" }-->


<h4>Build U-Boot</h4>
<!--{"type":"step", "name":"Build U-Boot", "results":["$TOP_FOLDER/u-boot-socfpga/u-boot.itb","$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf u-boot-socfpga v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
wget https://raw.githubusercontent.com/altera-opensource/meta-intel-fpga-refdes/QPDS24.1_REL_AGILEX5_GSRD_PR/recipes-bsp/u-boot/files/v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
git clone https://github.com/altera-opensource/u-boot-socfpga
cd u-boot-socfpga 
git checkout -b test -t origin/socfpga_v2023.10
patch -p1 < ../v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
# enable dwarf4 debug info, for compatibility with arm ds
sed -i 's/PLATFORM_CPPFLAGS += -D__ARM__/PLATFORM_CPPFLAGS += -D__ARM__ -gdwarf-4/g' arch/arm/config.mk
# only boot from SD, do not try QSPI and NAND
sed -i 's/u-boot,spl-boot-order.*/u-boot\,spl-boot-order = \&mmc;/g' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# disable NAND in the device tree
sed -i '/&nand {/!b;n;c\\tstatus = "disabled";' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# link to atf
ln -s ../arm-trusted-firmware/build/agilex5/release/bl31.bin 
# create configuration custom file. 
cat << EOF > config-fragment
# use Image instead of kernel.itb
CONFIG_BOOTFILE="Image"
# disable NAND/UBI related settings from defconfig. 
CONFIG_NAND_BOOT=n
CONFIG_SPL_NAND_SUPPORT=n
CONFIG_CMD_NAND_TRIMFFS=n
CONFIG_CMD_NAND_LOCK_UNLOCK=n
CONFIG_NAND_DENALI_DT=n
CONFIG_SYS_NAND_U_BOOT_LOCATIONS=n
CONFIG_SPL_NAND_FRAMEWORK=n
CONFIG_CMD_NAND=n
CONFIG_MTD_RAW_NAND=n
CONFIG_CMD_UBI=n
CONFIG_CMD_UBIFS=n
CONFIG_MTD_UBI=n
CONFIG_ENV_IS_IN_UBI=n
CONFIG_UBI_SILENCE_MSG=n
CONFIG_UBIFS_SILENCE_MSG=n
# disable distroboot and use specific boot command. 
CONFIG_DISTRO_DEFAULTS=n
CONFIG_HUSH_PARSER=y
CONFIG_SYS_PROMPT_HUSH_PS2="> "
CONFIG_USE_BOOTCOMMAND=y
CONFIG_BOOTCOMMAND="load mmc 0:1 \${loadaddr} ghrd.core.rbf; fpga load 0 \${loadaddr} \${filesize};bridge enable; mmc rescan; fatload mmc 0:1 82000000 Image;fatload mmc 0:1 86000000 socfpga_agilex5_socdk.dtb;setenv bootargs console=ttyS0,115200 root=\${mmcroot} rw rootwait;booti 0x82000000 - 0x86000000"
CONFIG_CMD_FAT=y
CONFIG_CMD_FS_GENERIC=y
CONFIG_DOS_PARTITION=y
CONFIG_SPL_DOS_PARTITION=y
CONFIG_CMD_PART=y
CONFIG_SPL_CRC32=y
CONFIG_LZO=y
CONFIG_CMD_DHCP=y
# enable more QSPI flash manufacturers
CONFIG_SPI_FLASH_MACRONIX=y
CONFIG_SPI_FLASH_GIGADEVICE=y
CONFIG_SPI_FLASH_WINBOND=y
CONFIG_SPI_FLASH_ISSI=y
EOF
# build U-Boot
make clean && make mrproper
make socfpga_agilex5_defconfig 
# use created custom configuration file to merge with the default configuration obtained in .config file. 
./scripts/kconfig/merge_config.sh -O . -m .config config-fragment
make -j 64
cd ..
```
<!--{"type":"/code" }-->
The following files are created:

* `$TOP_FOLDER/u-boot-socfpga/u-boot.itb`
* `$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex`
<!--{"type":"/step" }-->

<h4>Build QSPI Image</h4>
<!--{"type":"step", "name":"Build QSPI Image", "results":["$TOP_FOLDER/ghrd.hps.jic"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
quartus_pfg -c agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof ghrd.jic \
-o device=MT25QU128 \
-o flash_loader=A5ED065BB32AE6SR0 \
-o hps_path=$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex \
-o mode=ASX4 \
-o hps=1

```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/ghrd.hps.jic`
<!--{"type":"/step" }-->

<h4>Build HPS RBF</h4>
<!--{"type":"step", "name":"Build HPS RBF", "results":["$TOP_FOLDER/ghrd.hps.rbf"]}-->
This is an optional step, in which you can build an HPS RBF file, which can be used to configure the HPS through JTAG instead of QSPI though the JIC file.
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
quartus_pfg -c agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof ghrd.rbf \
-o hps_path=$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex \
-o hps=1
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/ghrd.hps.rbf
<!--{"type":"/step" }-->


<h4>Build Linux</h4>
<!--{"type":"step", "name":"Build Linux", "results":["$TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image","$TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dtb"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf linux-socfpga
git clone https://github.com/altera-opensource/linux-socfpga
cd linux-socfpga
git checkout -b test -t origin/socfpga-6.1.68-lts
make defconfig 
make -j 64 Image && make intel/socfpga_agilex5_socdk.dtb 
```
<!--{"type":"/code" }-->
The following files are created:

* `$TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dtb`
* `$TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image`
<!--{"type":"/step" }-->

<h4>Build Rootfs</h4>
<!--{"type":"step", "name":"Build Rootfs", "results":["$TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_devkit/core-image-minimal-agilex5_devkit.rootfs.tar.gz"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf yocto && mkdir yocto && cd yocto
git clone -b nanbield https://git.yoctoproject.org/poky
git clone -b nanbield https://git.yoctoproject.org/meta-intel-fpga
git clone -b nanbield https://github.com/openembedded/meta-openembedded
source poky/oe-init-build-env ./build
echo 'MACHINE = "agilex5_devkit"' >> conf/local.conf
echo 'BBLAYERS += " ${TOPDIR}/../meta-intel-fpga "' >> conf/bblayers.conf
echo 'BBLAYERS += " ${TOPDIR}/../meta-openembedded/meta-oe "' >> conf/bblayers.conf
echo 'CORE_IMAGE_EXTRA_INSTALL += "openssh gdbserver"' >> conf/local.conf
bitbake core-image-minimal
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_devkit/core-image-minimal-agilex5_devkit.rootfs.tar.gz`
<!--{"type":"/step" }-->


<h4>Create SD Card Image</h4>
<!--{"type":"step", "name":"Create SD Card Image", "results":["$TOP_FOLDER/sd_card/sdcard.img"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
sudo rm -rf sd_card && mkdir sd_card && cd sd_card
wget https://releases.rocketboards.org/release/2020.11/gsrd/tools/make_sdimage_p3.py
sed -i 's/\"\-F 32\",//g' make_sdimage_p3.py
chmod +x make_sdimage_p3.py
mkdir fatfs &&  cd fatfs
cp $TOP_FOLDER/ghrd.core.rbf .
cp $TOP_FOLDER/u-boot-socfpga/u-boot.itb .
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image .
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dtb .
cd ..
mkdir rootfs && cd rootfs
sudo tar xf $TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_devkit/core-image-minimal-agilex5_devkit.rootfs.tar.gz
cd ..
sudo python3 make_sdimage_p3.py -f \
-P fatfs/*,num=1,format=fat32,size=64M \
-P rootfs/*,num=2,format=ext3,size=64M \
-s 140M \
-n sdcard.img
cd ..
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/sd_card/sdcard.img`

<h4>Write SD Card</h4>

Write the SD card image `sd_card/sdimage.img` to the micro SD card using the included USB writer, and `dd` utility on Linux, or  Win32DiskImager on Windows, available at [https://win32diskimager.org/](https://win32diskimager.org/).

<h4>Write QSPI Flash</h4>

1\. Power down board

2\. Set MSEL dipswitch SW27 to JTAG: OFF-OFF-OFF-OFF

3\. Power up the board

4\. Write JIC image to QSPI:

```bash
cd $TOP_FOLDER
quartus_pgm -c 1 -m jtag -o "pvi;ghrd.hps.jic"
```

<h4>Boot Linux</h4>

1\. Power down board

2\. Set MSEL dipswitch SW27 to QSPI: OFF-ON-ON-OFF

3\. Power up the board

4\. Wait for Linux to boot, use `root` as user name, and no password wil be requested.

<!--{"type":"/step" }-->

### Boot from QSPI
<!--{"type":"step", "name":"Boot From QSPI", "results":["$TOP_FOLDER/qspi-boot/flash_image.hps.jic"]}-->

This section presents how to build the binaries and boot from QSPI with the HPS Enablement Board.
While the example is based on the GSRD, it contains the following differences:

* U-Boot tries to boot only from QSPI flash, does not try SD card
* U-Boot does not use a script to boot, instead it used the `BOOTCMD` environment variable directly
* kernel.itb file contains only one set of core.rbf, kernel and device tree files, targeted for this scenario

1\. Prepare the top folder
<!--{"type":"code" }-->
```bash
rm -rf $TOP_FOLDER/qspi-boot
mkdir $TOP_FOLDER/qspi-boot
```
<!--{"type":"/code" }-->

2\. Build U-Boot:

<!--{"type":"code" }-->
```bash
cd $TOP_FOLDER/qspi-boot
rm -rf u-boot-socfpga v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
wget https://raw.githubusercontent.com/altera-opensource/meta-intel-fpga-refdes/QPDS24.1_REL_AGILEX5_GSRD_PR/recipes-bsp/u-boot/files/v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
git clone https://github.com/altera-opensource/u-boot-socfpga
cd u-boot-socfpga 
git checkout -b test -t origin/socfpga_v2023.10
patch -p1 < ../v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
# enable dwarf4 debug info, for compatibility with arm ds
sed -i 's/PLATFORM_CPPFLAGS += -D__ARM__/PLATFORM_CPPFLAGS += -D__ARM__ -gdwarf-4/g' arch/arm/config.mk
# only boot from QSPI
sed -i 's/u-boot,spl-boot-order.*/u-boot\,spl-boot-order = \&flash0;/g' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# disable NAND in the device tree
sed -i '/&nand {/!b;n;c\\tstatus = "disabled";' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# link to atf
ln -s $TOP_FOLDER/arm-trusted-firmware/build/agilex5/release/bl31.bin 
# create configuration custom file. 
cat << EOF > config-fragment
# mtd info
CONFIG_MTDIDS_DEFAULT="nor0=nor0"
CONFIG_MTDPARTS_DEFAULT="mtdparts=nor0:66m(u-boot),190m(root)"
# use Image instead of kernel.itb
CONFIG_BOOTFILE="Image"
# do not keep env on sd card
CONFIG_ENV_IS_IN_FAT=n
# disable NAND related settings from defconfig
CONFIG_NAND_BOOT=n
CONFIG_SPL_NAND_SUPPORT=n
CONFIG_CMD_NAND_TRIMFFS=n
CONFIG_CMD_NAND_LOCK_UNLOCK=n
CONFIG_NAND_DENALI_DT=n
CONFIG_SYS_NAND_U_BOOT_LOCATIONS=n
CONFIG_SPL_NAND_FRAMEWORK=n
CONFIG_CMD_NAND=n
CONFIG_MTD_RAW_NAND=n
# disable distroboot and use specific boot command. 
CONFIG_DISTRO_DEFAULTS=n
CONFIG_HUSH_PARSER=y
CONFIG_SYS_PROMPT_HUSH_PS2="> "
CONFIG_USE_BOOTCOMMAND=y
CONFIG_BOOTCOMMAND="mtdparts;ubi part root;ubi readvol \${loadaddr} kernel;ubi detach;setenv bootargs earlycon panic=-1 ubi.mtd=1 root=ubi0:rootfs rootfstype=ubifs rw rootwait;bootm \${loadaddr}#board-0;"
CONFIG_CMD_FAT=y
CONFIG_CMD_FS_GENERIC=y
CONFIG_DOS_PARTITION=y
CONFIG_SPL_DOS_PARTITION=y
CONFIG_CMD_PART=y
CONFIG_SPL_CRC32=y
CONFIG_LZO=y
CONFIG_CMD_DHCP=y
# enable more QSPI flash manufacturers
CONFIG_SPI_FLASH_MACRONIX=y
CONFIG_SPI_FLASH_GIGADEVICE=y
CONFIG_SPI_FLASH_WINBOND=y
CONFIG_SPI_FLASH_ISSI=y
EOF
# build U-Boot
make clean && make mrproper
make socfpga_agilex5_defconfig 
# use created custom configuration file to merge with the default configuration obtained in .config file. 
./scripts/kconfig/merge_config.sh -O . -m .config config-fragment
make -j 64
cd ..
```
<!--{"type":"/code" }-->
The following files are created:

* `$TOP_FOLDER/qspi-boot/u-boot-socfpga/u-boot.itb`
* `$TOP_FOLDER/qspi-boot/u-boot-socfpga/spl/u-boot-spl-dtb.hex`

3\. Build `kernel.itb` FIT file containing kernel, device tree and fpga fabric configuration file:

<!--{"type":"code" }-->
```bash
cd $TOP_FOLDER/qspi-boot
rm -f core.rbf devicetree.dtb Image.lzma kernel.its kernel.itb
ln -s ../ghrd.core.rbf core.rbf
ln -s ../linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dtb devicetree.dtb
xz --format=lzma --extreme -k -c ../linux-socfpga/arch/arm64/boot/Image > Image.lzma
cat << EOF > kernel.its
// SPDX-License-Identifier: GPL-2.0
/*
 * Copyright (C) 2024 Intel Corporation
 *
 */

/dts-v1/;

/ {
    description = "FIT image with kernel, DTB and FPGA core binary";
    #address-cells = <1>;

    images {
        kernel {
            description = "Linux Kernel";
            data = /incbin/("./Image.lzma");
            type = "kernel";
            arch = "arm64";
            os = "linux";
            compression = "lzma";
            load = <0x86000000>;
            entry = <0x86000000>;
            hash {
                algo = "crc32";
            };
        };

        fdt-0 {
            description = "Device Tree";
            data = /incbin/("./devicetree.dtb");
            type = "flat_dt";
            arch = "arm64";
            compression = "none";
            hash {
                algo = "crc32";
            };
        };

        fpga-0 {
            description = "FPGA bitstream";
            data = /incbin/("./core.rbf");
            type = "fpga";
            arch = "arm64";
            compression = "none";
            load = <0x8A000000>;
            hash {
                algo = "crc32";
            };
        };
    };

    configurations {
        default = "board-0";

        board-0 {
            description = "board_0";
            kernel = "kernel";
            fdt = "fdt-0";
            fpga = "fpga-0";
            signature {
                algo = "crc32";
                key-name-hint = "dev";
                sign-images = "fdt-0", "kernel", "fpga-0";
            };
        };
    };
};
EOF
./u-boot-socfpga/tools/mkimage -f kernel.its kernel.itb
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/qspi-boot/kernel.itb`

4\. Create U-Boot binary `u-boot.bin` with a size of exactly 2MB:

<!--{"type":"code" }-->
```bash
cp u-boot-socfpga/u-boot.itb .
uboot_part_size=2*1024*1024
uboot_size=`wc -c < u-boot.itb`
uboot_pad="$((uboot_part_size-uboot_size))"
truncate -s +$uboot_pad u-boot.itb
mv u-boot.itb u-boot.bin
```
<!--{"type":"/code" }-->

5\. Build the `rootfs.ubifs` file:

<!--{"type":"code" }-->
```bash
rm -rf rootfs rootfs.ubifs
mkdir rootfs 
tar -xzvf $TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_devkit/core-image-minimal-agilex5_devkit.rootfs.tar.gz -C rootfs 
mkfs.ubifs -r rootfs -F -e 65408 -m 1 -c 6500 -o rootfs.ubifs 
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/qspi-boot/rootfs.ubifs`


6\. Build the `root.ubi` file:

<!--{"type":"code" }-->
```bash
cat << EOF > ubinize.cfg
[env]
mode=ubi
vol_id=0
vol_name=env
vol_size=256KiB
vol_type=dynamic

[script]
mode=ubi
vol_id=1
vol_name=script
vol_size=128KiB 
vol_type=dynamic

[kernel]
mode=ubi
image=kernel.itb
vol_id=2
vol_name=kernel
vol_size=24MiB
vol_type=dynamic

[dtb]
mode=ubi
vol_id=3    
vol_name=dtb   
vol_size=256KiB 
vol_type=dynamic

[rootfs]
mode=ubi
image=rootfs.ubifs
vol_id=4
vol_name=rootfs
vol_type=dynamic
vol_size=160MiB
vol_flag=autoresize
EOF
ubinize -o root.ubi -p 65536 -m 1 -s 1 ubinize.cfg
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/qspi-boot/root.ubi`

7\. Build the QSPI flash image:

<!--{"type":"code" }-->
```bash
ln -s $TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof fpga.sof
ln -s u-boot-socfpga/spl/u-boot-spl-dtb.hex spl.hex
ln -s root.ubi hps.bin
cat << EOF > flash_image.pfg
<pfg version="1">
    <settings custom_db_dir="./" mode="ASX4"/>
    <output_files>
        <output_file name="flash_image" hps="1" directory="./" type="PERIPH_JIC">
            <file_options/>
            <secondary_file type="MAP" name="flash_image_jic">
                <file_options/>
            </secondary_file>
            <flash_device_id>Flash_Device_1</flash_device_id>
        </output_file>
    </output_files>
    <bitstreams>
        <bitstream id="Bitstream_1">
            <path hps_path="spl.hex">fpga.sof</path>
    </bitstream>
    </bitstreams>
    <raw_files>
        <raw_file bitswap="1" type="RBF" id="Raw_File_1">u-boot.bin</raw_file>
        <raw_file bitswap="1" type="RBF" id="Raw_File_2">hps.bin</raw_file>
    </raw_files>
    <flash_devices>
        <flash_loader>A5ED065BB32AE6SR0</flash_loader>
        <flash_device type="MT25QU02G" id="Flash_Device_1">
            <partition reserved="1" fixed_s_addr="1" s_addr="0x00000000" e_addr="0x001FFFFF" fixed_e_addr="1" id="BOOT_INFO" size="0"/>
            <partition reserved="0" fixed_s_addr="0" s_addr="auto" e_addr="auto" fixed_e_addr="0" id="P1" size="0"/>
            <partition reserved="0" fixed_s_addr="0" s_addr="0x04000000" e_addr="auto" fixed_e_addr="0" id="UBOOT" size="0"/>
            <partition reserved="0" fixed_s_addr="0" s_addr="0x04200000" e_addr="auto" fixed_e_addr="0" id="HPS" size="0"/>
        </flash_device>
    </flash_devices>
    <assignments>
        <assignment page="0" partition_id="P1">
            <bitstream_id>Bitstream_1</bitstream_id>
        </assignment>
        <assignment page="0" partition_id="UBOOT">
            <raw_file_id>Raw_File_1</raw_file_id>
        </assignment>
        <assignment page="0" partition_id="HPS">
            <raw_file_id>Raw_File_2</raw_file_id>
        </assignment>
    </assignments>
</pfg>
EOF
quartus_pfg -c flash_image.pfg
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/qspi-boot/flash_image.hps.jic`

<h4>Write QSPI Flash</h4>

1\. Power down board

2\. Set MSEL dipswitch SW27 to JTAG: OFF-OFF-OFF-OFF

3\. Power up the board

4\. Write JIC image to QSPI:

```bash
cd $TOP_FOLDER
quartus_pgm -c 1 -m jtag -o "qspi-boot/flash_image.hps.jic"
```

<h4>Boot Linux</h4>

1\. Power down board

2\. Set MSEL dipswitch SW27 to QSPI: OFF-ON-ON-OFF

3\. Power up the board

4\. Wait for Linux to boot, use `root` as user name, and no password wil be requested.

<!--{"type":"/step" }-->
<!--{"type":"/recipe" }-->

## HPS NAND Board

This section demonstrates how to build a Linux system from separate components, targetting the HPS NAND Board. Boot source is eMMC Flash.

### Boot from eMMC
<!--{"type":"recipe", "name":"Bootloader.eMMC", "results":["$TOP_FOLDER/ghrd.hps.jic","$TOP_FOLDER/ghrd.hps.rbf","$TOP_FOLDER/sd_card/sdcard.img"],"TOP_FOLDER":"artifacts.emmc", "board_keywords":["DK-A5E065BB32AES1","emmc"], "test_commands":["write-sd=$TOP_FOLDER/sd_card/sdcard.img","write-jic=$TOP_FOLDER/ghrd_a5ed065bb32ae6sr0.hps.jic","boot-linux-qspi"]}-->

<h4>Setup Environment</h4>
<!--{"type":"step", "name":"Setup Environment"}-->

1\. Create the top folder to store all the build artifacts:
<!--{"type":"code" }-->

```bash
sudo rm -rf artifacts.emmc
mkdir artifacts.emmc
cd artifacts.emmc
export TOP_FOLDER=`pwd`
```
<!--{"type":"/code" }-->
2\. Download and setup the build toolchain. It will be used only by the GHRD makefile to build the debug HPS FSBL, to build the _hps_debug.sof file:
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel\
/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
```
<!--{"type":"/code" }-->
3\. Set up the Quartus tools in the PATH, so they are accessible without full path
<!--{"type":"code" }-->

```bash
export QUARTUS_ROOTDIR=~/intelFPGA_pro/24.1/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```
<!--{"type":"/code" }-->
<!--{"type":"/step" }-->

<h4>Build Hardware Design</h4>
<!--{"type":"step", "name":"Build Hardware Design", "results":["$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof","$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0_hps_debug.sof"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf ghrd-socfpga agilex5_soc_devkit_ghrd
git clone -b QPDS24.1_REL_AGILEX5_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga
mv ghrd-socfpga/agilex5_soc_devkit_ghrd .
rm -rf ghrd-socfpga
cd agilex5_soc_devkit_ghrd
make config
make DEVICE=A5ED065BB32AE6SR0 HPS_EMIF_MEM_CLK_FREQ_MHZ=800 HPS_EMIF_REF_CLK_FREQ_MHZ=100 DAUGHTER_CARD=devkit_dc_emmc generate_from_tcl
make all
cd ..
```
<!--{"type":"/code" }-->
The following files are created:

* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof`
* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0_hps_debug.sof`
<!--{"type":"/step" }-->

<h4>Build Arm Trusted Firmware</h4>
<!--{"type":"step", "name":"Build Arm Trusted Firmware", "results":["$TOP_FOLDER/arm-trusted-firmware/build/agilex5/release/bl31.bin"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf arm-trusted-firmware
git clone https://github.com/altera-opensource/arm-trusted-firmware
cd arm-trusted-firmware
git checkout -b test -t origin/socfpga_v2.10.0
make -j 48 PLAT=agilex5 bl31 
cd ..
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/arm-trusted-firmware/build/agilex5/release/bl31.bin`
<!--{"type":"/step" }-->


<h4>Build U-Boot</h4>
<!--{"type":"step", "name":"Build U-Boot", "results":["$TOP_FOLDER/u-boot-socfpga/u-boot.itb","$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf u-boot-socfpga v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
wget https://raw.githubusercontent.com/altera-opensource/meta-intel-fpga-refdes/QPDS24.1_REL_AGILEX5_GSRD_PR/recipes-bsp/u-boot/files/v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
git clone https://github.com/altera-opensource/u-boot-socfpga
cd u-boot-socfpga 
git checkout -b test -t origin/socfpga_v2023.10
patch -p1 < ../v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
# enable dwarf4 debug info, for compatibility with arm ds
sed -i 's/PLATFORM_CPPFLAGS += -D__ARM__/PLATFORM_CPPFLAGS += -D__ARM__ -gdwarf-4/g' arch/arm/config.mk
# only boot from SD, do not try QSPI and NAND
sed -i 's/u-boot,spl-boot-order.*/u-boot\,spl-boot-order = \&mmc;/g' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# disable NAND in the device tree
sed -i '/&nand {/!b;n;c\\tstatus = "disabled";' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# swap gmac0 and gmac2
sed -i '/&gmac2/ { N; s/status = "okay"/status = "disabled"/; }' arch/arm/dts/socfpga_agilex5_socdk.dts
sed -i '/&gmac0/ { N; s/status = "disabled"/status = "okay"/; }' arch/arm/dts/socfpga_agilex5_socdk.dts
# link to atf
ln -s ../arm-trusted-firmware/build/agilex5/release/bl31.bin 
# create configuration custom file. 
cat << EOF > config-fragment
# use Image instead of kernel.itb
CONFIG_BOOTFILE="Image"
# disable NAND/UBI related settings from defconfig. 
CONFIG_NAND_BOOT=n
CONFIG_SPL_NAND_SUPPORT=n
CONFIG_CMD_NAND_TRIMFFS=n
CONFIG_CMD_NAND_LOCK_UNLOCK=n
CONFIG_NAND_DENALI_DT=n
CONFIG_SYS_NAND_U_BOOT_LOCATIONS=n
CONFIG_SPL_NAND_FRAMEWORK=n
CONFIG_CMD_NAND=n
CONFIG_MTD_RAW_NAND=n
CONFIG_CMD_UBI=n
CONFIG_CMD_UBIFS=n
CONFIG_MTD_UBI=n
CONFIG_ENV_IS_IN_UBI=n
CONFIG_UBI_SILENCE_MSG=n
CONFIG_UBIFS_SILENCE_MSG=n
# disable distroboot and use specific boot command. 
CONFIG_DISTRO_DEFAULTS=n
CONFIG_HUSH_PARSER=y
CONFIG_SYS_PROMPT_HUSH_PS2="> "
CONFIG_USE_BOOTCOMMAND=y
CONFIG_BOOTCOMMAND="load mmc 0:1 \${loadaddr} ghrd.core.rbf; fpga load 0 \${loadaddr} \${filesize};bridge enable; mmc rescan; fatload mmc 0:1 82000000 Image;fatload mmc 0:1 86000000 socfpga_agilex5_socdk_emmc.dtb;setenv bootargs console=ttyS0,115200 root=\${mmcroot} rw rootwait;booti 0x82000000 - 0x86000000"
CONFIG_CMD_FAT=y
CONFIG_CMD_FS_GENERIC=y
CONFIG_DOS_PARTITION=y
CONFIG_SPL_DOS_PARTITION=y
CONFIG_CMD_PART=y
CONFIG_SPL_CRC32=y
CONFIG_LZO=y
CONFIG_CMD_DHCP=y
# enable more QSPI flash manufacturers
CONFIG_SPI_FLASH_MACRONIX=y
CONFIG_SPI_FLASH_GIGADEVICE=y
CONFIG_SPI_FLASH_WINBOND=y
CONFIG_SPI_FLASH_ISSI=y
EOF
# build U-Boot
make clean && make mrproper
make socfpga_agilex5_defconfig 
# use created custom configuration file to merge with the default configuration obtained in .config file. 
./scripts/kconfig/merge_config.sh -O . -m .config config-fragment
make -j 64
cd ..
```
<!--{"type":"/code" }-->
The following files are created:

* `$TOP_FOLDER/u-boot-socfpga/u-boot.itb`
* `$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex`
<!--{"type":"/step" }-->

<h4>Build QSPI Image</h4>
<!--{"type":"step", "name":"Build QSPI Image", "results":["$TOP_FOLDER/ghrd.hps.jic"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
quartus_pfg -c agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof ghrd.jic \
-o device=MT25QU128 \
-o flash_loader=A5ED065BB32AE6SR0 \
-o hps_path=$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex \
-o mode=ASX4 \
-o hps=1

```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/ghrd.hps.jic`
<!--{"type":"/step" }-->

<h4>Build HPS RBF</h4>
<!--{"type":"step", "name":"Build HPS RBF", "results":["$TOP_FOLDER/ghrd.hps.rbf"]}-->
This is an optional step, in which you can build an HPS RBF file, which can be used to configure the HPS through JTAG instead of QSPI though the JIC file.
<!--{"type":"code" }-->
```bash
cd $TOP_FOLDER
quartus_pfg -c agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof ghrd.rbf \
-o hps_path=$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex \
-o hps=1
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/ghrd.hps.rbf
<!--{"type":"/step" }-->

<h4>Build Linux</h4>
<!--{"type":"step", "name":"Build Linux", "results":["$TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image","$TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dtb"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf linux-socfpga
git clone https://github.com/altera-opensource/linux-socfpga
cd linux-socfpga
git checkout -b test -t origin/socfpga-6.1.68-lts
make defconfig 
make -j 64 Image && make intel/socfpga_agilex5_socdk_emmc.dtb 
```
<!--{"type":"/code" }-->
The following files are created:

* `$TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dtb`
* `$TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image`
<!--{"type":"/step" }-->

<h4>Build Rootfs</h4>
<!--{"type":"step", "name":"Build Rootfs", "results":["$TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_devkit/core-image-minimal-agilex5_devkit.rootfs.tar.gz"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf yocto && mkdir yocto && cd yocto
git clone -b nanbield https://git.yoctoproject.org/poky
git clone -b nanbield https://git.yoctoproject.org/meta-intel-fpga
git clone -b nanbield https://github.com/openembedded/meta-openembedded
source poky/oe-init-build-env ./build
echo 'MACHINE = "agilex5_devkit"' >> conf/local.conf
echo 'BBLAYERS += " ${TOPDIR}/../meta-intel-fpga "' >> conf/bblayers.conf
echo 'BBLAYERS += " ${TOPDIR}/../meta-openembedded/meta-oe "' >> conf/bblayers.conf
echo 'CORE_IMAGE_EXTRA_INSTALL += "openssh gdbserver"' >> conf/local.conf
bitbake core-image-minimal
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_devkit/core-image-minimal-agilex5_devkit.rootfs.tar.gz`
<!--{"type":"/step" }-->


<h4>Create eMMC Image</h4>
<!--{"type":"step", "name":"Create eMMC Image", "results":["$TOP_FOLDER/sd_card/sdcard.img"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
sudo rm -rf sd_card && mkdir sd_card && cd sd_card
wget https://releases.rocketboards.org/release/2020.11/gsrd/tools/make_sdimage_p3.py
sed -i 's/\"\-F 32\",//g' make_sdimage_p3.py
chmod +x make_sdimage_p3.py
mkdir fatfs &&  cd fatfs
cp $TOP_FOLDER/ghrd.core.rbf .
cp $TOP_FOLDER/u-boot-socfpga/u-boot.itb .
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image .
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dtb .
cd ..
mkdir rootfs && cd rootfs
sudo tar xf $TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_devkit/core-image-minimal-agilex5_devkit.rootfs.tar.gz
cd ..
sudo python3 make_sdimage_p3.py -f \
-P fatfs/*,num=1,format=fat32,size=64M \
-P rootfs/*,num=2,format=ext3,size=64M \
-s 140M \
-n sdcard.img
cd ..
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/sd_card/sdcard.img`
<!--{"type":"/step" }-->

<h4>Create Helper JIC</h4>
In this section we are building a helper JIC which will boot from QSPI and will allow us to program the eMMC from U-Boot.

1\. Create the jic helper folder to contain all related build artifacts:

<!--{"type":"step", "name":"Create Helper JIC", "results":["$TOP_FOLDER/helper-jic/flash.hps.jic"]}-->
<!--{"type":"code" }-->

```bash
rm -rf $TOP_FOLDER/helper-jic
mkdir $TOP_FOLDER/helper-jic
```
<!--{"type":"/code" }-->

2\. Build a modified U-Boot, which boots from QSPI and stops at command line prompt:
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER/helper-jic
rm -rf u-boot-socfpga v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
wget https://raw.githubusercontent.com/altera-opensource/meta-intel-fpga-refdes/QPDS24.1_REL_AGILEX5_GSRD_PR/recipes-bsp/u-boot/files/v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
git clone https://github.com/altera-opensource/u-boot-socfpga
cd u-boot-socfpga 
git checkout -b test -t origin/socfpga_v2023.10
patch -p1 < ../v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch 
# enable dwarf4 debug info, for compatibility with arm ds
sed -i 's/PLATFORM_CPPFLAGS += -D__ARM__/PLATFORM_CPPFLAGS += -D__ARM__ -gdwarf-4/g' arch/arm/config.mk
# only boot from SD, do not try QSPI and NAND
sed -i 's/u-boot,spl-boot-order.*/u-boot\,spl-boot-order = \&flash0;/g' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# disable NAND in the device tree
sed -i '/&nand {/!b;n;c\\tstatus = "disabled";' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# swap gmac0 and gmac2
sed -i '/&gmac2/ { N; s/status = "okay"/status = "disabled"/; }' arch/arm/dts/socfpga_agilex5_socdk.dts
sed -i '/&gmac0/ { N; s/status = "disabled"/status = "okay"/; }' arch/arm/dts/socfpga_agilex5_socdk.dts
# link to atf
ln -s $TOP_FOLDER/arm-trusted-firmware/build/agilex5/release/bl31.bin 
# create configuration custom file. 
cat << EOF > config-fragment
# use Image instead of kernel.itb
CONFIG_BOOTFILE="Image"
# disable NAND/UBI related settings from defconfig. 
CONFIG_NAND_BOOT=n
CONFIG_SPL_NAND_SUPPORT=n
CONFIG_CMD_NAND_TRIMFFS=n
CONFIG_CMD_NAND_LOCK_UNLOCK=n
CONFIG_NAND_DENALI_DT=n
CONFIG_SYS_NAND_U_BOOT_LOCATIONS=n
CONFIG_SPL_NAND_FRAMEWORK=n
CONFIG_CMD_NAND=n
CONFIG_MTD_RAW_NAND=n
CONFIG_CMD_UBI=n
CONFIG_CMD_UBIFS=n
CONFIG_MTD_UBI=n
CONFIG_ENV_IS_IN_UBI=n
CONFIG_UBI_SILENCE_MSG=n
CONFIG_UBIFS_SILENCE_MSG=n
# disable distroboot and use specific boot command. 
CONFIG_DISTRO_DEFAULTS=n
CONFIG_HUSH_PARSER=y
CONFIG_SYS_PROMPT_HUSH_PS2="> "
CONFIG_USE_BOOTCOMMAND=y
CONFIG_BOOTCOMMAND="echo hello"
CONFIG_CMD_FAT=y
CONFIG_CMD_FS_GENERIC=y
CONFIG_DOS_PARTITION=y
CONFIG_SPL_DOS_PARTITION=y
CONFIG_CMD_PART=y
CONFIG_SPL_CRC32=y
CONFIG_LZO=y
CONFIG_CMD_DHCP=y
# enable more QSPI flash manufacturers
CONFIG_SPI_FLASH_MACRONIX=y
CONFIG_SPI_FLASH_GIGADEVICE=y
CONFIG_SPI_FLASH_WINBOND=y
CONFIG_SPI_FLASH_ISSI=y
# boot from QSPI
CONFIG_ENV_IS_IN_FAT=n
CONFIG_ENV_IS_NOWHERE=y
CONFIG_SYS_SPI_U_BOOT_OFFS=0x00300000
EOF
# build U-Boot
make clean && make mrproper
make socfpga_agilex5_defconfig 
# use created custom configuration file to merge with the default configuration obtained in .config file. 
./scripts/kconfig/merge_config.sh -O . -m .config config-fragment
make -j 64
cd ..
```
<!--{"type":"/code" }-->

The following files are created:

* `$TOP_FOLDER/u-boot-socfpga/u-boot.itb`
* `$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex`

3\. Build the helper JIC:
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER/helper-jic
rm -f flash.pfg fpga.sof u-boot.bin spl.hex *.jic *.rbf
ln -s $TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof fpga.sof
ln -s u-boot-socfpga/u-boot.itb u-boot.bin
ln -s u-boot-socfpga/spl/u-boot-spl-dtb.hex spl.hex
cat << EOF > flash.pfg
<pfg version="1">
    <settings custom_db_dir="./" mode="ASX4"/>
    <output_files>
        <output_file name="flash" hps="1" directory="./" type="PERIPH_JIC">
            <file_options/>
            <secondary_file type="MAP" name="flash_jic">
                <file_options/>
            </secondary_file>
            <flash_device_id>Flash_Device_1</flash_device_id>
        </output_file>
    </output_files>
    <bitstreams>
        <bitstream id="Bitstream_1">
            <path signing="OFF" finalize_encryption="0" hps_path="spl.hex">fpga.sof</path>
        </bitstream>
    </bitstreams>
    <raw_files>
        <raw_file bitswap="1" type="RBF" id="Raw_File_1">u-boot.bin</raw_file>
    </raw_files>
    <flash_devices>
        <flash_device type="MT25QU128" id="Flash_Device_1">
            <partition reserved="1" fixed_s_addr="1" s_addr="0x00000000" e_addr="0x001FFFFF" fixed_e_addr="1" id="BOOT_INFO" size="0"/>
            <partition reserved="0" fixed_s_addr="0" s_addr="auto" e_addr="auto" fixed_e_addr="0" id="P1" size="0"/>
            <partition reserved="0" fixed_s_addr="0" s_addr="0x00300000" e_addr="0x004CFFFF" fixed_e_addr="1" id="u-boot" size="0"/>
        </flash_device>
        <flash_loader>A5ED065BB32AE5SR0</flash_loader>
    </flash_devices>
    <assignments>
        <assignment page="0" partition_id="P1">
            <bitstream_id>Bitstream_1</bitstream_id>
        </assignment>
        <assignment page="0" partition_id="u-boot">
            <raw_file_id>Raw_File_1</raw_file_id>
        </assignment>
    </assignments>
</pfg>
EOF
quartus_pfg -c flash.pfg
```
<!--{"type":"/code" }-->
The following file will be created:

* `$TOP_FOLDER/helper-jic/flash.hps.jic`

<!--{"type":"/step" }-->

<h4>Write eMMC Image</h4>

1\. Write the helper JIC to QSPI:
<ul>
<li>Power down board</li>
<li>Set MSEL dipswitch SW27 to JTAG: OFF-OFF-OFF-OFF</li>
<li>Power up the board</li>
<li>Write JIC image to QSPI:
```bash
cd $TOP_FOLDER
quartus_pgm -c 1 -m jtag -o "pvi;helper-jic/flash.hps.jic"
```
</li></ul>

2\. Boot to U-Boot prompt with the helper JIC:
<ul>
<li>Power down board</li>
<li>Set MSEL dipswitch SW27 to QSPI: OFF-ON-ON-OFF</li>
<li>Power up the board</li>
<li>Wait for U-Boot to boot, press any key to get to U-Boot console</li></ul>

3\. Use `ifconfig` on your host machine to determine the IP of your TFTP server

4\. Copy the eMMC image `$TOP_FOLDER/sd_card/sdcard.img` to your TFTP server folder

5\. Use the following U-Boot commands to download and write the eMMC image:

```bash
setenv autoload no
dhcp
setenv serverip <your_tftp_server_ip>
tftp ${loadaddr} sdcard.img
setexpr blkcnt ${filesize} / 0x200
mmc write ${loadaddr} 0 ${blkcnt}
```

<h4>Write QSPI Flash</h4>

1\. Power down board

2\. Set MSEL dipswitch SW27 to JTAG: OFF-OFF-OFF-OFF

3\. Power up the board

4\. Write JIC image to QSPI:

```bash
cd $TOP_FOLDER
quartus_pgm -c 1 -m jtag -o "pvi;ghrd.hps.jic"
```

<h4>Boot Linux</h4>

1\. Power down board

2\. Set MSEL dipswitch SW27 to QSPI: OFF-ON-ON-OFF

3\. Power up the board

4\. Wait for Linux to boot, use `root` as user name, and no password wil be requested.

<!--{"type":"/recipe" }-->

## HPS Test Board

This section demonstrates how to build a Linux system from separate components, targetting the HPS Test Board. Boot source is SD Card.

### Boot from SD Card 
<!--{"type":"recipe", "name":"Bootloader.Test", "results":["$TOP_FOLDER/ghrd.hps.jic","$TOP_FOLDER/ghrd.hps.rbf","$TOP_FOLDER/sd_card/sdcard.img"],"TOP_FOLDER":"artifacts.test", "board_keywords":["DK-A5E065BB32AES1","DEBUG"], "test_commands":["write-sd=$TOP_FOLDER/sd_card/sdcard.img","write-jic=$TOP_FOLDER/ghrd.hps.jic","boot-linux-qspi"]}-->

<h4>Setup Environment</h4>
<!--{"type":"step", "name":"Setup Environment"}-->

1\. Create the top folder to store all the build artifacts:
<!--{"type":"code" }-->

```bash
sudo rm -rf artifacts.test
mkdir artifacts.test
cd artifacts.test
export TOP_FOLDER=`pwd`
```
<!--{"type":"/code" }-->
2\. Download and setup the build toolchain. It will be used only by the GHRD makefile to build the debug HPS FSBL, to build the _hps_debug.sof file:
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel\
/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
```
<!--{"type":"/code" }-->
3\. Set up the Quartus tools in the PATH, so they are accessible without full path
<!--{"type":"code" }-->

```bash
export QUARTUS_ROOTDIR=~/intelFPGA_pro/24.1/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```
<!--{"type":"/code" }-->
<!--{"type":"/step" }-->

<h4>Build Hardware Design</h4>
<!--{"type":"step", "name":"Build Hardware Design", "results":["$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof","$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0_hps_debug.sof"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf ghrd-socfpga agilex5_soc_devkit_ghrd
git clone -b QPDS24.1_REL_AGILEX5_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga
mv ghrd-socfpga/agilex5_soc_devkit_ghrd .
rm -rf ghrd-socfpga
cd agilex5_soc_devkit_ghrd
make config
make DEVICE=A5ED065BB32AE6SR0 HPS_EMIF_MEM_CLK_FREQ_MHZ=800 HPS_EMIF_REF_CLK_FREQ_MHZ=100 DAUGHTER_CARD=debug2 generate_from_tcl
make all
cd ..
```
<!--{"type":"/code" }-->
The following files are created:

* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof`
* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0_hps_debug.sof`
<!--{"type":"/step" }-->

<h4>Build Arm Trusted Firmware</h4>
<!--{"type":"step", "name":"Build Arm Trusted Firmware", "results":["$TOP_FOLDER/arm-trusted-firmware/build/agilex5/release/bl31.bin"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf arm-trusted-firmware
git clone https://github.com/altera-opensource/arm-trusted-firmware
cd arm-trusted-firmware
git checkout -b test -t origin/socfpga_v2.10.0
make -j 48 PLAT=agilex5 bl31 
cd ..
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/arm-trusted-firmware/build/agilex5/release/bl31.bin`
<!--{"type":"/step" }-->


<h4>Build U-Boot</h4>
<!--{"type":"step", "name":"Build U-Boot", "results":["$TOP_FOLDER/u-boot-socfpga/u-boot.itb","$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf u-boot-socfpga v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
wget https://raw.githubusercontent.com/altera-opensource/meta-intel-fpga-refdes/QPDS24.1_REL_AGILEX5_GSRD_PR/recipes-bsp/u-boot/files/v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
git clone https://github.com/altera-opensource/u-boot-socfpga
cd u-boot-socfpga 
git checkout -b test -t origin/socfpga_v2023.10
patch -p1 < ../v1-0001-HSD-15015933655-ddr-altera-agilex5-Hack-dual-port-DO-NOT-MERGE.patch
# enable dwarf4 debug info, for compatibility with arm ds
sed -i 's/PLATFORM_CPPFLAGS += -D__ARM__/PLATFORM_CPPFLAGS += -D__ARM__ -gdwarf-4/g' arch/arm/config.mk
# only boot from SD, do not try QSPI and NAND
sed -i 's/u-boot,spl-boot-order.*/u-boot\,spl-boot-order = \&mmc;/g' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# disable NAND in the device tree
sed -i '/&nand {/!b;n;c\\tstatus = "disabled";' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# swap gmac0 and gmac2
sed -i '/&gmac2/ { N; s/status = "okay"/status = "disabled"/; }' arch/arm/dts/socfpga_agilex5_socdk.dts
sed -i '/&gmac0/ { N; s/status = "disabled"/status = "okay"/; }' arch/arm/dts/socfpga_agilex5_socdk.dts
# link to atf
ln -s ../arm-trusted-firmware/build/agilex5/release/bl31.bin 
# create configuration custom file. 
cat << EOF > config-fragment
# use Image instead of kernel.itb
CONFIG_BOOTFILE="Image"
# disable NAND/UBI related settings from defconfig. 
CONFIG_NAND_BOOT=n
CONFIG_SPL_NAND_SUPPORT=n
CONFIG_CMD_NAND_TRIMFFS=n
CONFIG_CMD_NAND_LOCK_UNLOCK=n
CONFIG_NAND_DENALI_DT=n
CONFIG_SYS_NAND_U_BOOT_LOCATIONS=n
CONFIG_SPL_NAND_FRAMEWORK=n
CONFIG_CMD_NAND=n
CONFIG_MTD_RAW_NAND=n
CONFIG_CMD_UBI=n
CONFIG_CMD_UBIFS=n
CONFIG_MTD_UBI=n
CONFIG_ENV_IS_IN_UBI=n
CONFIG_UBI_SILENCE_MSG=n
CONFIG_UBIFS_SILENCE_MSG=n
# disable distroboot and use specific boot command. 
CONFIG_DISTRO_DEFAULTS=n
CONFIG_HUSH_PARSER=y
CONFIG_SYS_PROMPT_HUSH_PS2="> "
CONFIG_USE_BOOTCOMMAND=y
CONFIG_BOOTCOMMAND="load mmc 0:1 \${loadaddr} ghrd.core.rbf; fpga load 0 \${loadaddr} \${filesize};bridge enable; mmc rescan; fatload mmc 0:1 82000000 Image;fatload mmc 0:1 86000000 socfpga_agilex5_socdk_debug.dtb;setenv bootargs console=ttyS0,115200 root=\${mmcroot} rw rootwait;booti 0x82000000 - 0x86000000"
CONFIG_CMD_FAT=y
CONFIG_CMD_FS_GENERIC=y
CONFIG_DOS_PARTITION=y
CONFIG_SPL_DOS_PARTITION=y
CONFIG_CMD_PART=y
CONFIG_SPL_CRC32=y
CONFIG_LZO=y
CONFIG_CMD_DHCP=y
# enable more QSPI flash manufacturers
CONFIG_SPI_FLASH_MACRONIX=y
CONFIG_SPI_FLASH_GIGADEVICE=y
CONFIG_SPI_FLASH_WINBOND=y
CONFIG_SPI_FLASH_ISSI=y
EOF
# build U-Boot
make clean && make mrproper
make socfpga_agilex5_defconfig 
# use created custom configuration file to merge with the default configuration obtained in .config file. 
./scripts/kconfig/merge_config.sh -O . -m .config config-fragment
make -j 64
cd ..
```
<!--{"type":"/code" }-->
The following files are created:

* `$TOP_FOLDER/u-boot-socfpga/u-boot.itb`
* `$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex`
<!--{"type":"/step" }-->

<h4>Build QSPI Image</h4>
<!--{"type":"step", "name":"Build QSPI Image", "results":["$TOP_FOLDER/ghrd.hps.jic"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
quartus_pfg -c agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof ghrd.jic \
-o device=MT25QU128 \
-o flash_loader=A5ED065BB32AE6SR0 \
-o hps_path=$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex \
-o mode=ASX4 \
-o hps=1

```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/ghrd.hps.jic`
<!--{"type":"/step" }-->

<h4>Build HPS RBF</h4>
<!--{"type":"step", "name":"Build HPS RBF", "results":["$TOP_FOLDER/ghrd.hps.rbf"]}-->
This is an optional step, in which you can build an HPS RBF file, which can be used to configure the HPS through JTAG instead of QSPI though the JIC file.
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
quartus_pfg -c agilex5_soc_devkit_ghrd/output_files/ghrd_a5ed065bb32ae6sr0.sof ghrd.rbf \
-o hps_path=$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex \
-o hps=1
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/ghrd.hps.rbf
<!--{"type":"/step" }-->


<h4>Build Linux</h4>
<!--{"type":"step", "name":"Build Linux", "results":["$TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image","$TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_debug.dtb"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf linux-socfpga
git clone https://github.com/altera-opensource/linux-socfpga
cd linux-socfpga
git checkout -b test -t origin/socfpga-6.1.68-lts
make defconfig 
make -j 64 Image && make intel/socfpga_agilex5_socdk_debug.dtb 
```
<!--{"type":"/code" }-->
The following files are created:

* `$TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_debug.dtb`
* `$TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image`
<!--{"type":"/step" }-->

<h4>Build Rootfs</h4>
<!--{"type":"step", "name":"Build Rootfs", "results":["$TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_devkit/core-image-minimal-agilex5_devkit.rootfs.tar.gz"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
rm -rf yocto && mkdir yocto && cd yocto
git clone -b nanbield https://git.yoctoproject.org/poky
git clone -b nanbield https://git.yoctoproject.org/meta-intel-fpga
git clone -b nanbield https://github.com/openembedded/meta-openembedded
source poky/oe-init-build-env ./build
echo 'MACHINE = "agilex5_devkit"' >> conf/local.conf
echo 'BBLAYERS += " ${TOPDIR}/../meta-intel-fpga "' >> conf/bblayers.conf
echo 'BBLAYERS += " ${TOPDIR}/../meta-openembedded/meta-oe "' >> conf/bblayers.conf
echo 'CORE_IMAGE_EXTRA_INSTALL += "openssh gdbserver"' >> conf/local.conf
bitbake core-image-minimal
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_devkit/core-image-minimal-agilex5_devkit.rootfs.tar.gz`
<!--{"type":"/step" }-->


<h4>Create SD Card Image</h4>
<!--{"type":"step", "name":"Create SD Card Image", "results":["$TOP_FOLDER/sd_card/sdcard.img"]}-->
<!--{"type":"code" }-->

```bash
cd $TOP_FOLDER
sudo rm -rf sd_card && mkdir sd_card && cd sd_card
wget https://releases.rocketboards.org/release/2020.11/gsrd/tools/make_sdimage_p3.py
sed -i 's/\"\-F 32\",//g' make_sdimage_p3.py
chmod +x make_sdimage_p3.py
mkdir fatfs &&  cd fatfs
cp $TOP_FOLDER/ghrd.core.rbf .
cp $TOP_FOLDER/u-boot-socfpga/u-boot.itb .
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image .
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_debug.dtb .
cd ..
mkdir rootfs && cd rootfs
sudo tar xf $TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_devkit/core-image-minimal-agilex5_devkit.rootfs.tar.gz
cd ..
sudo python3 make_sdimage_p3.py -f \
-P fatfs/*,num=1,format=fat32,size=64M \
-P rootfs/*,num=2,format=ext3,size=64M \
-s 140M \
-n sdcard.img
cd ..
```
<!--{"type":"/code" }-->
The following file is created:

* `$TOP_FOLDER/sd_card/sdcard.img`
<!--{"type":"/step" }-->

<h4>Write SD Card</h4>

Write the SD card image `sd_card/sdimage.img` to the micro SD card using the included USB writer, and `dd` utility on Linux, or  Win32DiskImager on Windows, available at [https://win32diskimager.org/](https://win32diskimager.org/).

<h4>Write QSPI Flash</h4>

1\. Power down board

2\. Set MSEL dipswitch SW27 to JTAG: OFF-OFF-OFF-OFF

3\. Power up the board

4\. Write JIC image to QSPI:

```bash
cd $TOP_FOLDER
quartus_pgm -c 1 -m jtag -o "pvi;ghrd.hps.jic"
```

<h4>Boot Linux</h4>

1\. Power down board

2\. Set MSEL dipswitch SW27 to QSPI: OFF-ON-ON-OFF

3\. Power up the board

4\. Wait for Linux to boot, use `root` as user name, and no password wil be requested.

<!--{"type":"/recipe" }-->

