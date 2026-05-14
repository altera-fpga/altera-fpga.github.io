

## Introduction

The HPS Baseline System Example Design configures the FPGA fabric from U-Boot. This Tutorial example design shows how to customize the Yocto recipes for the HPS Baseline System Example Design to configure the fabric from Linux, instead of U-Boot.

The following modifications are done:

* Use `0` as `board_id` in the boot script, so that the vanilla Linux device tree is used at boot time, which does not need the fabric to be configured.
* Copy the `core.rbf` file in `/lib/firmware` on the target rootfs
* Create a device tree overlay `fabric_overlay.dtb` and also copy it in `/lib/firmware` on the target rootfs
* Update the kernel configuration to include the required additional drivers and settings.

### Prerequisites

The following are needed:

* [Agilex 3 FPGA and SoC C-Series Development Kit](https://www.altera.com/products/devkit/po-3000/agilex-3-fpga-and-soc-c-series-development-kit), ordering code DK-A3W135BM16AEA. Other Agilex 3 development boards will also work in the same manner, just that other set HPS Baseline System Example Design binaries will be used.
* Host PC with Linux (Ubuntu 22.04 was used, but others should work too)
* Quartus Pro 26.1 (or just Quartus Pro standalone Programmer 26.1).
* Ashling RiscFree bundled with Quartus Pro 26.1 (can be installed and use with just the standalone Programmer)
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
source ~/altera_pro/26.1/qinit.sh
```







### Build Hardware Design





```bash
cd $TOP_FOLDER
rm -rf agilex3_soc_devkit_ghrd && mkdir agilex3_soc_devkit_ghrd && cd agilex3_soc_devkit_ghrd
wget https://github.com/altera-fpga/agilex3c-ed-gsrd/releases/download/QPDS26.1_REL_GSRD_PR/a3cw135-devkit-oobe-baseline.zip
unzip a3cw135-devkit-oobe-baseline.zip
rm -f a3cw135-devkit-oobe-baseline.zip
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
EOF
```


For reference, the `fabric-config-linux.patch` looks like this:
```diff
diff --git a/kas.yml b/kas.yml
index f3409fa..0ad3121 100644
--- a/kas.yml
+++ b/kas.yml
@@ -41,9 +41,11 @@ local_conf_header:
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
index 8971475..00139c8 100644
--- a/meta-custom/conf/layer.conf
+++ b/meta-custom/conf/layer.conf
@@ -46,6 +46,9 @@ IMAGE_INSTALL:append = "${@bb.utils.contains('GPIO_INT_TEST', 'true', ' pio-inte
 IMAGE_INSTALL:append = "${@bb.utils.contains('HELLO_WORLD_APP', 'true', ' hello', '', d) if d.getVar('SSBL_BOOT_SOURCE') != 'qspi' else ''}"
 IMAGE_INSTALL:append = "${@'' if d.getVar('SSBL_BOOT_SOURCE') == 'qspi' else ' rootfs-files'}"
 
+# Install ghrd.core.rbf and fabric_overlay.dtb to /lib/firmware in the rootfs.
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
index 9da6b0a..9dabc77 100644
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
+# Install core.rbf to /lib/firmware
+do_install () {
+    install -D -m 0644 ${S}/${FPGA_RBF_FILE} \
+        ${D}${nonarch_base_libdir}/firmware/${FPGA_RBF_FILE}
+}
+
+FILES:${PN} = "${nonarch_base_libdir}/firmware/*"
diff --git a/meta-custom/recipes-fpga/fpga-linux-overlay/files/fabric_overlay.dts b/meta-custom/recipes-fpga/fpga-linux-overlay/files/fabric_overlay.dts
new file mode 100644
index 0000000..9d5b461
--- /dev/null
+++ b/meta-custom/recipes-fpga/fpga-linux-overlay/files/fabric_overlay.dts
@@ -0,0 +1,76 @@
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
+S = "${WORKDIR}"
+
+PACKAGE_ARCH = "${MACHINE_ARCH}"
+
+do_configure[noexec] = "1"
+
+do_compile() {
+    # -@ generates __symbols__ and __fixups__ nodes so the kernel can resolve
+    # phandle references to the base DTB (e.g. &intc for button interrupts).
+    dtc -@ -I dts -O dtb -o ${B}/fabric_overlay.dtb ${WORKDIR}/fabric_overlay.dts
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




## Exercise Example Design

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