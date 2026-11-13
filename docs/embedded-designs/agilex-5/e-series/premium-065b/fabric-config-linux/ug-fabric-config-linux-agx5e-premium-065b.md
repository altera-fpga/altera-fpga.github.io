

## Introduction

The HPS Baseline System Example Design (formerly known as "GSRD" or "Golden System Reference Design") configures the FPGA fabric from U-Boot. This Tutorial example design shows how to customize the Yocto recipes for the HPS Baseline System Example Design to configure the fabric from Linux, instead of U-Boot.

The following modifications are done:

* Use `0` as `board_id` in the boot script, so that the vanilla Linux device tree is used at boot time, which does not need the fabric to be configured.
* Copy the `core.rbf` file in `/lib/firmware` on the target rootfs
* Create a device tree overlay `fabric_overlay.dtb` and also copy it in `/lib/firmware` on the target rootfs
* Update the kernel configuration to include the required additional drivers and settings.

### Prerequisites

The following are needed:

* [Agilex 5 FPGA E-Series 065B Premium Development Kit](https://www.altera.com/products/devkit/po-3284/agilex-5-fpga-e-series-065b-premium-development-kit), ordering code DK-A5E065BB32AEA. Other Agilex 5 development boards will also work in the same manner, just that other set HPS Baseline System Example Design binaries will be used.
* Host PC with Linux (Ubuntu 22.04 was used, but others should work too)
* Quartus Pro 26.3 (or just Quartus Pro standalone Programmer 26.3).
* Ashling RiscFree bundled with Quartus Pro 26.3 (can be installed and use with just the standalone Programmer)
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
source ~/altera_pro/26.3/qinit.sh
```







### Build Quartus Design





```bash
cd $TOP_FOLDER
rm -rf agilex5_soc_devkit_ghrd && mkdir agilex5_soc_devkit_ghrd && cd agilex5_soc_devkit_ghrd
wget https://github.com/altera-fpga/agilex5-ed-hps-baseline/releases/download/QPDS26.3_REL_BASELINE_PR/dk-a5e065bb32aea-enablement-baseline-a55.zip
unzip dk-a5e065bb32aea-enablement-baseline-a55.zip
rm -f dk-a5e065bb32aea-enablement-baseline-a55.zip
make baseline_a55-install
```


The following files are created:

* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/baseline_a55.sof`
* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/baseline_a55.core.rbf`



### Build Yocto Using Kas



1\. Copy the `core.rbf` file to where the recipes needs it


```bash
cd $TOP_FOLDER/agilex5_soc_devkit_ghrd/software/yocto_linux
cp $TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/baseline_a55.core.rbf \
   $TOP_FOLDER/agilex5_soc_devkit_ghrd/software/yocto_linux/meta-custom/recipes-fpga/fpga-bitstream/files/ghrd.core.rbf
```


2\. Create the patch file for customizing Yocto to configure fabric from Linux:


```bash
base64 -d <<'EOF' | gunzip > fabric-config-linux.patch
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
EOF
```


For reference, the `fabric-config-linux.patch` looks like this:
```diff
diff --git a/kas.yml b/kas.yml
index 38f6377..9c97d4d 100644
--- a/kas.yml
+++ b/kas.yml
@@ -55,9 +55,11 @@ local_conf_header:
     CUSTOM_LINUX_DEVICE_TREE = "0"
 
   # RBF file should be placed in meta-custom/recipes-fpga/fpga-bitstream/files/
+  # FPGA_ENABLE_CORE_PGM=0: RBF is NOT embedded in kernel.itb; instead it is
+  # installed to /lib/firmware in the rootfs for Linux-side fabric configuration.
   fpga-bitstream: |
-    FPGA_ENABLE_CORE_PGM ?= "1"
-    FPGA_RBF_FILE ?= "baseline_a55.core.rbf"
+    FPGA_ENABLE_CORE_PGM ?= "0"
+    FPGA_RBF_FILE ?= "ghrd.core.rbf"
 
   kernel-modules: |
     KERNEL_MODULE_PROBECONF = "cfg80211"
diff --git a/meta-custom/conf/layer.conf b/meta-custom/conf/layer.conf
index 244bb8d..02897b4 100644
--- a/meta-custom/conf/layer.conf
+++ b/meta-custom/conf/layer.conf
@@ -49,6 +49,10 @@ IMAGE_INSTALL:append = "${@bb.utils.contains('HELLO_WORLD_APP', 'true', ' hello'
 IMAGE_INSTALL:append = " rootfs-files"
 IMAGE_INSTALL:append = "${@'' if d.getVar('SSBL_BOOT_SOURCE') == 'qspi' else ' test-suite-agilex5'}"
 
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
-o flash_loader=A5ED065BB32AE4S \
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