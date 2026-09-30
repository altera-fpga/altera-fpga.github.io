## Reconfiguring Core Fabric from Linux

Reconfiguration of FPGA Core Fabric can be implemented by using the Linux device tree overlay mechanism, it is a powerful and flexible mechanism to enable the customization of the device tree during in run-time.

**Note**:

* This feature is supported with Linux* kernel v4.9 LTSI and onwards. 
* The Linux* kernel for Stratix® and Agilex® SoC FPGA devices allow you to enable the programming of FPGA from within the OS.
* Refer to *Build Linux* for the prerequisite work.

To implement the FPGA reconfiguration at kernel level, the following changes must be made to the kernel source code:

1\. Create a new overlay file, use filename "overlay.dts" as example, and add the overlay information of the RBF file:

```bash
cd $TOP_FOLDER
vi linux-socfpga/arch/arm64/boot/dts/intel/overlay.dts

# Add the DTS file content:
==============================================================
/dts-v1/;
/plugin/;
/ {
	fragment@0 {
		target-path = "/soc/base_fpga_region";
		#address-cells = <2>;
		#size-cells = <2>;
		__overlay__ {
			#address-cells = <2>;
			#size-cells = <2>;

			firmware-name = "overlay.rbf";
			config-complete-timeout-us = <30000000>;
		};
	};
};
==============================================================
```

The explanation of the keywords:

| Keyword | Meaning |
| :-- | :-- |
| fragment@0 | Node Name of the Overlay |
| target-path | Refers to base_fpga_region located in arch/arm64/boot/dts/intel/socfpga_agilex.dtsi. This will invoke the driver: drivers/fpga/of-fpga-region.c |
| fragment@0 <br>#address-cells<br>#size-cells | This specifies the number of cells (32-bit size) to be used for the child's address map. For overlays, this value must be set to avoid "default_addr_size" errors |
| \_\_overlay__ <br>#address-cells<br>#size-cells | These fields should match those in arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |
| firmware-name = "overlay.rbf" | The fabric's file name |
|||


2\. Add the newly created overlay file **overlay.dtb** into the Makefile:

```bash
cd $TOP_FOLDER
vi linux-socfpga/arch/arm64/boot/dts/intel/Makefile

# Append to existing Makefile content, continue with ONE Device Tree Blob according to your device:
==============================================================
# Stratix® 10 SoC FPGA device:
dtb-$(CONFIG_ARCH_AGILEX) += socfpga_stratix10_socdk.dtb
dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += overlay.dtb

# Agilex® 7 SoC FPGA device:
dtb-$(CONFIG_ARCH_AGILEX) += socfpga_agilex_socdk.dtb
dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += overlay.dtb

# Agilex® 5 SoC FPGA device:
dtb-$(CONFIG_ARCH_AGILEX) += socfpga_agilex5_socdk.dtb
dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += overlay.dtb

# Agilex® 3 SoC FPGA device:
dtb-$(CONFIG_ARCH_AGILEX) += socfpga_agilex3_socdk.dtb
dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += overlay.dtb

==============================================================
```

3\. The commands to configure and build the Linux kernel are:

```bash
cd $TOP_FOLDER 
cd linux-socfpga
make clean && make mrproper
make defconfig
# enable device tree overlays and fpga bridges
./scripts/config --set-val CONFIG_INTEL_STRATIX10_SERVICE y
./scripts/config --set-val CONFIG_FPGA y
./scripts/config --set-val CONFIG_FPGA_BRIDGE y
./scripts/config --set-val CONFIG_FPGA_MGR_STRATIX10_SOC y
./scripts/config --set-val CONFIG_FPGA_REGION y
./scripts/config --set-val CONFIG_OF_FPGA_REGION y
./scripts/config --set-val CONFIG_FW_LOADER y
./scripts/config --set-val CONFIG_FW_LOADER_PAGED_BUF y
./scripts/config --set-val CONFIG_FW_LOADER_SYSFS y
./scripts/config --set-val CONFIG_FW_LOADER_USER_HELPER y

# Build the Linux kernel image, continue with ONE command according to your device:
# Stratix® 10 SoC FPGA device:
make -j 48 Image && make intel/socfpga_stratix10_socdk.dtb && make intel/overlay.dtb

# Agilex® 7 SoC FPGA device:
make -j 48 Image && make intel/socfpga_agilex_socdk.dtb && make intel/overlay.dtb

# Agilex® 5 SoC FPGA device:
make -j 48 Image && make intel/socfpga_agilex5_socdk.dtb && make intel/overlay.dtb

# Agilex® 3 SoC FPGA device:
make -j 48 Image && make intel/socfpga_agilex3_socdk.dtb && make intel/overlay.dtb
```

