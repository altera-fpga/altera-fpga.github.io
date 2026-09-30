

# SoC Fabric Configuration from Linux Example for the Agilex™ 7 FPGA F-Series Transceiver-SoC Development Kit (P-Tiles & E-Tile)

## Introduction 

When using HPS Boot First method, the FPGA device is first configured with a small Phase 1 bitstream, which configures the periphery, and brings up HPS. Then, at a later time, HPS configures the FPGA fabric using a larger Phase 2 bitstream. 

The HPS can configure the fabric either from U-Boot or Linux. The Golden System Reference Design (GSRD) configures the fabric from U-Boot. The examples in this page demonstrate how to configure the FPGA fabric from Linux, using device tree overlays. 

Two different examples are provided: 

- Example building components separately 
 - based on the [Building Bootloader for Agilex&trade; 7](https://www.rocketboards.org/foswiki/Documentation/BuildingBootloaderAgilex7) example. 
 - Manages overlays directly. 
- Example building everything with Yocto 
 - Based on the [GSRD for Agilex&trade; 7 F-Series Transceiver-SoC DevKit (P-Tile and E-Tile)](https://www.rocketboards.org/foswiki/Documentation/AgilexSoCGSRD). 
 - Manages overlays with the [dtbt](https://github.com/altera-fpga/dtbt) utility 

### Prerequisites 

* Altera&trade; Agilex&trade; 7 FPGA F-Series Transceiver-SoC Development Kit P-Tile E-Tile ordering code DK-SI-AGF014EB:  
  * OOBE/SD HPS Daughtercard
  * Mini USB cable for serial output
  * Micro USB cable for on-board Altera® FPGA Download Cable II
  * SDM QSPI Bootcard with MT25QU02G flash device 
* Host PC with:  
  * 64 GB of RAM. Less will be fine for only exercising the binaries, and not rebuilding the GSRD.
  * Linux OS installed. Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too
  * Serial terminal (for example GtkTerm or Minicom on Linux and TeraTerm or PuTTY on Windows)
  * Altera&trade; Quartus<sup>&reg;</sup> Prime Pro Edition Version 25.3
* Local Ethernet network, with DHCP server
* Internet connection. For downloading the files, especially when rebuilding the GSRD.

Refer to [board documentation](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/si-agf014.html) for details about the board.

## Example Building Components Separately 

This example is build on top of the [Building Bootloader for Agilex&trade; 7](https://www.rocketboards.org/foswiki/Documentation/BuildingBootloaderAgilex7) example, with the modification that the fabric is not configured from U-Boot anymore, but from Linux, with a device tree overlay. 

The device tree overlay and the Phase 2 configuration bitstream core.rbf are stored in the Linux rootfs folder /lib/firmware, where the Linux overlay framework expects them to be by default. 

Full instructions for building and running the example are provided. 

### Build Example 


1\. Set Up Environment: 



```bash 
sudo rm -rf agilex7.fabric_config.separate 
mkdir agilex7.fabric_config.separate 
cd agilex7.fabric_config.separate 
export TOP_FOLDER=`pwd` 
```


Download the compiler toolchain, add it to the PATH variable, to be used by the GHRD makefile to build the HPS Debug FSBL:


```bash
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/\
arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu/bin/:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
```

Enable Quartus tools to be called from command line:


```bash
export QUARTUS_ROOTDIR=~/altera_pro/25.3/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```





2\. Build Hardware Design: 



```bash 
cd $TOP_FOLDER 
rm -rf agilex7f-ed-gsrd
wget https://github.com/altera-fpga/agilex7f-ed-gsrd/archive/refs/tags/QPDS25.3_REL_GSRD_PR.zip
unzip QPDS25.3_REL_GSRD_PR.zip
rm QPDS25.3_REL_GSRD_PR.zip
mv agilex7f-ed-gsrd-QPDS25.3_REL_GSRD_PR agilex7f-ed-gsrd
cd agilex7f-ed-gsrd
make agf014eb-si-devkit-oobe-baseline-all
cd ..
```



3\. Build Arm* Trusted Firmware: 



```bash 
cd $TOP_FOLDER 
rm -rf arm-trusted-firmware 
git clone -b QPDS25.3_REL_GSRD_PR https://github.com/altera-fpga/arm-trusted-firmware 
cd arm-trusted-firmware 
make bl31 PLAT=agilex 
cd .. 
```



4\. Build U-Boot: 



```bash 
cd $TOP_FOLDER 
rm -rf u-boot-socfpga 
git clone -b QPDS25.3_REL_GSRD_PR https://github.com/altera-fpga/u-boot-socfpga 
cd u-boot-socfpga 
# enable dwarf4 debug info, for compatibility with arm ds 
sed -i 's/PLATFORM_CPPFLAGS += -D__ARM__/PLATFORM_CPPFLAGS += -D__ARM__ -gdwarf-4/g' arch/arm/config.mk 
# use 'Image' for kernel image instead of 'kernel.itb'
sed -i 's/kernel\.itb/Image/g' arch/arm/Kconfig
# only boot from SD, do not try QSPI and NAND 
sed -i 's/u-boot,spl-boot-order.*/u-boot\,spl-boot-order = \&mmc;/g' arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi 
# disable NAND in the device tree 
sed -i '/&nand {/!b;n;c\\tstatus = "disabled";' arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi 
# remove the NAND configuration from device tree 
sed -i '/images/,/binman/{/binman/!d}' arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi 
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
CONFIG_BOOTCOMMAND="load mmc 0:1 \${loadaddr} ghrd.core.rbf; bridge disable;fpga load 0 \${loadaddr} \${filesize};bridge enable; setenv bootfile Image; run mmcload;run linux_qspi_enable;run rsu_status;run mmcboot" 
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
make socfpga_agilex_defconfig 
# Use created custom configuration file to merge with the default configuration obtained in .config file. 
./scripts/kconfig/merge_config.sh -O ./ ./.config ./config-fragment
# link to atf 
ln -s $TOP_FOLDER/arm-trusted-firmware/build/agilex/release/bl31.bin . 
# build
make -j 64 
cd .. 
```



5\. Build JIC and Core RBF Files: 



```bash 
cd $TOP_FOLDER 
rm -f ghrd.hps.jic ghrd.core.rbf 
quartus_pfg -c \ 
 agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_baseline.sof \ 
 ghrd.jic \ 
 -o device=MT25QU128 \ 
 -o flash_loader=AGFB014R24B2E2V \ 
 -o hps_path=u-boot-socfpga/spl/u-boot-spl-dtb.hex \ 
 -o mode=ASX4 \ 
 -o hps=1 
```



6\. Build Linux: 



```bash 
cd $TOP_FOLDER 
rm -rf linux-socfpga 
git clone -b QPDS25.3_REL_GSRD_PR https://github.com/altera-fpga/linux-socfpga
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



7\. Create Device Treee Overlay: 



```bash 
cd $TOP_FOLDER 
rm -f overlay.dtb overlay.dts 
cat << EOF > overlay.dts 
/dts-v1/; 
/plugin/; 
/ { 
 fragment@0 { 
 target-path = "/fpga-region"; 
 #address-cells = <0x2>; 
 #size-cells = <0x2>; 
 __overlay__ { 
 #address-cells = <0x2>; 
 #size-cells = <0x2>; 
 ranges = <0x0 0x0 0x0 0xF9000000 0x0 0x00200000>; 
 firmware-name = "overlay.rbf"; 
 config-complete-timeout-us = <30000000>; 
 
 sysid_qsys_0: sysid@0 { 
 compatible = "altr,sysid-23.4", "altr,sysid-1.0";
 reg = <0x0 0x0 0x0 0x00000010>; 
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



8\. Build Root Filesystem: 



```bash 
cd $TOP_FOLDER 
rm -rf yocto && mkdir yocto && cd yocto 
git clone -b walnascar https://git.yoctoproject.org/poky 
git clone -b walnascar https://git.yoctoproject.org/meta-intel-fpga 
git clone -b walnascar https://github.com/openembedded/meta-openembedded 
source poky/oe-init-build-env ./build 
echo 'MACHINE = "agilex7_dk_si_agf014eb"' >> conf/local.conf 
echo 'BBLAYERS += " ${TOPDIR}/../meta-intel-fpga "' >> conf/bblayers.conf 
echo 'BBLAYERS += " ${TOPDIR}/../meta-openembedded/meta-oe "' >> conf/bblayers.conf 
echo 'IMAGE_FSTYPES = "tar.gz"' >> conf/local.conf
bitbake core-image-minimal
```



9\. Build SD Card Image: 



```bash 
cd $TOP_FOLDER 
sudo rm -rf sd_card && mkdir sd_card && cd sd_card 
wget https://releases.rocketboards.org/release/2020.11/gsrd/tools/make_sdimage_p3.py 
sed -i 's/\"\-F 32\",//g' make_sdimage_p3.py 
chmod +x make_sdimage_p3.py 
mkdir fat && cd fat 
cp $TOP_FOLDER/u-boot-socfpga/u-boot.itb . 
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/Image . 
cp $TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtb . 
cd .. 
mkdir rootfs && cd rootfs 
sudo tar xf $TOP_FOLDER/yocto/build/tmp/deploy/images/agilex7_dk_si_agf014eb/core-image-minimal-agilex7_dk_si_agf014eb.rootfs.tar.gz 
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
root@agilex7_dk_si_agf014eb:~# mkdir /sys/kernel/config/device-tree/overlays/0 
```

6\. Configure the overlay: 

```bash 
root@agilex7_dk_si_agf014eb:~# echo overlay.dtb > /sys/kernel/config/device-tree/overlays/0/path 
[ 35.750389] fpga_manager fpga0: writing overlay.rbf to Stratix10 SOC FPGA Manager 
[ 36.170960] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/ranges 
[ 36.181456] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/firmware-name 
[ 36.192486] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/config-complete-timeout-us 
```

7\. Locate the sysid in the sysfs: 

```bash 
root@agilex7_dk_si_agf014eb:~# find / -name sysid 
/sys/devices/platform/soc/soc:base_fpga_region/f9000000.sysid/sysid 
```

8\. Display the sysid id information: 

```bash 
root@agilex7_dk_si_agf014eb:~# cat /sys/devices/platform/soc/soc:base_fpga_region/f9000000.sysid/sysid/id | xargs printf "0x%08x\n" 
0xacd5cafe 
```

9\. Remove the overlay: 

```bash 
root@agilex7_dk_si_agf014eb:~# rmdir /sys/kernel/config/device-tree/overlays/0 
```

10\. Confirm that the overlay was removed: 

```bash 
root@agilex7_dk_si_agf014eb:~# find / -name sysid 
```

## Example Building Everything with Yocto 


This example is build on top of the [GSRD for Agilex 7 F-Series Transceiver-SoC DevKit (P-Tile and E-Tile)](https://www.rocketboards.org/foswiki/Documentation/AgilexSoCGSRD), with the modification that the fabric is not configured from U-Boot anymore, instead through a device tree overlay. 

Full instructions for building and running the example are provided. 

### Build Example 

1\. Set up environment: 



```bash 
sudo rm -rf agilex7.fabric_config.yocto 
mkdir agilex7.fabric_config.yocto 
cd agilex7.fabric_config.yocto 
export TOP_FOLDER=`pwd` 
```


Download the compiler toolchain, add it to the PATH variable, to be used by the GHRD makefile to build the HPS Debug FSBL:


```bash
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/\
arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu/bin/:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
```

Enable Quartus tools to be called from command line:


```bash
export QUARTUS_ROOTDIR=~/altera_pro/25.3/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```





2\. Compile the hardware design: 



```bash 
cd $TOP_FOLDER
rm -rf agilex7f-ed-gsrd
wget https://github.com/altera-fpga/agilex7f-ed-gsrd/archive/refs/tags/QPDS25.3_REL_GSRD_PR.zip
unzip QPDS25.3_REL_GSRD_PR.zip
rm QPDS25.3_REL_GSRD_PR.zip
mv agilex7f-ed-gsrd-QPDS25.3_REL_GSRD_PR agilex7f-ed-gsrd
cd agilex7f-ed-gsrd
make agf014eb-si-devkit-oobe-baseline-all
cd ..
```



3\. Build the core.rbf 



```bash 
cd $TOP_FOLDER 
rm -f ghrd.hps.jic ghrd.core.rbf 
quartus_pfg -c \ 
 agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_baseline_hps_debug.sof \ 
 ghrd.jic \ 
 -o device=MT25QU128 \ 
 -o flash_loader=AGFB014R24B2E2V \ 
 -o mode=ASX4 \ 
 -o hps=1 
 rm ghrd.hps.jic 
```



4\. Clone Yocto script and start the build: 



```bash 
cd $TOP_FOLDER 
rm -rf gsrd-socfpga 
git clone -b QPDS25.3_REL_GSRD_PR https://github.com/altera-fpga/gsrd-socfpga 
cd gsrd-socfpga 
. agilex7_dk_si_agf014eb-gsrd-build.sh 
build_setup 
```


5\. Get and apply the patch, containing the following changes: 

- U-Boot boot script is changed to load configuration 0 from the kernel.itb, which does not configure the fabric at boot time 
- Overlay file **agilex_fabric_config_overlay.dts** was added, pointing to **core.rbf** file for fabric configuration, and adding the sysid driver 
- **core.rbf** file is also copied into the **/lib/firmware** folder where the Linux device tree framwork expects it 


```bash 
rm -f agilex7-fabric-config-yocto.patch
wget https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-7/f-series/soc/fabric-config/collateral/agilex7-fabric-config-yocto.patch 
patch -d meta-intel-fpga-refdes -p1 < agilex7-fabric-config-yocto.patch
```


For reference, the patch looks like this:

```diff
diff --git a/recipes-bsp/device-tree/device-tree.bb b/recipes-bsp/device-tree/device-tree.bb
index 6516834..3382020 100644
--- a/recipes-bsp/device-tree/device-tree.bb
+++ b/recipes-bsp/device-tree/device-tree.bb
@@ -24,6 +24,7 @@ SRC_URI:append:agilex7_dk_si_agf014ea = " \
 					file://agilex7_pr_persona0.dts \
 					file://agilex7_pr_persona1.dts \
 					file://socfpga_ilc.dtsi \
+					file://fabric_config_overlay.dts \
 					"
 
 SRC_URI:append:agilex7_dk_si_agf014eb = " \
@@ -32,6 +33,7 @@ SRC_URI:append:agilex7_dk_si_agf014eb = " \
 					file://agilex7_pr_persona0.dts \
 					file://agilex7_pr_persona1.dts \
 					file://socfpga_ilc.dtsi \
+					file://fabric_config_overlay.dts \
 					"
 
 SRC_URI:append:agilex7_dk_si_agi027fb = " \
diff --git a/recipes-bsp/device-tree/files/fabric_config_overlay.dts b/recipes-bsp/device-tree/files/fabric_config_overlay.dts
new file mode 100644
index 0000000..cd5b0df
--- /dev/null
+++ b/recipes-bsp/device-tree/files/fabric_config_overlay.dts
@@ -0,0 +1,23 @@
+/dts-v1/;
+/plugin/;
+/ {
+                fragment@0 {
+                                target-path = "/fpga-region";
+                                #address-cells = <0x2>;
+                                #size-cells = <0x2>;
+                                __overlay__ {
+                                                #address-cells = <0x2>;
+                                                #size-cells = <0x2>;
+                                                ranges =<0x0 0x0 0x0 0xF9000000 0x0 0x00200000>;
+                                                firmware-name = "ghrd.core.rbf";
+                                                config-complete-timeout-us = <30000000>;
+
+                                                sysid_qsys_0: sysid@0 {
+                                                    compatible = "altr,sysid-23.4", "altr,sysid-1.0";
+                                                    reg = <0x0 0x0 0x0 0x00000010>;
+                                                    id = <3405707982>;
+                                                    timestamp = <0>;
+                                                };
+                                };
+                };
+};
diff --git a/recipes-bsp/ghrd/hw-ref-design.bb b/recipes-bsp/ghrd/hw-ref-design.bb
index eccd99d..dbd6f34 100644
--- a/recipes-bsp/ghrd/hw-ref-design.bb
+++ b/recipes-bsp/ghrd/hw-ref-design.bb
@@ -222,6 +222,7 @@ do_install () {
 			install -D -m 0644 ${WORKDIR}/sources/${MACHINE}_pr_${ARM64_GHRD_CORE_RBF} ${D}/boot/ghrd_pr.core.rbf
 			install -D -m 0644 ${WORKDIR}/sources/${MACHINE}_pr_persona0.rbf ${D}${base_libdir}/firmware/persona0.rbf
 			install -D -m 0644 ${WORKDIR}/sources/${MACHINE}_pr_persona1.rbf ${D}${base_libdir}/firmware/persona1.rbf
+			install -D -m 0644 ${WORKDIR}/sources/${MACHINE}_gsrd_${ARM64_GHRD_CORE_RBF} ${D}${base_libdir}/firmware/${ARM64_GHRD_CORE_RBF}
 		else
 			install -D -m 0644 ${WORKDIR}/sources/${MACHINE}_gsrd_${ARM64_GHRD_CORE_RBF} ${D}/boot/${ARM64_GHRD_CORE_RBF}
 		fi
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

6\. Customize Yocto Build 


```bash 
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agf014eb_gsrd_ghrd.core.rbf 
ln -s $TOP_FOLDER/ghrd.core.rbf $CORE_RBF 
OLD_URI="\${GHRD_REPO}\/agilex7_dk_si_agf014eb_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_gsrd_core" 
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ") 
NEW_URI="file:\/\/agilex7_dk_si_agf014eb_gsrd_ghrd.core.rbf;sha256sum=$CORE_SHA" 
sed -i "s/$OLD_URI/$NEW_URI/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
sed -i "/agilex7_dk_si_agf014eb_gsrd_core\.sha256sum/d" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
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
 quartus_pfg -c agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_baseline.sof \ 
 ghrd.jic \ 
 -o hps_path=gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \ 
 -o device=MT25QU128 \ 
 -o flash_loader=AGFB014R24B2E2V \ 
 -o mode=ASX4 \ 
 -o hps=1 
```




### Run Example 

1\. Write QSPI image `$TOP_FOLDER/ghrd.hps.jic` 

2\. Write SD card image `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/gsrd-console-image-agilex7.wic` 

3\. Power up board 

4\. Log into Linux using 'root' as username, no password will be required. 

5\. Apply the overlay: 

```bash 
root@agilex7dksiagf014eb:~# dtbt -a agilex_fabric_config_overlay.dtbo -p /boot/devicetree 
Set dtbo search path to /boot/devicetree 
Applying dtbo: agilex_fabric_config_overlay.dtbo 
[ 36.789770] fpga_manager fpga0: writing ghrd.core.rbf to Stratix10 SOC FPGA Manager 
[ 36.915647] dw_mmc ff808000.mmc: Unexpected interrupt latency 
[ 37.220846] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/ranges 
[ 37.231343] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/firmware-name 
[ 37.242381] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/config-complete-timeout-us 
[ 37.254582] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/sysid_qsys_0 
```

6\. List the applied overlays: 

```bash 
root@agilex7dksiagf014eb:~# dtbt -l 
1 fabric_config_overlay.dtbo applied /sys/kernel/config/device-tree/overlays/1-fabric_config_overlay.dtbo
```

7\. Locate the sysid in the sysfs: 

```bash 
root@agilex7dksiagf014eb:~# find / -name sysid 
/sys/devices/platform/soc/soc:base_fpga_region/f9000000.sysid/sysid 
```

8\. Display the sysid id information: 

```bash 
root@agilex7dksiagf014eb:~# cat /sys/devices/platform/soc/soc:base_fpga_region/f9000000.sysid/sysid/id | xargs printf "0x%08x\n" 
0xacd5cafe 
```

9\. Remove the overlay: 

```bash 
root@agilex7dksiagf014eb:~# dtbt -r fabric_config_overlay.dtbo -p /boot/devicetree
Set dtbo search path to /boot/devicetree
Removing dtbo: 1-fabric_config_overlay.dtbo
```

10\. Confirm that the overlay was removed: 

```bash 
root@agilex7dksiagf014eb:~# dtbt -l 
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