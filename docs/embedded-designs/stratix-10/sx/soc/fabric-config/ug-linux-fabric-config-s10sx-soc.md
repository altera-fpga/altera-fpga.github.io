## Introduction 
 
When using HPS Boot First method, the FPGA device is first configured with a small Phase 1 bitstream, which configures the periphery, and brings up HPS. Then, at a later time, HPS configures the FPGA fabric using a larger Phase 2 bitstream. 
 
The HPS can configure the fabric either from U-Boot or Linux. The Golden System Reference Design (GSRD) configures the fabric from U-Boot. The examples in this page demonstrate how to configure the FPGA fabric from Linux, using device tree overlays. 
 
Two different examples are provided: 
 
- Example building components separately 
 - based on the [Building Bootloader for Stratix10](https://www.rocketboards.org/foswiki/Documentation/BuildingBootloaderStratix10) example. 
 - Manages overlays directly. 
- Example building everything with Yocto 
 - Based on the [Stratix&reg; 10 SoC H-Tile GSRD](https://www.rocketboards.org/foswiki/Documentation/Stratix10SoCGSRDHTile). 
 - Manages overlays with the [dtbt](https://github.com/altera-opensource/dtbt) utility 
 
### Prerequisites 
 
You will need the following items: 
 
- Stratix&reg; 10 SX SoC Development Kit, production version, H-Tile (ordering code DK-SOC-1SSX-H-D):
  - NAND/eMMC HPS Daughtercard 
  - SDM QSPI Bootcard with MT25QU02G flash device 
- Linux host PC (Ubuntu 22.04LTS was used for developing this project, but other versions may work too) 
- Internet access (for downloading files attached to this page, and cloning git trees from github) 
- TFTP server running on host computer (or other accessible computer on the local network) 
- Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 24.3

Refer to [board documentation](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/stratix/10-sx.html) for more details about the development kit.

## Example Building Components Separately 
 
This example is build on top of the [Building Bootloader for Stratix10](https://www.rocketboards.org/foswiki/Documentation/BuildingBootloaderStratix10) example, with the modification that the fabric is not configured from U-Boot anymore, but from Linux, with a device tree overlay. 
 
The device tree overlay and the Phase 2 configuration bitstream core.rbf are stored in the Linux rootfs folder /lib/firmware, where the Linux overlay framework expects them to be by default. 
 
Full instructions for building and running the example are provided. 
 
### Build Example 

 
1\. Set Up Environment 
 


```bash 
sudo rm -rf stratix10.fabric_config.separate
mkdir stratix10.fabric_config.separate 
cd stratix10.fabric_config.separate
export TOP_FOLDER=`pwd` 
``` 


Download the compiler toolchain, add it to the PATH variable, to be used by the GHRD makefile to build the HPS Debug FSBL:


```bash
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/\
gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
```

Enable Quartus tools to be called from command line:


```bash
export QUARTUS_ROOTDIR=~/intelFPGA_pro/24.3/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```




 
2\. Build Hardware Design 
 


```bash 
cd $TOP_FOLDER
rm -rf ghrd-socfpga s10_soc_devkit_ghrd
git clone -b QPDS24.3_REL_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga
mv ghrd-socfpga/s10_soc_devkit_ghrd .
rm -rf ghrd-socfpga
cd s10_soc_devkit_ghrd
# target the h-tile board
export QUARTUS_DEVICE=1SX280HU2F50E1VGAS
# disable SGMII to build faster
export HPS_ENABLE_SGMII=0
# disable PR to build faster
export ENABLE_PARTIAL_RECONFIGURATION=0
make scrub_clean_all
make generate_from_tcl
make all
cd ..
``` 


 
3\. Build Arm* Trusted Firmware 
 


```bash 
cd $TOP_FOLDER 
rm -rf arm-trusted-firmware 
git clone -b QPDS24.3_REL_GSRD_PR https://github.com/altera-opensource/arm-trusted-firmware 
cd arm-trusted-firmware 
make -j 48 bl31 PLAT=stratix10 
cd .. 
``` 


 
4\. Build U-Boot 
 


```bash 
cd $TOP_FOLDER 
rm -rf u-boot-socfpga 
git clone -b QPDS24.3_REL_GSRD_PR https://github.com/altera-opensource/u-boot-socfpga 
cd u-boot-socfpga 
# enable dwarf4 debug info, for compatibility with arm ds 
sed -i 's/PLATFORM_CPPFLAGS += -D__ARM__/PLATFORM_CPPFLAGS += -D__ARM__ -gdwarf-4/g' arch/arm/config.mk 
# use 'Image' for kernel image instead of 'kernel.itb'
sed -i 's/kernel\.itb/Image/g' arch/arm/Kconfig
# only boot from SD, do not try QSPI and NAND 
sed -i 's/u-boot,spl-boot-order.*/u-boot\,spl-boot-order = \&mmc;/g' arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi 
# disable NAND in the device tree 
sed -i '/&nand {/!b;n;c\\tstatus = "disabled";' arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi 
# remove the NAND configuration from device tree 
sed -i '/images/,/binman/{/binman/!d}' arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi  
# Create configuration custom file. 
cat << EOF > config-fragment
# use Image instead of kernel.itb 
CONFIG_BOOTFILE="Image" 
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
CONFIG_BOOTCOMMAND="load mmc 0:1 \${loadaddr} ghrd.core.rbf; bridge disable; fpga load 0 \${loadaddr} \${filesize};bridge enable;setenv bootfile Image;run mmcload;run linux_qspi_enable;run rsu_status;run mmcboot" 
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
EOF
# build U-Boot 
make clean && make mrproper 
make socfpga_stratix10_defconfig 
# Use created custom configuration file to merge with the default configuration obtained in .config file. 
./scripts/kconfig/merge_config.sh -O ./ ./.config ./config-fragment
# link to atf 
ln -s $TOP_FOLDER/arm-trusted-firmware/build/stratix10/release/bl31.bin . 
# build
make -j 64 
cd .. 
``` 


 
5\. Build JIC and Core RBF Files 
 


```bash 
cd $TOP_FOLDER 
rm -f ghrd.hps.jic ghrd.core.rbf 
quartus_pfg -c s10_soc_devkit_ghrd/output_files/ghrd_1sx280hu2f50e1vgas.sof ghrd.jic \ 
 -o device=MT25QU128 \ 
 -o flash_loader=1SX280HU2 \ 
 -o hps_path=u-boot-socfpga/spl/u-boot-spl-dtb.hex \ 
 -o mode=ASX4 \ 
 -o hps=1 
``` 


 
6\. Build Linux 
 


```bash 
cd $TOP_FOLDER 
rm -rf linux-socfpga 
git clone -b QPDS24.3_REL_GSRD_PR https://github.com/altera-opensource/linux-socfpga 
cd linux-socfpga 
make clean && make mrproper 
make defconfig 
# enable device tree overlays and fpga bridges 
./scripts/config --set-val CONFIG_OF_RESOLVE y 
./scripts/config --set-val CONFIG_OF_OVERLAY y 
./scripts/config --set-val CONFIG_OF_CONFIGFS y 
./scripts/config --set-val CONFIG_FPGA_MGR_STRATIX10_SOC y 
./scripts/config --set-val CONFIG_FPGA_BRIDGE y 
./scripts/config --set-val CONFIG_FPGA_REGION y 
./scripts/config --set-val CONFIG_OF_FPGA_REGION y 
./scripts/config --set-val CONFIG_OVERLAY_FS y 
# enable SYSID driver 
./scripts/config --set-val CONFIG_ALTERA_SYSID y 
make oldconfig 
make -j 64 Image dtbs 
``` 


 
7\. Create Device Treee Overlay 
 


```bash 
cd $TOP_FOLDER 
rm -f overlay.dtb overlay.dts 
cat << EOF > overlay.dts 
/dts-v1/; 
/plugin/; 
/ { 
 fragment@0 { 
 target-path = "/soc/base_fpga_region"; 
 #address-cells = <0x2>; 
 #size-cells = <0x2>; 
 __overlay__ { 
 #address-cells = <0x2>; 
 #size-cells = <0x2>; 
 ranges = <0x00000000 0x0 0xF9000000 0x0 0x00200000>; 
 firmware-name = "overlay.rbf"; 
 config-complete-timeout-us = <30000000>; 
 
 sysid_qsys_0: sysid@0 { 
 compatible = "altr,sysid-24.2", "altr,sysid-1.0"; 
 reg = <0x0 0x00000000 0x0 0x00000010>; 
 id = <3405707982>; 
 timestamp = <0>; 
 }; 
 }; 
 }; 
}; 
EOF 
dtc -I dts -O dtb -o overlay.dtb overlay.dts 
``` 


Explanation: 
 
- `Fragment@0`: Node Name of the Overlay. 
- `target-path`: This refers to base_fpga_region located in arch/arm64/boot/dts/intel/socfpga_agilex.dtsi. This will invoke the following driver: drivers/fpga/of-fpga-region.c 
- Fragment@0 `#address-cells/#size-cells`: This specifies the number of cells (32-bit size) to be used for the child's address map. For overlays, we need to set this value to avoid "default_addr_size" errors. 
- overlay `#address-cells/#size-cells`: These fields should match those in arch/arm64/boot/dts/intel/socfpga_agilex.dtsi. 
- `Ranges`: According to the device tree standard, this allows mapping child addresses to parent addresses. In this case: 
  - The first number `<0x0 0x0 0xF9000000 0x0 0x00200000>` represents the child's address. 
  - The second pair `<0x0 0x0 0xF9000000 0x0 0x00200000>` represents the parent's address. 
  - The third pair `<0x0 0x0 0xF9000000 0x0 0x00200000>` specifies the memory region's size. 
- `firmware-name = "overlay.rbf"`: This should contain the fabric's file name. 
- `sysid_qsys_0: sysid@0`: This specifies the device name as well as its alias. 
- `reg = <0x0 0x0 0x0 0x00000010>`: This refers to the addresses specified in the parent range field. 
  - `<0x0 0x0 0x0 0x00000010>`: This represents the child's address. 
  - `<0x0 0x0 0x0 0x00000010>`: This is the size of the memory region. 


 
8\. Build Root Filesystem 
 


```bash 
cd $TOP_FOLDER 
rm -rf yocto && mkdir yocto && cd yocto 
git clone -b scarthgap https://git.yoctoproject.org/poky 
git clone -b scarthgap https://git.yoctoproject.org/meta-intel-fpga 
git clone -b scarthgap https://github.com/openembedded/meta-openembedded 
source poky/oe-init-build-env ./build 
echo 'MACHINE = "stratix10"' >> conf/local.conf 
echo 'BBLAYERS += " ${TOPDIR}/../meta-intel-fpga "' >> conf/bblayers.conf 
echo 'BBLAYERS += " ${TOPDIR}/../meta-openembedded/meta-oe "' >> conf/bblayers.conf 
echo 'IMAGE_FSTYPES = "tar.gz"' >> conf/local.conf 
bitbake core-image-minimal 
``` 


 
9\. Build SD Card Image 
 


```bash 
cd $TOP_FOLDER 
sudo rm -rf sd_card && mkdir sd_card && cd sd_card 
wget https://releases.rocketboards.org/release/2020.11/gsrd/tools/make_sdimage_p3.py 
sed -i 's/\"\-F 32\",//g' make_sdimage_p3.py 
chmod +x make_sdimage_p3.py 
mkdir fat && cd fat 
cp $TOP_FOLDER/u-boot-socfpga/u-boot.itb . 
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image . 
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtb . 
cd .. 
mkdir rootfs && cd rootfs 
sudo tar xf $TOP_FOLDER/yocto/build/tmp/deploy/images/stratix10/core-image-minimal-stratix10.rootfs.tar.gz 
sudo rm -rf lib/modules/* 
sudo mkdir -p lib/firmware 
sudo cp $TOP_FOLDER/ghrd.core.rbf lib/firmware/overlay.rbf 
sudo cp $TOP_FOLDER/overlay.dtb lib/firmware/overlay.dtb 
cd .. 
sudo python3 make_sdimage_p3.py -f \ 
-P fat/*,num=1,format=fat32,size=48M \ 
-P rootfs/*,num=2,format=ext3,size=32M \ 
-s 100M \ 
-n sdcard.img 
cd .. 
``` 



 
### Run Example 
 
1\. Write QSPI image `$TOP_FOLDER/ghrd.hps.jic` 
 
2\. Write SD card image `$TOP_FOLDER/sd_card/sdcard.img` 
 
3\. Power up board 
 
4\. Log into Linux using 'root' as username, no password will be required. 
 
5\. Create the overlay folder 
 
```bash 
root@stratix10:~# mkdir /sys/kernel/config/device-tree/overlays/0 
``` 
 
6\. Configure the overlay: 
 
```bash 
root@stratix10:~# echo overlay.dtb > /sys/kernel/config/device-tree/overlays/0/path 
[ 35.750389] fpga_manager fpga0: writing overlay.rbf to Stratix10 SOC FPGA Manager 
[ 36.170960] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/ranges 
[ 36.181456] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/firmware-name 
[ 36.192486] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/config-complete-timeout-us 
``` 
 
7\. Locate the sysid in the sysfs: 
 
```bash 
root@stratix10:~# find / -name sysid 
/sys/devices/platform/soc/soc:base_fpga_region/f9000000.sysid/sysid 
``` 
 
8\. Display the sysid id information: 
 
```bash 
root@stratix10:~# cat /sys/devices/platform/soc/soc:base_fpga_region/f9000000.sysid/sysid/id | xargs printf "0x%08x\n" 
0xacd5cafe 
``` 
 
9\. Remove the overlay: 
 
```bash 
root@stratix10:~# rmdir /sys/kernel/config/device-tree/overlays/0 
``` 
 
10\. Confirm that the overlay was removed: 
 
```bash 
root@stratix10:~# find / -name sysid 
``` 
 
## Example Building Everything with Yocto 


This example is build on top of the [Stratix 10 SoC L-Tile GSRD](https://www.rocketboards.org/foswiki/Documentation/Stratix10SoCGSRD), with the modification that the fabric is not configured from U-Boot anymore, instead through a device tree overlay. 
 
Full instructions for building and running the example are provided. 
 
### Build Example 
 
1\. Set up environment:
 


```bash 
sudo rm -rf stratix10.fabric_config.yocto 
mkdir stratix10.fabric_config.yocto
cd stratix10.fabric_config.yocto
export TOP_FOLDER=`pwd` 
``` 

 
Download the compiler toolchain, add it to the PATH variable, to be used by the GHRD makefile to build the HPS Debug FSBL:


```bash
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/\
gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
```

Enable Quartus tools to be called from command line:


```bash
export QUARTUS_ROOTDIR=~/intelFPGA_pro/24.3/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```




 
2\. Build hardware design:
 


```bash 
cd $TOP_FOLDER
rm -rf ghrd-socfpga s10_soc_devkit_ghrd
git clone -b QPDS24.3_REL_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga
mv ghrd-socfpga/s10_soc_devkit_ghrd .
rm -rf ghrd-socfpga
cd s10_soc_devkit_ghrd
# target the h-tile board
export QUARTUS_DEVICE=1SX280HU2F50E1VGAS
# disable SGMII to build faster
export HPS_ENABLE_SGMII=0
# disable PR to build faster
export ENABLE_PARTIAL_RECONFIGURATION=0
make scrub_clean_all
make generate_from_tcl
make all
cd ..
``` 


 
3\. Build the core.rbf 
 


```bash 
cd $TOP_FOLDER 
rm -f ghrd.hps.jic ghrd.core.rbf 
 quartus_pfg -c s10_soc_devkit_ghrd/output_files/ghrd_1sx280hu2f50e1vgas_hps_debug.sof \ 
 ghrd.jic \ 
 -o device=MT25QU128 \ 
 -o flash_loader=1SX280HU2 \ 
 -o mode=ASX4 \ 
 -o hps=1 
rm ghrd.hps.jic 
``` 


 
4\. Clone Yocto script and start the build: 
 



```bash 
cd $TOP_FOLDER 
rm -rf gsrd_socfpga 
git clone -b QPDS24.3_REL_GSRD_PR https://github.com/altera-opensource/gsrd_socfpga 
cd gsrd_socfpga 
. stratix10-gsrd-build.sh 
build_setup 
``` 

 
5\. Get and apply the patch, containing the following changes: 
 
- U-Boot boot script is changed to load configuration 0 from the kernel.itb, which does not configure the fabric at boot time 
- Overlay file **agilex_fabric_config_overlay.dts** was added, pointing to **core.rbf** file for fabric configuration, and adding the sysid driver 
- **core.rbf** file is also copied into the **/lib/firmware** folder where the Linux device tree framwork expects it 
 =

```bash
rm -f stratix10-fabric-config-yocto.patch
wget https://altera-fpga.github.io/rel-24.3/embedded-designs/stratix-10/sx/soc/fabric-config/collateral/stratix10-fabric-config-yocto.patch 
patch -d meta-intel-fpga-refdes -p1 < stratix10-fabric-config-yocto.patch 
``` 


For reference, the patch looks like this:

```diff
diff --git a/recipes-bsp/device-tree/device-tree.bb b/recipes-bsp/device-tree/device-tree.bb
index 94e5a17..d9387d0 100644
--- a/recipes-bsp/device-tree/device-tree.bb
+++ b/recipes-bsp/device-tree/device-tree.bb
@@ -66,6 +66,7 @@ SRC_URI:append:stratix10 = " \
 					file://stratix10_pr_persona0.dts \
 					file://stratix10_pr_persona1.dts \
 					file://socfpga_ilc.dtsi \
+					file://fabric_config_overlay.dts \
 					"
 
 SRC_URI:append:stratix10_htile = " \
@@ -75,6 +76,7 @@ SRC_URI:append:stratix10_htile = " \
 					file://stratix10_pr_persona0.dts \
 					file://stratix10_pr_persona1.dts \
 					file://socfpga_ilc.dtsi \
+					file://fabric_config_overlay.dts \
 					"
 
 SRC_URI:append:agilex5_dk_a5e065bb32aes1 = " \
diff --git a/recipes-bsp/device-tree/files/fabric_config_overlay.dts b/recipes-bsp/device-tree/files/fabric_config_overlay.dts
new file mode 100644
index 0000000..4ca15eb
--- /dev/null
+++ b/recipes-bsp/device-tree/files/fabric_config_overlay.dts
@@ -0,0 +1,23 @@
+/dts-v1/;
+/plugin/;
+/ {
+                fragment@0 {
+                                target-path = "/soc/base_fpga_region";
+                                #address-cells = <0x2>;
+                                #size-cells = <0x2>;
+                                __overlay__ {
+                                                #address-cells = <0x2>;
+                                                #size-cells = <0x2>;
+                                                ranges = <0x00000000 0x0 0xF9000000 0x0 0x00200000>;
+                                                firmware-name = "ghrd.core.rbf";
+                                                config-complete-timeout-us = <30000000>;
+
+                                                sysid_qsys_0: sysid@0 {
+                                                    compatible = "altr,sysid-23.4", "altr,sysid-1.0";
+                                                    reg = <0x0 0x00000000 0x0 0x00000010>;
+                                                    id = <3405707982>;
+                                                    timestamp = <0>;
+                                                };
+                                };
+                };
+};
diff --git a/recipes-bsp/ghrd/hw-ref-design.bb b/recipes-bsp/ghrd/hw-ref-design.bb
index 36cb532..1120f9d 100644
--- a/recipes-bsp/ghrd/hw-ref-design.bb
+++ b/recipes-bsp/ghrd/hw-ref-design.bb
@@ -205,6 +205,7 @@ do_install () {
 		install -D -m 0644 ${WORKDIR}/${MACHINE}_nand_${ARM64_GHRD_CORE_RBF} ${D}/boot/nand.core.rbf
 		install -D -m 0644 ${WORKDIR}/${MACHINE}_pr_persona0.rbf ${D}${base_libdir}/firmware/persona0.rbf
 		install -D -m 0644 ${WORKDIR}/${MACHINE}_pr_persona1.rbf ${D}${base_libdir}/firmware/persona1.rbf
+		install -D -m 0644 ${WORKDIR}/${MACHINE}_gsrd_${ARM64_GHRD_CORE_RBF} ${D}${base_libdir}/firmware/${ARM64_GHRD_CORE_RBF}
 	fi
 
 	if ${@bb.utils.contains("MACHINE", "stratix10_htile", "true", "false", d)}; then
@@ -212,6 +213,7 @@ do_install () {
 		install -D -m 0644 ${WORKDIR}/${MACHINE}_nand_${ARM64_GHRD_CORE_RBF} ${D}/boot/nand.core.rbf
 		install -D -m 0644 ${WORKDIR}/${MACHINE}_pr_persona0.rbf ${D}${base_libdir}/firmware/persona0.rbf
 		install -D -m 0644 ${WORKDIR}/${MACHINE}_pr_persona1.rbf ${D}${base_libdir}/firmware/persona1.rbf
+		install -D -m 0644 ${WORKDIR}/${MACHINE}_gsrd_${ARM64_GHRD_CORE_RBF} ${D}${base_libdir}/firmware/${ARM64_GHRD_CORE_RBF}
 	fi
 
 	if ${@bb.utils.contains("MACHINE", "cyclone5", "true", "false", d)}; then
diff --git a/recipes-bsp/u-boot/files/uboot.txt b/recipes-bsp/u-boot/files/uboot.txt
index 8577186..3a0288f 100644
--- a/recipes-bsp/u-boot/files/uboot.txt
+++ b/recipes-bsp/u-boot/files/uboot.txt
@@ -6,7 +6,7 @@ if test ${target} = "mmc0"; then
 		mmc rescan;
 		fatload ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} ${bootfile};
 		setenv bootargs "earlycon panic=-1 root=${mmcroot} rw rootwait";		
-		bootm ${loadaddr}#board-${board_id};
+		bootm ${loadaddr}#board-0;
 		exit;
 	fi
 fi

```
 
6\. Customize Yocto Build: 
 

```bash 
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/stratix10_gsrd_ghrd.core.rbf 
ln -s $TOP_FOLDER/ghrd.core.rbf $CORE_RBF 
OLD_CORE_URI="\${GHRD_REPO}\/stratix10_gsrd_\${ARM64_GHRD_CORE_RBF};name=stratix10_gsrd_core" 
NEW_CORE_URI="file:\/\/stratix10_gsrd_ghrd.core.rbf" 
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ") 
RECIPE=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
sed -i "s/$OLD_CORE_URI/$NEW_CORE_URI/g" $RECIPE 
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ") 
OLD_CORE_SHA="SRC_URI\[stratix10_gsrd_core\.sha256sum\] = .*" 
NEW_CORE_SHA="SRC_URI[stratix10_gsrd_core.sha256sum] = \"$CORE_SHA\"" 
sed -i "s/$OLD_CORE_SHA/$NEW_CORE_SHA/g" $RECIPE 
``` 

 
7\. Build Yocto: 
 

```bash 
bitbake_image 
package 
``` 


 
8\. Build JIC file: 
 


```bash 
cd $TOP_FOLDER 
rm -f *jic* *rbf* 
 quartus_pfg -c s10_soc_devkit_ghrd/output_files/ghrd_1sx280hu2f50e1vgas.sof \ 
 ghrd.jic \ 
 -o hps_path=gsrd_socfpga/stratix10-gsrd-images/u-boot-stratix10-socdk-gsrd-atf/u-boot-spl-dtb.hex \ 
 -o device=MT25QU128 \ 
 -o flash_loader=1SX280HU2 \ 
 -o mode=ASX4 \ 
 -o hps=1 
``` 



 
### Run Example 
 
1\. Write QSPI image `$TOP_FOLDER/ghrd.hps.jic` 
 
2\. Write SD card image `$TOP_FOLDER/gsrd_socfpga/stratix10-gsrd-images/gsrd-console-image-stratix10.wic` 
 
3\. Power up board 
 
4\. Log into Linux using 'root' as username, no password will be required. 
 
5\. Apply the overlay: 
 
```bash 
root@stratix10:~# dtbt -a stratix10_fabric_config_overlay.dtbo -p /boot/devicetree 
Set dtbo search path to /boot/devicetree 
[ 116.946137] fpga_manager fpga0: writing ghrd.core.rbf to Stratix10 SOC FPGA Manager 
Applying dtbo: stratix10_fabric_config_overlay.dtbo 
[ 117.304564] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/ranges 
[ 117.315044] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/firmware-name 
[ 117.326087] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/config-complete-timeout-us 
[ 117.338292] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/sysid_qsys_0 
``` 
 
6\. List the applied overlays: 
 
```bash 
root@stratix10:~# dtbt -l 
1 fabric_config_overlay.dtbo applied /sys/kernel/config/device-tree/overlays/1-fabric_config_overlay.dtbo
``` 
 
7\. Locate the sysid in the sysfs: 
 
```bash 
root@stratix10:~# find / -name sysid 
/sys/devices/platform/soc/soc:base_fpga_region/f9000000.sysid/sysid 
``` 
 
8\. Display the sysid id information: 
 
```bash 
root@stratix10:~# cat /sys/devices/platform/soc/soc:base_fpga_region/f9000000.sysid/sysid/id | xargs printf "0x%08x\n" 
0xacd5cafe 
``` 
 
9\. Remove the overlay: 
 
```bash 
root@stratix10:~# dtbt -r fabric_config_overlay.dtbo -p /boot/devicetree
Set dtbo search path to /boot/devicetree
Removing dtbo: 1-fabric_config_overlay.dtbo
``` 
 
10\. Confirm that the overlay was removed: 
 
```bash 
root@stratix10:~# dtbt -l 
```
## Notices & Disclaimers

Altera<sup>&reg;</sup> Corporation technologies may require enabled hardware, software or service activation.
No product or component can be absolutely secure. 
Performance varies by use, configuration and other factors.
Your costs and results may vary. 
You may not use or facilitate the use of this document in connection with any infringement or other legal analysis concerning Altera or Intel products described herein. You agree to grant Altera Corporation a non-exclusive, royalty-free license to any patent claim thereafter drafted which includes subject matter disclosed herein.
No license (express or implied, by estoppel or otherwise) to any intellectual property rights is granted by this document, with the sole exception that you may publish an unmodified copy. You may create software implementations based on this document and in compliance with the foregoing that are intended to execute on the Altera or Intel product(s) referenced in this document. No rights are granted to create modifications or derivatives of this document.
The products described may contain design defects or errors known as errata which may cause the product to deviate from published specifications.  Current characterized errata are available on request.
Altera disclaims all express and implied warranties, including without limitation, the implied warranties of merchantability, fitness for a particular purpose, and non-infringement, as well as any warranty arising from course of performance, course of dealing, or usage in trade.
You are responsible for safety of the overall system, including compliance with applicable safety-related requirements or standards. 
<sup>&copy;</sup> Altera Corporation.  Altera, the Altera logo, and other Altera marks are trademarks of Altera Corporation.  Other names and brands may be claimed as the property of others. 

OpenCL* and the OpenCL* logo are trademarks of Apple Inc. used by permission of the Khronos Group™. 