When you build the Linux* kernel for this feature, two <*.dtb> files are generated under $TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/:

* socfpga_*DEVICE*_socdk.dtb --- The default *.dtb file used with the kernel image to boot the system.
* overlay.dtb --- The *.dtb file used to trigger FPGA configuration in OS.


4\. In your hardware (GHRD) compilation output folder, rename the FPGA configuration file (.rbf) to "overlay.rbf". Then, copy both the **overlay.rbf** and the **overlay.dtb** files to the Root File System:

```bash
$ mkdir -p $TOP_FOLDER/sd_card/rootfs/lib/firmware

$ cd $TOP_FOLDER/linux-socfpga/arch/arm64/boot/dts/intel/
$ cp overlay.dtb $TOP_FOLDER/sd_card/rootfs/lib/firmware/

$ cd [GHRD_OUTPUT_DIR i.e. ghrd/output_files/]
$ mv <DEVICE_GHRD>.core.rbf overlay.rbf
# e.g. mv ghrd_a5ed065bb32ae5s.core.rbf overlay.rbf
$ cp overlay.rbf $TOP_FOLDER/sd_card/rootfs/lib/firmware/

# To create the SD Card Image:
cd $TOP_FOLDER/sd_card/

# Get the make_sdimage_p3.py
wget https://releases.rocketboards.org/release/2020.11/gsrd/tools/make_sdimage_p3.py

# remove mkfs.fat parameter which has some issues on Ubuntu 22.04
sed -i 's/\"\-F 32\",//g' make_sdimage_p3.py
chmod +x make_sdimage_p3.py

sudo python3 make_sdimage_p3.py -f \
-P fatfs/*,num=1,format=fat32,size=512M \
-P rootfs/*,num=2,format=ext3,size=512M \
-s 1024M \
-n sdcard.img
```

**Note**: Refer to *Create SD Card Image* for the full instructions.


5\. The changes above allow you to program the FPGA in Linux* by applying an overlay on the system. Next, you may boot your device to Linux.

```bash
# In the U-boot Shell, run the following commands to load the kernel image and boot to Linux. 
# This step is not required if your device boots to Linux automatically.
Hit any key to stop autoboot:  0 /// Hit any key at this point to enter the U-boot Shell ///

# Stratix® 10 SoC FPGA device:
mmc rescan
fatload mmc 0:1 01000000 Image
fatload mmc 0:1 08000000 socfpga_stratix10_socdk.dtb
setenv bootargs console=ttyS0,115200 root=${mmcroot} rw rootwait;
booti 0x01000000 - 0x08000000

# Agilex® 7 SoC FPGA device:
mmc rescan
fatload mmc 0:1 02000000 Image
fatload mmc 0:1 06000000 socfpga_agilex_socdk.dtb
setenv bootargs console=ttyS0,115200 root=${mmcroot} rw rootwait;
booti 0x02000000 - 0x06000000

# Agilex® 5 SoC FPGA device:
mmc rescan
fatload mmc 0:1 82000000 Image
fatload mmc 0:1 86000000 socfpga_agilex5_socdk.dtb
setenv bootargs console=ttyS0,115200 root=${mmcroot} rw rootwait;
booti 0x82000000 - 0x86000000

# Agilex® 3 SoC FPGA device:
mmc rescan
fatload mmc 0:1 82000000 Image
fatload mmc 0:1 86000000 socfpga_agilex3_socdk.dtb
setenv bootargs console=ttyS0,115200 root=${mmcroot} rw rootwait;
booti 0x82000000 - 0x86000000

```

6\. After you boot to Linux and log in with root privilege, use the following command to begin FPGA configuration:

```bash
mkdir /sys/kernel/config/device-tree/overlays/0
cd /lib/firmware/
echo overlay.dtb > /sys/kernel/config/device-tree/overlays/0/path
```

7\. If you want to re-apply the overlay, you have to first remove the existing overlay, and then re-run the previous steps:

```bash
rmdir /sys/kernel/config/device-tree/overlays/0
mkdir /sys/kernel/config/device-tree/overlays/0
cd /lib/firmware/
echo overlay.dtb >/sys/kernel/config/device-tree/overlays/0/path
```
