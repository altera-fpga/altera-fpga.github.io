

## Introduction

The HPS Baseline System Example Design (formerly known as "GSRD" or "Golden System Reference Design") configures the FPGA fabric from U-Boot. This Tutorial example design shows how to customize the Yocto recipes for the HPS Baseline System Example Design to configure the fabric from Linux, instead of U-Boot.

The following modifications are done:

* Use `0` as `board_id` in the boot script, so that the vanilla Linux device tree is used at boot time, which does not need the fabric to be configured.
* Copy the `core.rbf` file in `/lib/firmware` on the target rootfs
* Create a device tree overlay `fabric_overlay.dtb` and also copy it in `/lib/firmware` on the target rootfs
* Update the kernel configuration to include the required additional drivers and settings.

### Prerequisites

The following are needed:

* [Agilex 5 FPGA E-Series 065A Premium Development Kit](https://www.altera.com/products/devkit/po-3285/agilex-5-fpga-e-series-065a-premium-development-kit), ordering code DK-A5E065AB32AEA. Other Agilex 5 development boards will also work in the same manner, just that other set HPS Baseline System Example Design binaries will be used.
* Host PC with Linux (Ubuntu 22.04 was used, but others should work too)
* Quartus Pro 26.1.1 (or just Quartus Pro standalone Programmer 26.1.1).
* Ashling RiscFree bundled with Quartus Pro 26.1.1 (can be installed and use with just the standalone Programmer)
* Network access, for downloading the sources while building the binaries

## Build Example Design




### Setup Environment

Create a folder to contain all the example files:


```bash
sudo rm -rf agilex5.fabric-config-linux
mkdir agilex5.fabric-config-linux
cd agilex5.fabric-config-linux
export TOP_FOLDER=`pwd`
```


Enable Quartus tools to be called from command line:


```bash
source ~/altera_pro/26.1.1/qinit.sh
```







### Build Quartus Design





```bash
cd $TOP_FOLDER
rm -rf agilex5_soc_devkit_ghrd && mkdir agilex5_soc_devkit_ghrd && cd agilex5_soc_devkit_ghrd
wget https://github.com/altera-fpga/agilex5e-ed-gsrd/releases/download/QPDS26.1.1_REL_GSRD_PR/dk-a5e065ab32aea-enablement-baseline-a55.zip
unzip dk-a5e065ab32aea-enablement-baseline-a55.zip
rm -f dk-a5e065ab32aea-enablement-baseline-a55.zip
make baseline_a55-install
```


The following files are created:

* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/baseline_a55.sof`
* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/ghrd.core.rbf`



### Build Yocto Using Kas



1\. Copy the `core.rbf` file to where the recipes needs it


```bash
cd $TOP_FOLDER/agilex5_soc_devkit_ghrd/software/yocto_linux
cp $TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/ghrd.core.rbf \
   $TOP_FOLDER/agilex5_soc_devkit_ghrd/software/yocto_linux/meta-custom/recipes-fpga/fpga-bitstream/files/
```


2\. Create the patch file for customizing Yocto to configure fabric from Linux:


```bash
base64 -d <<'EOF' | gunzip > fabric-config-linux.patch
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
4iHycv4t/A+GJXOnMCYAAA==
EOF
```


For reference, the `fabric-config-linux.patch` looks like this:
```diff
diff --git a/kas.yml b/kas.yml
index 1e65ede..cf7eb7a 100644
--- a/kas.yml
+++ b/kas.yml
@@ -41,9 +41,11 @@ local_conf_header:
     CUSTOM_LINUX_DEVICE_TREE = "0"
 
   # RBF file should be placed in meta-custom/recipes-fpga/fpga-bitstream/files/
+  # FPGA_ENABLE_CORE_PGM=0: RBF is NOT embedded in kernel.itb; instead it is
+  # installed to /lib/firmware in the rootfs for Linux-side fabric configuration.
   fpga-bitstream: |
-    FPGA_ENABLE_CORE_PGM ?= "1"
-    FPGA_RBF_FILE ?= "baseline_a55_hps_debug.core.rbf"
+    FPGA_ENABLE_CORE_PGM ?= "0"
+    FPGA_RBF_FILE ?= "ghrd.core.rbf"
 
   kernel-modules: |
     KERNEL_MODULE_PROBECONF = "cfg80211"
diff --git a/meta-custom/conf/layer.conf b/meta-custom/conf/layer.conf
index 15a2b0a..7c5edbd 100644
--- a/meta-custom/conf/layer.conf
+++ b/meta-custom/conf/layer.conf
@@ -48,6 +48,10 @@ IMAGE_INSTALL:append = "${@bb.utils.contains('GPIO_INT_TEST', 'true', ' pio-inte
 IMAGE_INSTALL:append = "${@bb.utils.contains('HELLO_WORLD_APP', 'true', ' hello', '', d)}"
 IMAGE_INSTALL:append = " rootfs-files"
 
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
index 0000000..7a79f66
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
index 5571dec..ec29f17 100644
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


The following relevant files are created in `$TOP_FOLDER/agilex5_soc_devkit_ghrd/software/yocto_linux/build/tmp/deploy/images/agilex5e/`:

* `gsrd-console-image-agilex5e.rootfs.wic`
* `u-boot-spl-dtb.hex`


### Build QSPI Image



```bash
cd $TOP_FOLDER
rm -f baseline.hps.jic baseline.core.rbf
quartus_pfg \
-c agilex5_soc_devkit_ghrd/install/binaries/baseline_a55.sof baseline.jic \
-o device=MT25QU128 \
-o flash_loader=A5ED065AB32AE1V \
-o hps_path=agilex5_soc_devkit_ghrd/software/yocto_linux/build/tmp/deploy/images/agilex5e/u-boot-spl-dtb.hex \
-o mode=ASX4 \
-o hps=1
```


The following file is created:

* `$TOP_FOLDER/baseline.hps.jic`



## Exercise Example Design

1\. Write the SD card image: `$TOP_FOLDER/agilex5_soc_devkit_ghrd/software/yocto_linux/build/tmp/deploy/images/agilex5e/gsrd-console-image-agilex5e.rootfs.wic`

2\. Write the QSPI image: `$TOP_FOLDER/baseline.hps.jic`.

3\. Power up board

4\. On the serial console, enter 'root' as username to log into Linux. No password will be requested.

5\. List the LEDs registered with Linux:

```bash
root@agilex5e:~# ls /sys/class/leds/
hps_led0  mmc0::
```

6\. Configure the FGPA fabric by using the device tree overlay:

```bash
root@agilex5e:~# mkdir /sys/kernel/config/device-tree/overlays/fpga
root@agilex5e:~# echo fabric_overlay.dtb > /sys/kernel/config/device-tree/overlays/fpga/path
[ 1860.286191] fpga_manager fpga0: writing ghrd.core.rbf to Stratix10 SOC FPGA Manager
[ 1862.465656] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-region/ranges
[ 1862.475299] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-region/firmware-name
[ 1862.485520] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-region/config-complete-timeout-us
[ 1862.496933] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/led_pio
[ 1862.506634] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/button_pio
[ 1862.516594] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/dipsw_pio
[ 1862.526467] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/soc_leds
[ 1862.536256] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/led_fpga0
[ 1862.546129] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/led_fpga1
[ 1862.556003] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/led_fpga2
```

7\. List again the LEDs registered with Linux:

```bash
root@agilex5e:~# ls /sys/class/leds/
fpga_led0  fpga_led1  fpga_led2  hps_led0   mmc0::
```

8\. Stop the background application which scrolls the FPGA LEDs:

```bash
root@agilex5e:~# ./alteraFPGA/scroll_client -1
```

9\. Display the status of FPGA LED0:

```bash
root@agilex5e:~# cat /sys/class/leds/fpga_led0/brightness
0
```

10\. Change the value of FPGA LED0:

```bash
root@agilex5e:~# echo 1 > /sys/class/leds/fpga_led0/brightness
```

11\. Read back the value to confirm it changed:

```bash
root@agilex5e:~# cat /sys/class/leds/fpga_led0/brightness
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