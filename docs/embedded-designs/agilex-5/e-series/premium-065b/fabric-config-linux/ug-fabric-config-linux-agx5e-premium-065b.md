

## Introduction

The HPS Baseline System Example Design configures the FPGA fabric from U-Boot. This Tutorial example design shows how to customize the Yocto recipes for the HPS Baseline System Example Design to configure the fabric from Linux, instead of U-Boot.

The following modifications are done:

* Use `0` as `board_id` in the boot script, so that the vanilla Linux device tree is used at boot time, which does not need the fabric to be configured.
* Copy the `core.rbf` file in `/lib/firmware` on the target rootfs
* Create a device tree overlay `fabric_overlay.dtb` and also copy it in `/lib/firmware` on the target rootfs
* Update the kernel configuration to include the required additional drivers and settings.

### Prerequisites

The following are needed:

* [Agilex 5 FPGA E-Series 065B Premium Development Kit](https://www.altera.com/products/devkit/po-3284/agilex-5-fpga-e-series-065b-premium-development-kit), ordering code DK-A5E065BB32AEA. Other Agilex 5 development boards will also work in the same manner, just that other set HPS Baseline System Example Design binaries will be used.
* Host PC with Linux (Ubuntu 22.04 was used, but others should work too)
* Quartus Pro 26.1 (or just Quartus Pro standalone Programmer 26.1).
* Ashling RiscFree bundled with Quartus Pro 26.1 (can be installed and use with just the standalone Programmer)
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
source ~/altera_pro/26.1/qinit.sh
```







### Build Hardware Design





```bash
cd $TOP_FOLDER
rm -rf agilex5_soc_devkit_ghrd && mkdir agilex5_soc_devkit_ghrd && cd agilex5_soc_devkit_ghrd
wget https://github.com/altera-fpga/agilex5e-ed-gsrd/releases/download/QPDS26.1_REL_GSRD_PR/a5ed065b-premium-devkit-oobe-baseline-a55.zip
unzip a5ed065b-premium-devkit-oobe-baseline-a55.zip
rm -f a5ed065b-premium-devkit-oobe-baseline-a55.zip
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
Fw+Ql7Nv4X9zPqbwLCYAAA==
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