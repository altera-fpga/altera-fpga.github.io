# Vendor Authorized Boot (HPS-First) Tutorial Example Design User Guide

## Introduction

The Vendor Authorized Boot (VAB) design demonstrates an end-to-end authenticated boot flow, from device power on until the Linux kernel is loaded. There are two main components of this design - the Secure Device Manager (SDM) which authenticates the configuration bitstream and U-boot with the Vendor Authorized Boot (VAB) feature. This design is demonstrated on the [Agilex™ 5 FPGA E-Series 013B Development Kit](https://www.altera.com/products/devkit/a1jui0000057q9nmau/agilex-5-fpga-e-series-013b-development-kit) but can also be easily ported to other boards.

This  design requires the following: - QKY file to program virtual key for SDM authentication - Signed RBF file (configuration bitstream) that consists of Agilex™ 5 GHRD and U-boot FSBL - U-boot FSBL and SSBL with VAB features - Linux LTSI

## Overview

The main purpose of a secure boot system is to ensure that the software running in the Hard Processor System (HPS) is trusted. Upon power up, a trusted first stage of boot will be executed - subsequent stages are only loaded and executed if it is authenticated by the current boot stage.

In the Altera® Agilex™ 5 SoC FPGA devices, the Secure Device Manager (SDM) is the entry point for all configuration and booting scenarios. As such, the SDM is the root of trust and will be authenticating the configuration bitstream before any HPS software is being loaded. The SDM's Configuration Management Firmware (CMF) and HPS's First Stage Bootloader (FSBL) are validated as part of the signed configuration bitstream. If VAB is enabled in U-Boot, the FSBL will validate the Second Stage Bootloader (SSBL) and the SSBL will validate the linux kernel.

**Note:** In this demo design, only the authentication feature of the SDM is being demonstrated. The SDM supports other security features such as bitstream encryption, Physically Unclonable Function (PUF) and many more. 

![AgilexSecureBootFlow.png](images/AgilexSecureBootFlow.png)

## Setup Environment

1. Create the top folder to store all the build artifacts:

```bash
mkdir agilex5_vab && cd agilex5_vab
export TOP_FOLDER=`pwd`
```

2. Download the compiler toolchain, add it to the PATH variable:

```bash
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu/bin/:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
```

3. Enable Quartus tools to be called from command line:

```bash
export QUARTUS_ROOTDIR=~/altera_pro/25.3/quartus
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```

4. Install Yocto Dependencies:

Make sure you have Yocto system requirements met: https://docs.yoctoproject.org/5.0.1/ref-manual/system-requirements.html#supported-linux-distributions. The commands to install the required packages on Ubuntu 22.04 are:

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install openssh-server mc libgmp3-dev libmpc-dev gawk wget git diffstat unzip texinfo gcc \
build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping \
python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint xterm python3-subunit mesa-common-dev zstd \
liblz4-tool git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison xinetd \
tftpd tftp nfs-kernel-server libncurses5 libc6-i386 libstdc++6:i386 libgcc++1:i386 lib32z1 \
device-tree-compiler curl mtd-utils u-boot-tools net-tools swig -y
```

On Ubuntu 22.04 you will also need to point the /bin/sh to /bin/bash, as the default is a link to /bin/dash:

```bash
sudo ln -sf /bin/bash /bin/sh
```

## Building the System Image

### Build Arm Trusted Firmware

```bash
cd $TOP_FOLDER
rm -rf arm-trusted-firmware
git clone -b QPDS25.3_REL_GSRD_PR https://github.com/altera-fpga/arm-trusted-firmware 
cd arm-trusted-firmware
make -j 48 PLAT=agilex5 bl31 
cd ..
```

### Build U-Boot

Enable VAB features for U-Boot

```bash
cd $TOP_FOLDER
git clone -b QPDS25.3_REL_GSRD_PR https://github.com/altera-fpga/u-boot-socfpga
cd u-boot-socfpga
# enable dwarf4 debug info, for compatibility with arm ds
sed -i 's/PLATFORM_CPPFLAGS += -D__ARM__/PLATFORM_CPPFLAGS += -D__ARM__ -gdwarf-4/g' arch/arm/config.mk
# only boot from SD, do not try QSPI and NAND
sed -i 's/u-boot,spl-boot-order.*/u-boot\,spl-boot-order = \&mmc;/g' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# disable NAND in the device tree
sed -i '/&nand {/!b;n;c\\tstatus = "disabled";' arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
# link to atf
ln -s $TOP_FOLDER/arm-trusted-firmware/build/agilex/release/bl31.bin .

# Create configuration custom file.
cat << EOF > config-fragment-agilex
#ENABLE  VAB
CONFIG_SOCFPGA_SECURE_VAB_AUTH=y
CONFIG_FIT_IMAGE_POST_PROCESS=y
CONFIG_SPL_SHA512=y
CONFIG_SPL_SHA384=y
CONFIG_SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE=n
# - Disable NAND/UBI related settings from defconfig.
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
# - Disable distroboot and use specific boot command.
CONFIG_DISTRO_DEFAULTS=n
CONFIG_HUSH_PARSER=y
CONFIG_SYS_PROMPT_HUSH_PS2="> "
CONFIG_USE_BOOTCOMMAND=y
CONFIG_BOOTCOMMAND="load mmc 0:1 \${loadaddr} signed_bitstream_core.rbf; bridge disable;fpga load 0 \${loadaddr} \${filesize};bridge enable; run mmcfitload; run mmcfitboot"
CONFIG_CMD_FAT=y
CONFIG_CMD_FS_GENERIC=y
CONFIG_DOS_PARTITION=y
CONFIG_SPL_DOS_PARTITION=y
CONFIG_CMD_PART=y
CONFIG_SPL_CRC32=y
CONFIG_LZO=y
CONFIG_CMD_DHCP=y
# Enable more QSPI flash manufacturers
CONFIG_SPI_FLASH_MACRONIX=y
CONFIG_SPI_FLASH_GIGADEVICE=y
CONFIG_SPI_FLASH_WINBOND=y
CONFIG_SPI_FLASH_ISSI=y
EOF

# build U-Boot 
make clean && make mrproper
make socfpga_agilex5_defconfig 
# Use created custom configuration file to merge with the default configuration obtained in .config file.
./scripts/kconfig/merge_config.sh -O ./ ./.config ./config-fragment-agilex
make -j 64
cd .. 
```

Few Errors will be seen and can be ignored for now. Once the signed images are created, we can resolve them. These errors can be seen as below:

```bash
Image 'u-boot' is missing external blobs and is non-functional: blob-ext blob-ext blob-ext

/binman/u-boot/fit/images/uboot/blob-ext (signed-u-boot-nodtb.bin):
   Missing blob

/binman/u-boot/fit/images/atf/blob-ext (signed-bl31.bin):
   Missing blob

/binman/u-boot/fit/images/fdt-0/blob-ext (signed-u-boot.dtb):
   Missing blob

Image 'kernel' is missing external blobs and is non-functional: blob-ext blob-ext

/binman/kernel/fit/images/kernel/blob-ext (signed-Image):
   Missing blob

/binman/kernel/fit/images/fdt/blob-ext (signed-linux.dtb):
   Missing blob

Some images are invalid
make: *** [Makefile:1126: .binman_stamp] Error 103
```

The following files are created:

- $TOP_FOLDER/u-boot-socfpga/u-boot.itb
- $TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex

### Build Linux

```bash
cd $TOP_FOLDER
rm -rf linux-socfpga
git clone -b QPDS25.3_REL_GSRD_PR  https://github.com/altera-fpga/linux-socfpga linux-socfpga
cd linux-socfpga
make defconfig
make -j 64 Image && make intel/socfpga_agilex5_socdk.dtb 
```

The following files are created:

- $TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dtb
- $TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image

### Build Rootfs

```bash
cd $TOP_FOLDER
rm -rf yocto && mkdir yocto && cd yocto
git clone -b styhead https://git.yoctoproject.org/poky
git clone -b styhead https://git.yoctoproject.org/meta-intel-fpga
git clone -b styhead https://github.com/openembedded/meta-openembedded
source poky/oe-init-build-env ./build
echo 'MACHINE = "agilex5_dk_a5e013bb32aes"' >> conf/local.conf
echo 'BBLAYERS += " ${TOPDIR}/../meta-intel-fpga "' >> conf/bblayers.conf
echo 'BBLAYERS += " ${TOPDIR}/../meta-openembedded/meta-oe "' >> conf/bblayers.conf
echo 'CORE_IMAGE_EXTRA_INSTALL += "openssh gdbserver"' >> conf/local.conf
bitbake core-image-minimal
```

The following file is created:

- $TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_dk_a5e013bb32aes/core-image-minimal-agilex5_dk_a5e013bb32aes.rootfs.tar.gz

## Generate Signature Chains

```bash
cd $TOP_FOLDER
mkdir keys && cd keys
mkdir -p privatekeys; mkdir -p publickeys; mkdir -p qky 
```

Start a Nios V command shell to have all Quartus tools in the PATH:

```bash
~/altera_pro/25.3/niosv/bin/niosv-shell
```

### Generate Root Keys

```bash
quartus_sign --family=agilex5 --operation=make_private_pem --curve=secp384r1 --no_passphrase privatekeys/private_root0.pem
quartus_sign --family=agilex5 --operation=make_public_pem privatekeys/private_root0.pem publickeys/public_root0.pem
quartus_sign --family=agilex5 --operation=make_root publickeys/public_root0.pem qky/root0.qky
```

### Generate Signing Keys

FPGA Signing

```bash
quartus_sign --family=agilex5 --operation=make_private_pem --curve=secp384r1 --no_passphrase privatekeys/private_sign0.pem
quartus_sign --family=agilex5 --operation=make_public_pem privatekeys/private_sign0.pem publickeys/public_sign0.pem
```

HPS Software

```bash
quartus_sign --family=agilex5 --operation=make_private_pem --curve=secp384r1 --no_passphrase privatekeys/private_software0.pem
quartus_sign --family=agilex5 --operation=make_public_pem privatekeys/private_software0.pem publickeys/public_software0.pem
```

### Generate Signature Chain

FPGA Signing - Cancel ID 1 – Permissions: FPGA/HPS/HPS Debug

```bash
quartus_sign --family=agilex5 --operation=append_key --previous_pem=privatekeys/private_root0.pem --previous_qky=qky/root0.qky \
--permission=14 --cancel=1 --input_pem=publickeys/public_sign0.pem qky/sign0_cancel1.qky
```

HPS Software - cancel ID 3 – Permissions: HPS Firmware

```bash
quartus_sign --family=agilex5 --operation=append_key --previous_pem=privatekeys/private_root0.pem --previous_qky=qky/root0.qky \
--permission=0x80 --cancel=3 --input_pem=publickeys/public_software0.pem qky/software0_cancel3.qky
```

## Build Hardware Design

### Build the GHRD

```bash
cd $TOP_FOLDER
rm -rf agilex5_soc_devkit_ghrd && mkdir agilex5_soc_devkit_ghrd && cd agilex5_soc_devkit_ghrd
wget https://github.com/altera-fpga/agilex5e-ed-gsrd/releases/download/QPDS25.3_REL_GSRD_PR/a5ed013-devkit-oobe-legacy-baseline.zip
unzip a5ed013-devkit-oobe-legacy-baseline.zip
rm -f a5ed013-devkit-oobe-legacy-baseline.zip
make legacy_baseline-build
make legacy_baseline-install-sof
cd ..
```

The following files are created:

- `$TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/legacy_baseline.sof`

### Enable Security Features: Authentication

Next, enable the QKY key file in the Quartus project: For the FPGA configuration bitstream to be properly signed, enable the Quartus key File in the Quartus Project.

Open the GHRD project in Quartus.

- From the Assignments Menu, navigate to Device > Device and Pin Options > Security. Under the Quartus key file, browse and select qky/sign0_cancel1.qky.
- Alternatively, you can add the following assignment to the .qsf file: "set_global_assignment -name QKY_FILE "

Regenerate the sof by running the Assembler.

- From the Processing menu, select Compilation Dashboard. In the Compilation Dashboard, select Assembler to regenerate the sof.

### Generate and Sign FPGA and HPS RBF Files

Add FSBL bootloader to configuration bitstream, and generate the core and HPS .rbf files:

```bash
cd $TOP_FOLDER
mkdir bitstreams && cd bitstreams
cp ../agilex5_soc_devkit_ghrd/output_files/legacy_baseline.sof .
quartus_pfg -c legacy_baseline.sof ghrd.rbf -o hps_path=$TOP_FOLDER/u-boot-socfpga/spl/u-boot-spl-dtb.hex -o hps=1 \
-o sign_later=ON
```

After that, two .rbf files are created:

- $TOP_FOLDER /bitstreams/ghrd.core.rbf
- $TOP_FOLDER /bitstreams/ghrd.hps.rbf

Finally, sign the .rbf files:

```bash
quartus_sign --family=agilex5 --operation=sign --qky=../keys/qky/sign0_cancel1.qky \
--pem=../keys/privatekeys/sign0.pem ghrd.core.rbf signed_bitstream_core.rbf
quartus_sign --family=agilex5 --operation=sign --qky=../keys/qky/sign0_cancel1.qky \
--pem=../keys/privatekeys/sign0.pem ghrd.hps.rbf signed_bitstream_hps.rbf
```

## Prepare the Signed Images

### Compile fcs_prepare

The VAB preparation tool is used along with quartus_sign to create a signed firmware image. The signing process perfoms the following:

- The VAB preparation tool calculates the SHA384 hash of the firmware image and creates an unsigned certificate, named unsigned_cert.ccert.
- The signing tool signs the unsigned certification using the appropriate signature chain and creates a signed certificate.
- The VAB preparation tool will append the signed certificate and certificate length to the firmware image, creating a signed firmware image hps_image_signed.vab.
- Create a FIT image of the individually signed firmware images.

```bash
cd $TOP_FOLDER
git clone https://github.com/altera-fpga/libfcs.git
cd libfcs
export CROSS_COMPILE=; export ARCH=
cmake -S . -B build -DBUILD_FCS_PREPARE=ON
cmake --build build
```

### Create Signed U-boot Image

A signed U-boot image will consist of three individually signed firmware images (bl31.bin, u-boot.dtb and u-boot-nodtb.bin) in a FIT image:

![SignedUboot.png](images/SignedUboot.png)

Create a working directory for signing images

```bash
cd $TOP_FOLDER
mkdir signed_hps_images && cd signed_hps_images
cp ../libfcs/build/tools/fcs_prepare/fcs_prepare .
```

Create the certificate for bl31.bin

```bash
./fcs_prepare --hps_cert ../arm-trusted-firmware/build/agilex5/release/bl31.bin -v
quartus_sign --family=agilex5 --operation=SIGN --qky=../keys/qky/software0_cancel3.qky \
--pem=../keys/privatekeys/private_software0.pem ./unsigned_cert-spec15.ccert ./signed_cert_bl31.bin.ccert
./fcs_prepare --finish ./signed_cert_bl31.bin.ccert --imagefile \
../arm-trusted-firmware/build/agilex5/release/bl31.bin
mv hps_image_signed.vab ../u-boot-socfpga/signed-bl31.bin
rm -r unsigned_cert*
```

Create the certificate for u-boot.dtb

```bash
./fcs_prepare --hps_cert ../u-boot-socfpga/u-boot.dtb -v
quartus_sign --family=agilex5 --operation=SIGN --qky=../keys/qky/software0_cancel3.qky \
--pem=../keys/privatekeys/private_software0.pem ./unsigned_cert-spec15.ccert ./signed_cert_u-boot_pad.dtb.ccert
./fcs_prepare --finish ./signed_cert_u-boot_pad.dtb.ccert --imagefile ../u-boot-socfpga/u-boot.dtb
mv hps_image_signed.vab ../u-boot-socfpga/signed-u-boot.dtb
rm unsigned_cert*
```

Create the certificate for u-boot-nodtb.bin

```bash
./fcs_prepare --hps_cert ../u-boot-socfpga/u-boot-nodtb.bin -v
quartus_sign --family=agilex5 --operation=SIGN --qky=../keys/qky/software0_cancel3.qky \
--pem=../keys/privatekeys/private_software0.pem ./unsigned_cert-spec15.ccert ./signed_cert_u-boot-nodtb.bin.ccert
./fcs_prepare --finish ./signed_cert_u-boot-nodtb.bin.ccert --imagefile ../u-boot-socfpga/u-boot-nodtb.bin
mv hps_image_signed.vab ../u-boot-socfpga/signed-u-boot-nodtb.bin
rm unsigned_cert*
```

### Create Signed Linux Image

A signed Linux image will consist of two individually signed firmware images (Image and linux.dtb) in a FIT image:

![SignedLinux.png](images/SignedLinux.png)

Create Signed Linux Image

```bash
./fcs_prepare --hps_cert ../linux-socfpga/arch/arm64/boot/Image -v
quartus_sign --family=agilex5 --operation=SIGN --qky=../keys/qky/software0_cancel3.qky \
--pem=../keys/privatekeys/private_software0.pem ./unsigned_cert-spec15.ccert ./signed_cert_Image.ccert
./fcs_prepare --finish ./signed_cert_Image.ccert --imagefile ../linux-socfpga/arch/arm64/boot/Image
mv hps_image_signed.vab ../u-boot-socfpga/signed-Image 
rm unsigned_cert*
```

Create the certificate for linux.dtb

```bash
./fcs_prepare --hps_cert ../linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dtb -v
quartus_sign --family=agilex5 --operation=SIGN --qky=../keys/qky/software0_cancel3.qky \
--pem=../keys/privatekeys/private_software0.pem ./unsigned_cert-spec15.ccert ./signed_cert_linux.dtb.ccert
./fcs_prepare --finish ./signed_cert_linux.dtb.ccert --imagefile \
../linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dtb
mv hps_image_signed.vab ../u-boot-socfpga/signed-linux.dtb
rm unsigned_cert*
```

Create the FIT Images. This step fixes the errors generated in (**Build U-Boot**) Step

```bash
cd ../u-boot-socfpga
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
make
```

The output of the "make" command can be seen below:

```bash
  UPD     include/generated/timestamp_autogenerated.h
  CC      common/version.o
  AR      common/built-in.o
  LD      u-boot
  OBJCOPY u-boot.srec
  OBJCOPY u-boot-nodtb.bin
  RELOC   u-boot-nodtb.bin
  CAT     u-boot-dtb.bin
  COPY    u-boot.bin
  SYM     u-boot.sym
  CC      spl/common/spl/spl.o
  AR      spl/common/spl/built-in.o
  LD      spl/u-boot-spl
  OBJCOPY spl/u-boot-spl-nodtb.bin
  CAT     spl/u-boot-spl-dtb.bin
  COPY    spl/u-boot-spl.bin
  SYM     spl/u-boot-spl.sym
  OBJCOPY spl/u-boot-spl-dtb.hex
  MKIMAGE u-boot.img
  MKIMAGE u-boot-dtb.img
  BINMAN  .binman_stamp
  OFCHK   .config
```

The generated FIT files are:

- u-boot.itb
- kernel.itb 

## Create SD Card Image

```bash
cd $TOP_FOLDER
sudo rm -rf sd_card && mkdir sd_card && cd sd_card
# Download the sd-card image creator
wget https://releases.rocketboards.org/release/2020.11/gsrd/tools/make_sdimage_p3.py
sed -i 's/\"\-F 32\",//g' make_sdimage_p3.py
chmod +x make_sdimage_p3.py
# Prepare the image files
mkdir fatfs && cd fatfs
cp $TOP_FOLDER/bitstreams/signed_bitstream_core.rbf .
cp $TOP_FOLDER/u-boot-socfpga/u-boot.itb .
cp $TOP_FOLDER/u-boot-socfpga/kernel.itb .
cd ..
mkdir rootfs && cd rootfs
sudo tar xf $TOP_FOLDER/yocto/build/tmp/deploy/images/agilex5_dk_a5e013bb32aes/core-image-minimal-agilex5_dk_a5e013bb32aes.rootfs.tar.gz
cd ..
# Create the image
sudo python3 make_sdimage_p3.py -f \
-P fatfs/*,num=1,format=fat,size=100M \
-P rootfs/*,num=2,format=ext3,size=512M \
-s 640M \
-n agilex5_vab.img
cd ..
```

## Write SD Card Image

On Linux, use the dd utility as shown next:

```bash
# Determine the device asociated with the SD card on the host computer. 
cat /proc/partitions
# This will return for example /dev/sdx
# Use dd to write the image in the corresponding device
sudo dd if= agilex5_vab.img of=/dev/sdx bs=1M
# Flush the changes to the SD card
sync
```

On Windows, use the Win32DiskImager program, available at https://sourceforge.net/projects/win32diskimager. Write the image as shown in the next figure: 

![win32_diskimager.png](images/win32_diskimager.png)

## Running the System Image on Board

1. Power down the board
2. Set MSEL to JTAG mode (SW27: OFF- OFF- OFF- OFF)
3. Connect the HPS UART to a terminal on the host machine.
4. Power on the board.
5. follow the commands below:

```bash
cd $TOP_FOLDER/bitstreams
quartus_pgm -c 1 -m jtag -o "pi;../keys/qky/root0.qky"
quartus_pgm -c 1 -m jtag -o "p;signed_bitstream_hps.rbf"
```

On the HPS terminal, observe the FSBL output:

```bash
U-Boot SPL 2025.12-36773 (Dec 12 2025 - 03:03:03 -0400)
Reset state: Cold
MPU           800000 kHz
L4 Main       400000 kHz
L4 sys free   100000 kHz
L4 MP         200000 kHz
L4 SP         100000 kHz
SDMMC          50000 kHz
...
Trying to boot from MMC1
## Checking hash(es) for config board-0 ... OK
## Checking hash(es) for Image atf ... crc32+ OK
Image Authentication passed at address 0x000000008000000c (57408 bytes)
## Checking hash(es) for Image uboot ... crc32+ OK
Image Authentication passed at address 0x0000000080200000 (708432 bytes)
## Checking hash(es) for Image fdt-0 ... crc32+ OK
Image Authentication passed at address 0x00000000802acf88 (23592 bytes)
NOTICE: SOCFPGA: Boot Core = 0
NOTICE: SOCFPGA: CPU ID = 0
NOTICE: BL31: v2.12.0(release):f308bb3d7
NOTICE: BL31: Built : 15:06:34, Mar 12 2025
...
Hit any key to stop autoboot:  0
1880064 bytes read in 89 ms (20.1 MiB/s)
..FPGA reconfiguration OK!
46795218 bytes read in 2025 ms (22 MiB/s)
## Loading kernel from FIT Image at 82000000 ...
   Using 'conf' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel' kernel subimage
     Description:  Linux Kernel
     Type:         Kernel Image
     Compression:  uncompressed
     Data Start:   0x82000148
     Data Size:    46767228 Bytes = 44.6 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: 0x86000000
     Entry Point:  0x86000000
     Hash algo:    crc32
     Hash value:   c68bdac6
   Verifying Hash Integrity ... crc32+ OK
Image Authentication passed at address 0x0000000082000148 (46766592 bytes)
## Loading fdt from FIT Image at 82000000 ...
   Using 'conf' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt' fdt subimage
     Description:  Linux DTB
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x84c99e64
     Data Size:    26132 Bytes = 25.5 KiB
     Architecture: AArch64
     Hash algo:    crc32
     Hash value:   495ce1eb
   Verifying Hash Integrity ... crc32+ OK
Image Authentication passed at address 0x0000000084c99e64 (25496 bytes)
   Booting using the fdt blob at 0x84c99e64
Working FDT set to 84c99e64
   Loading Kernel Image to 86000000
   Loading Device Tree to 00000000ffb09000, end 00000000ffb12397 ... OK
Working FDT set to ffb09000
SF: Detected mt25qu02g with page size 256 Bytes, erase size 64 KiB, total 256 MiB
Enabling QSPI at Linux DTB...
Working FDT set to ffb09000
libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND
libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND
QSPI clock frequency updated
RSU: Firmware or flash content not supporting RSU
RSU: Firmware or flash content not supporting RSU
RSU: Firmware or flash content not supporting RSU
RSU: Firmware or flash content not supporting RSU

Starting kernel ...
```
