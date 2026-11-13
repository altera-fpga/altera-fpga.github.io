

## Introduction

The HPS Baseline System Example Design (formerly known as "GSRD" or "Golden System Reference Design") configures the FPGA fabric from U-Boot. This Tutorial example design shows how to customize the Yocto recipes for the HPS Baseline System Example Design to configure the fabric from Linux, instead of U-Boot.

The following modifications are done:

* Use `0` as `board_id` in the boot script, so that the vanilla Linux device tree is used at boot time, which does not need the fabric to be configured.
* Copy the `core.rbf` file in `/lib/firmware` on the target rootfs
* Create a device tree overlay `fabric_overlay.dtb` and also copy it in `/lib/firmware` on the target rootfs
* Update the kernel configuration to include the required additional drivers and settings.

### Prerequisites

The following are needed:

* [Agilex 3 FPGA and SoC C-Series Development Kit](https://www.altera.com/products/devkit/po-3000/agilex-3-fpga-and-soc-c-series-development-kit), ordering code DK-A3W135BM16AEA. Other Agilex 3 development boards will also work in the same manner, just that other set HPS Baseline System Example Design binaries will be used.
* Host PC with Linux (Ubuntu 22.04 was used, but others should work too)
* Quartus Pro 26.3 (or just Quartus Pro standalone Programmer 26.3).
* Ashling RiscFree bundled with Quartus Pro 26.3 (can be installed and use with just the standalone Programmer)
* Network access, for downloading the sources while building the binaries

## Build Example Design



### Setup Environment

Create a folder to contain all the example files:


```bash
sudo rm -rf agilex3.fabric-config-linux
mkdir agilex3.fabric-config-linux
cd agilex3.fabric-config-linux
export TOP_FOLDER=`pwd`
```


Enable Quartus tools to be called from command line:


```bash
source ~/altera_pro/26.3/qinit.sh
```







### Build Quartus Design



The Quartus design is derived from the HPS Baseline System Example Design (formerly known as "GSRD" or "Golden System Reference Design"), with the JOP component added and connected to clock, reset and the LWH2F bridge

The following instructions are used:



```bash
cd $TOP_FOLDER
rm -rf agilex3_soc_devkit_ghrd && mkdir agilex3_soc_devkit_ghrd && cd agilex3_soc_devkit_ghrd
wget https://github.com/altera-fpga/agilex3-ed-hps-baseline/releases/download/QPDS26.3_REL_BASELINE_PR/dk-a3w135bm16aea-baseline.zip
unzip dk-a3w135bm16aea-baseline.zip
rm -f dk-a3w135bm16aea-baseline.zip
make baseline-install
cd ..
```


The following files are created:

* `$TOP_FOLDER/agilex3_soc_devkit_ghrd/install/binaries/baseline.sof`
* `$TOP_FOLDER/agilex3_soc_devkit_ghrd/install/binaries/ghrd.core.rbf`



### Build Rootfs Using Kas



1\. Copy the `core.rbf` file to where the recipes needs it


```bash
cd $TOP_FOLDER/agilex3_soc_devkit_ghrd/software/yocto_linux
cp $TOP_FOLDER/agilex3_soc_devkit_ghrd/install/binaries/ghrd.core.rbf \
   $TOP_FOLDER/agilex3_soc_devkit_ghrd/software/yocto_linux/meta-custom/recipes-fpga/fpga-bitstream/files/
```


2\. Create the patch file for customizing Yocto to configure fabric from Linux:


```bash
base64 -d <<'EOF' | gunzip > fabric-config-linux.patch
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
AA==
EOF
```


For reference, the `fabric-config-linux.patch` looks like this:
```diff
diff --git a/kas.yml b/kas.yml
index 8ad21a7..9c97d4d 100644
--- a/kas.yml
+++ b/kas.yml
@@ -55,9 +55,11 @@ local_conf_header:
     CUSTOM_LINUX_DEVICE_TREE = "0"
 
   # RBF file should be placed in meta-custom/recipes-fpga/fpga-bitstream/files/
+  # FPGA_ENABLE_CORE_PGM=0: RBF is NOT embedded in kernel.itb; instead it is
+  # installed to /lib/firmware in the rootfs for Linux-side fabric configuration.
   fpga-bitstream: |
-    FPGA_ENABLE_CORE_PGM ?= "1"
-    FPGA_RBF_FILE ?= "baseline_hps_debug.core.rbf"
+    FPGA_ENABLE_CORE_PGM ?= "0"
+    FPGA_RBF_FILE ?= "ghrd.core.rbf"
 
   kernel-modules: |
     KERNEL_MODULE_PROBECONF = "cfg80211"
diff --git a/meta-custom/conf/layer.conf b/meta-custom/conf/layer.conf
index 382d28a..1ad53c7 100644
--- a/meta-custom/conf/layer.conf
+++ b/meta-custom/conf/layer.conf
@@ -46,6 +46,10 @@ IMAGE_INSTALL:append = "${@bb.utils.contains('GPIO_INT_TEST', 'true', ' pio-inte
 IMAGE_INSTALL:append = "${@bb.utils.contains('HELLO_WORLD_APP', 'true', ' hello', '', d) if d.getVar('SSBL_BOOT_SOURCE') != 'qspi' else ''}"
 IMAGE_INSTALL:append = "${@'' if d.getVar('SSBL_BOOT_SOURCE') == 'qspi' else ' rootfs-files'}"
 
+# Linux-side FPGA fabric configuration:
+# ghrd.core.rbf and fabric_overlay.dtb are installed to /lib/firmware (${nonarch_base_libdir}) in the rootfs.
+IMAGE_INSTALL:append = " fpga-bitstream fpga-linux-overlay"
+
 # Add variables for wic creation of sdcard image
 IMAGE_BOOT_FILES = " \
        uboot.env \
diff --git a/meta-custom/recipes-bsp/u-boot/bootscr/uboot.txt b/meta-custom/recipes-bsp/u-boot/bootscr/uboot.txt
new file mode 100644
index 0000000..9c268c5
--- /dev/null
+++ b/meta-custom/recipes-bsp/u-boot/bootscr/uboot.txt
@@ -0,0 +1,45 @@
+echo "Trying to boot Linux from device ${target}";
+
+if test ${target} = "mmc0"; then
+   if test -e ${devtype} ${devnum}:${distro_bootpart} /${bootfile}; then
+       echo "Found kernel in mmc0";
+       mmc rescan;
+       fatload ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} ${bootfile};
+        if test -n "${custom_bootargs}"; then
+            setenv bootargs ${custom_bootargs}
+        else
+            setenv bootargs "earlycon panic=-1 root=${mmcroot} rw rootwait";
+        fi
+       bootm ${loadaddr}#board-0;
+       exit;
+   fi
+fi
+
+if test ${target} = "qspi"; then
+   mtdparts;
+   ubi part root;
+   ubi readvol ${loadaddr} kernel;
+   ubi detach;
+    if test -n "${custom_bootargs}"; then
+        setenv bootargs ${custom_bootargs}
+    else
+        setenv bootargs "earlycon panic=-1 ubi.mtd=1 root=ubi0:rootfs rootfstype=ubifs rw rootwait";
+    fi
+   bootm ${loadaddr}#board-0;
+fi
+
+if test ${target} = "nand"; then
+   setenv mtdids "nor0=nor0,nand0=ffb90000.nand.0";
+   setenv mtdparts "mtdparts=nor0:66m(u-boot),190m(qspi_root);ffb90000.nand.0:2m(u-boot),-(root)";
+   env select UBI;
+   saveenv;
+   mtdparts;
+   ubi part root;
+   ubi readvol ${loadaddr} kernel;
+    if test -n "${custom_bootargs}"; then
+        setenv bootargs ${custom_bootargs}
+    else
+        setenv bootargs "earlycon panic=-1 root=${nandroot} rw rootwait rootfstype=ubifs ubi.mtd=1";
+    fi
+   bootm ${loadaddr}#board-0;
+fi
diff --git a/meta-custom/recipes-bsp/u-boot/u-boot-socfpga-scr.bbappend b/meta-custom/recipes-bsp/u-boot/u-boot-socfpga-scr.bbappend
new file mode 100644
index 0000000..299fc18
--- /dev/null
+++ b/meta-custom/recipes-bsp/u-boot/u-boot-socfpga-scr.bbappend
@@ -0,0 +1,6 @@
+# Override the upstream boot script to use a fixed board-0 FIT config,
+# bypassing board_id detection.  FPGA fabric is configured from Linux,
+# not from U-Boot, so board-0 (vanilla DTB, no FPGA section in ITB) is
+# always the correct choice.
+
+FILESEXTRAPATHS:prepend := "${THISDIR}/bootscr:"
diff --git a/meta-custom/recipes-fpga/fpga-bitstream/fpga-bitstream.bbappend b/meta-custom/recipes-fpga/fpga-bitstream/fpga-bitstream.bbappend
index 9da6b0a..5e3159f 100644
--- a/meta-custom/recipes-fpga/fpga-bitstream/fpga-bitstream.bbappend
+++ b/meta-custom/recipes-fpga/fpga-bitstream/fpga-bitstream.bbappend
@@ -7,4 +7,18 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 python () {
     if not d.getVar('FPGA_ENABLE_CORE_PGM'):
         raise bb.parse.SkipRecipe("FPGA Enable Core Programming option is not set!")
+
+    # We always want the RBF in /lib/firmware
+    d.delVarFlag('do_install', 'noexec')
 }
+
+# Always include the RBF in SRC_URI regardless of FPGA_CORE_PGM_ENABLE.
+SRC_URI:append = " file://${FPGA_RBF_FILE}"
+
+# Install core.rbf to /lib/firmware for Linux-side FPGA configuration
+do_install () {
+    install -D -m 0644 ${S}/${FPGA_RBF_FILE} \
+        ${D}${nonarch_base_libdir}/firmware/${FPGA_RBF_FILE}
+}
+
+FILES:${PN} = "${nonarch_base_libdir}/firmware/*"
diff --git a/meta-custom/recipes-fpga/fpga-linux-overlay/files/fabric_overlay.dts b/meta-custom/recipes-fpga/fpga-linux-overlay/files/fabric_overlay.dts
new file mode 100644
index 0000000..38f32f4
--- /dev/null
+++ b/meta-custom/recipes-fpga/fpga-linux-overlay/files/fabric_overlay.dts
@@ -0,0 +1,84 @@
+/dts-v1/;
+/plugin/;
+
+/ {
+   /*
+    * Fragment 0 – target the FPGA region at root level.
+    * Triggers FPGA Manager to load the bitstream and registers the
+    * PIO controllers as children of the programmed fabric region.
+    */
+   fragment@0 {
+       target-path = "/fpga-region";
+       #address-cells = <0x2>;
+       #size-cells = <0x2>;
+       __overlay__ {
+           #address-cells = <0x2>;
+           #size-cells = <0x2>;
+           /*
+            * Map local fabric address space to the LWH2F bridge.
+            * child-hi  child-lo  parent-hi  parent-lo  size-hi  size-lo
+            */
+           ranges = <0x0 0x0 0x0 0x20000000 0x0 0x200000>;
+
+           firmware-name = "ghrd.core.rbf";
+           config-complete-timeout-us = <30000000>;
+
+           /* FPGA LED PIO – 3 output bits driving board LEDs */
+           led_pio: gpio@10080 {
+               compatible = "altr,pio-1.0";
+               reg = <0x0 0x10080 0x0 0x10>;
+               #gpio-cells = <2>;
+               gpio-controller;
+               resetvalue = <0>;
+           };
+
+           /* FPGA Button PIO – input with edge-triggered interrupt */
+           button_pio: gpio@10060 {
+               compatible = "altr,pio-1.0";
+               reg = <0x0 0x10060 0x0 0x10>;
+               interrupt-parent = <&intc>;
+               interrupts = <0 17 1>;
+               altr,interrupt-type = <2>;
+               #gpio-cells = <2>;
+               gpio-controller;
+           };
+
+           /* FPGA DIP switch PIO – input, no interrupt */
+           dipsw_pio: gpio@10070 {
+               compatible = "altr,pio-1.0";
+               reg = <0x0 0x10070 0x0 0x10>;
+               #gpio-cells = <2>;
+               gpio-controller;
+           };
+       };
+   };
+
+   /*
+    * Fragment 1 – add gpio-leds at root level, referencing the
+    * led_pio controller defined in fragment@0.
+    * GPIO_ACTIVE_HIGH = 0 (numeric, no header dependency).
+    */
+   fragment@1 {
+       target-path = "/";
+       __overlay__ {
+           soc_leds: fpga-leds {
+               compatible = "gpio-leds";
+
+               led_fpga0: fpga0 {
+                   label = "fpga_led0";
+                   gpios = <&led_pio 0 0>;
+               };
+
+               led_fpga1: fpga1 {
+                   label = "fpga_led1";
+                   gpios = <&led_pio 1 0>;
+               };
+
+               led_fpga2: fpga2 {
+                   label = "fpga_led2";
+                   gpios = <&led_pio 2 0>;
+               };
+           };
+       };
+   };
+};
\ No newline at end of file
diff --git a/meta-custom/recipes-fpga/fpga-linux-overlay/fpga-linux-overlay.bb b/meta-custom/recipes-fpga/fpga-linux-overlay/fpga-linux-overlay.bb
new file mode 100644
index 0000000..d209c7a
--- /dev/null
+++ b/meta-custom/recipes-fpga/fpga-linux-overlay/fpga-linux-overlay.bb
@@ -0,0 +1,32 @@
+SUMMARY = "FPGA fabric configuration device tree overlay"
+DESCRIPTION = "Compiles fabric_overlay.dts to fabric_overlay.dtb and installs it to \
+/lib/firmware so that userspace or an early-boot service can apply it via \
+the kernel configfs overlay interface to trigger Linux-side FPGA programming."
+SECTION = "bsp"
+
+LICENSE = "GPL-2.0-only"
+LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"
+
+DEPENDS = "dtc-native"
+
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+SRC_URI = "file://fabric_overlay.dts"
+
+S = "${UNPACKDIR}"
+
+PACKAGE_ARCH = "${MACHINE_ARCH}"
+
+do_configure[noexec] = "1"
+
+do_compile() {
+    # -@ generates __symbols__ and __fixups__ nodes so the kernel can resolve
+    # phandle references to the base DTB (e.g. &intc for button interrupts).
+    dtc -@ -I dts -O dtb -o ${B}/fabric_overlay.dtb ${UNPACKDIR}/fabric_overlay.dts
+}
+
+do_install() {
+    install -D -m 0644 ${B}/fabric_overlay.dtb \
+        ${D}${nonarch_base_libdir}/firmware/fabric_overlay.dtb
+}
+
+FILES:${PN} = "${nonarch_base_libdir}/firmware/fabric_overlay.dtb"
diff --git a/meta-custom/recipes-kernel/linux/linux-socfpga-lts/configs/config_agilex5.cfg b/meta-custom/recipes-kernel/linux/linux-socfpga-lts/configs/config_agilex5.cfg
index c5d0ec8..8a4764d 100644
--- a/meta-custom/recipes-kernel/linux/linux-socfpga-lts/configs/config_agilex5.cfg
+++ b/meta-custom/recipes-kernel/linux/linux-socfpga-lts/configs/config_agilex5.cfg
@@ -1,3 +1,12 @@
+CONFIG_OF_RESOLVE=y
+CONFIG_OF_OVERLAY=y
+CONFIG_OF_CONFIGFS=y
+CONFIG_FPGA_MGR_STRATIX10_SOC=y
+CONFIG_FPGA_BRIDGE=y
+CONFIG_FPGA_REGION=y
+CONFIG_OF_FPGA_REGION=y
+CONFIG_OVERLAY_FS=y
+CONFIG_ALTERA_SYSID=y
 CONFIG_MARVELL_PHY=y
 CONFIG_OF_MDIO=y
 CONFIG_VLAN_8021Q=y
@@ -14,3 +23,4 @@ CONFIG_DMATEST=y
 CONFIG_MTD_NAND_CADENCE=y
 CONFIG_I3C=m
 CONFIG_DW_I3C_MASTER=m
+CONFIG_GPIO_ALTERA=y
diff --git a/meta-custom/recipes-kernel/linux/linux-socfpga-lts_%.bbappend b/meta-custom/recipes-kernel/linux/linux-socfpga-lts_%.bbappend
index 5cbb2ab..44eb927 100644
--- a/meta-custom/recipes-kernel/linux/linux-socfpga-lts_%.bbappend
+++ b/meta-custom/recipes-kernel/linux/linux-socfpga-lts_%.bbappend
@@ -104,4 +104,9 @@ do_patch:append() {
 }
 
 
+# Compile all DTBs with -@ so they include a __symbols__ node.
+# This is required for the configfs device tree overlay mechanism to resolve
+# phandle references (e.g. &intc) from the FPGA fabric overlay at runtime.
+KERNEL_DTC_FLAGS:append = " -@"
+
 addtask do_patch after do_unpack before do_configure
```

3\. Apply the patch file:


```bash
patch -p1 < fabric-config-linux.patch
```



4\. Build Yocto


```bash
python3 -m venv venv --system-site-packages
source venv/bin/activate
pip install --upgrade pip
pip install kas
pip install --upgrade kas
pip install kconfiglib
kas build kas.yml gsrd-console-image
```


The following relevant files are created in `$TOP_FOLDER/agilex3_soc_devkit_ghrd/software/yocto_linux/build/tmp/deploy/images/agilex3/`:

* `gsrd-console-image-agilex5e.rootfs.wic`
* `u-boot-spl-dtb.hex`



### Build QSPI Image



```bash
cd $TOP_FOLDER
rm -f baseline.hps.jic baseline.core.rbf
quartus_pfg \
-c agilex3_soc_devkit_ghrd/install/binaries/baseline.sof baseline.jic \
-o device=MT25QU128  \
-o flash_loader=A3CW135BM16AE6S \
-o hps_path=agilex3_soc_devkit_ghrd/software/yocto_linux/build/tmp/deploy/images/agilex3/u-boot-spl-dtb.hex \
-o mode=ASX4 \
-o hps=1
```




## Run Example

The instructions from this section present how to run the remote debug example. Refer to the HPS Baseline System Example Design for more detailed instructions on how to set up the board, serial port, and write the binaries.

1\. Write the SD card image: `$TOP_FOLDER/agilex3_soc_devkit_ghrd/software/yocto_linux/build/tmp/deploy/images/agilex3/gsrd-console-image-agilex3.rootfs.wic`

2\. Write the QSPI image: `$TOP_FOLDER/baseline.hps.jic`.

3\. Power up board

4\. On the serial console, enter 'root' as username to log into Linux. No password will be requested.

5\. List the LEDs registered with Linux:

```bash
root@agilex3:~# ls /sys/class/leds/
hps_led0  hps_led1  mmc0::
```

6\. Configure the FGPA fabric by using the device tree overlay:

```bash
root@agilex3:~# mkdir /sys/kernel/config/device-tree/overlays/fpgas/fpga/path
root@agilex3:~# echo fabric_overlay.dtb > /sys/kernel/config/device-tree/overlay 
[ 3202.413832] fpga_manager fpga0: writing ghrd.core.rbf to Stratix10 SOC FPGA Manager
[ 3204.553879] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-region/ranges
[ 3204.563681] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-region/firmware-name
[ 3204.573962] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-region/config-complete-timeout-us
[ 3204.585534] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/led_pio
[ 3204.595322] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/button_pio
[ 3204.605346] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/soc_leds
[ 3204.615186] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/led_fpga0
[ 3204.625116] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/led_fpga1
[ 3204.635043] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/led_fpga2
```

7\. List again the LEDs registered with Linux:

```bash
root@agilex3:~# ls /sys/class/leds/
fpga_led0  fpga_led1  fpga_led2  hps_led0   hps_led1   mmc0::
```


8\. Stop the background application which scrolls the FPGA LEDs:

```bash
root@agilex3:~# ./alteraFPGA/scroll_client -1
```

9\. Display the status of FPGA LED0:

```bash
root@agilex3:~# cat /sys/class/leds/fpga_led0/brightness
0
```

10\. Change the value of FPGA LED0:

```bash
root@agilex3:~# echo 1 > /sys/class/leds/fpga_led0/brightness
```

11\. Read back the value to confirm it changed:

```bash
root@agilex3:~# cat /sys/class/leds/fpga_led0/brightness
1
```

>*Note*: You can also see the LEDs being turned on and off, in addition to looking at the sysfs entries above.

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