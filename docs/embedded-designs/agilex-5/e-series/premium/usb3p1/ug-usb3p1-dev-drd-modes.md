


# USB 3.1 Gen-1 Controller in Host Mode, Device Mode, and Dual-Role Device Mode

## Introduction

USB 3.1 is a significant advancement of the Universal Serial Bus (USB) standard, delivering notable improvements in data transfer speed, power efficiency, and overall system performance. The USB 3.1 Gen 1 controller integrated in the Agilex™ 5 E-Series supports SuperSpeed operation with a maximum data transfer rate of up to 5 gigabits per second (5 Gbps). It maintains backward compatibility with USB 2.0 devices and supports both the traditional Type-A connector and the versatile USB Type-C interface.

Beyond higher throughput, USB 3.1 introduces enhancements in power management and data encoding efficiency, making it well suited for high-bandwidth applications such as 4K video streaming and high-speed external storage. As a result, USB 3.1 serves as a key technology for enabling fast, reliable, and efficient data communication in embedded systems and Hard Processor System (HPS)–based designs.

## Overview

The Hard Processor System (HPS) on the Agilex™ 5 E-Series Premium Development Kit incorporates a USB 3.1 Gen 1 controller that supports Host, Device, and Dual-Role Device (DRD) operating modes to address a wide range of high-speed application requirements. The controller is compliant with both USB 2.0 and USB 3.1 protocols, ensuring flexibility and broad device compatibility.

This page provides step-by-step guidance on configuring and enabling Host Mode, Device Mode, and Dual-Role Device (DRD) Mode on the Agilex™ 5 E-Series platform.

**Note**: Device Mode is also known as Gadget Mode and Peripheral Mode.

![Agilex 5 Premium Devkit](./images/00_agilex5_premium_devkit.png)

For the enablement of the three modes, there are modifications to be made respectively on the Golden Hardware System Design (GHRD) and/or Yocto Build, please refer to the table below to understand the modification required for each mode.

| USB 3.1 Mode | GHRD & Yocto |
| :-- | :-- |
| Host | Use Default, No Changes |
| Device | Patch* on Yocto Required |
| Dual Role Device | Patch* on Yocto Required |

\* The patches are downloadable in Section 2.1 and 3.1 below.

These are the subsections included in this page:

 1. **USB 3.1 in Host Mode**
  
    1.1 Build SD Card Binaries

    1.2 Verification - Transfer a file to a Removable Storage

 2. **USB 3.1 in Device Mode**

    2.1 Build SD Card Binaries with Patch

    2.2 Verification - Using the Dev-Kit as a Removable Storage

 3. **USB 3.1 in Dual-Role Device (DRD) Mode**

    3.1 Build SD Card Binaries with Patch

    3.2 Verification - Using the Dev-Kit in DRD Mode

## Prerequisites

### Development Kit

This tutorial example design is based on the Agilex 5 E-Series Premium Development Kit GSRD. It is recommended that you familiarize yourself with the GSRD development flow before proceeding with this tutorial. The HPS Enablement Expansion Board (also referred as HPS Daughter Card) is included with the development kit.

* Altera Agilex 5 FPGA E-Series 065B Premium Development Kit, ordering code DK-A5E065BB32AEA.
  * HPS Enablement Expansion Board. Included with the development kit
  * HPS NAND Board. Enables eMMC storage for HPS. Orderable separately
  * HPS Test Board. Supports SD card boot, and external Arm tracing. Orderable separately
  * Mini USB Cable. Included with the development kit
  * Micro USB Cable. Included with the development kit
  * Ethernet Cable. Included with the development kit
  * Micro SD card and USB card writer. Included with the development kit
  
Refer to [Development Kit](https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/premium-065b/gsrd/ug-gsrd-agx5e-premium-065b/) for details about the board, including how to install the HPS Boards, and how to set the MSEL DIP switches.

### Development Environment

This is the recommended setting for the system used for compilation of the boot image.

* Host PC with
  * Ubuntu 22.04 LTS host machine
  * 64 GB of RAM or more
  * Disk space of 100GB or more
  * Serial terminal (for example GtkTerm or Minicom on Linux and TeraTerm or PuTTY on Windows)
  * Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 26.1 
  * TFTP server. This used to download the eMMC binaries to board to be flashed by U-Boot
* Local Ethernet network, with DHCP server
* Internet connection. For downloading the files.

### Test Environment

This is the recommended setting for the system used for testing.

* Test PC with
  * Can be Windows OS or Linux OS
  * USB Ports
* USB Type-C thumbdrive larger than 5GB storage
* USB Type-C cable to connect to the dev-kit and Test PC

### Prebuilt Binaries

The prebuilt binaries is located at https://releases.rocketboards.org/2026.04/gsrd/agilex5_dk_a5e065bb32aea_gsrd.baseline-a55/

### Component Versions

The version of The HPS Baseline System Example Design (formerly known as GSRD or Golden System Reference Design) used in this page is the QPDS26.1_REL_GSRD_PR

### Release Notes

See https://github.com/altera-fpga/gsrd-socfpga/releases/tag/QPDS26.1_REL_GSRD_PR

## 1. USB 3.1 in Host Mode
  
### 1.1 Build SD Card Binaries

1\. To get the SD Card binaries, you may follow the steps in https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/premium-065b/gsrd/ug-gsrd-agx5e-premium-065b/#build-sd-card-binaries to generate the bootable SD Card image. Or, you may get the prebuilt binaries in [Prebuilt Binaries](#prebuilt-binaries)

2\. To boot up the dev-kit from SD Card, you may refer to https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/premium-065b/gsrd/ug-gsrd-agx5e-premium-065b/#hps-enablement-board for the steps to program the SD Card image.


### 1.2 Verification - Transfer a file to a Removable Storage

1\. Boot up the dev-kit with the SD Card and Quartus Programmer, login with “root”.

2\. Plug in the dev-kit’s USB Type-C port with a USB Type-C thumbdrive.

![Host Mode Thumbdrive Insert](./images/h1_thumbdrive_plugin.png)

3\. From the system message, the thumbdrive is attached as **/dev/sda1**.

4\. Mount the thumbdrive as a new mountpoint **mp1**.

```bash
mkdir /mnt/mp1
mount -t auto /dev/sda1 /mnt/mp1
```

5\. Create a sample file “test.txt” in /tmp, copy the file to the mounted drive. This step shows that the USB3.1 is now working in Host mode.

```bash
dd if=/dev/random of=/tmp/test.txt bs=1M count=200
cp /tmp/test.txt /mnt/mp1/
```

6\. Remove the test file from the mounted drive.

```bash
ls /mnt/mp1/test.txt
rm /mnt/mp1/test.txt
```

7\. At the end of the test, unmount the mounted drive. Thus, the Host mode is verified.

```bash
umount -l /mnt/mp1
```

![Host Mode Verification](./images/h1_verification.png)

## 2. USB 3.1 in Device Mode

### 2.1 Build SD Card Binaries with Patch

1\. Setup Environment

```bash
sudo rm -rf agilex5_065b_base.sd
mkdir agilex5_065b_base.sd
cd agilex5_065b_base.sd
export TOP_FOLDER=`pwd`
```

2\. Enable Quartus tools to be called from command line (**Note**: Use your Quartus installation path):

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
source ~/altera_pro/26.1/qinit.sh
```




3\. Setup Hardware Design and Yocto

```bash
cd $TOP_FOLDER
rm -rf agilex5e-ed-gsrd
git clone https://github.com/altera-fpga/agilex5e-ed-gsrd.git agilex5e-ed-gsrd
cd agilex5e-ed-gsrd
git checkout QPDS26.1_REL_GSRD_PR
```

4\. Run the following command in Linux shell to generate the file **usb3p1_device_enablement_QPDS26p1.patch** from the encoded data.

<details>
   <summary>
      <span style="color: #0056b3; font-weight: bold; cursor: pointer;">
      Click for the command to retrieve the encoded data
      </span>
   </summary>
   
```bash
base64 -d <<'EOF' | gunzip > usb3p1_device_enablement_QPDS26p1.patch
H4sIAAHsA2oCA81XW0/jOBR+nvwKq2hHsxTnUmjLlJ0VpbQQCWhFy2geVrKcxC0WbhzFDlDtzn/f
4ySFtnToaKYS5MG5nO/4XHw+5zji4zHCeMI1og6ts8ht1AOcpGzKsymO2P0d11jKgDkBVUzwmGFa
rztKjvUDTZkzk6GWBL5nj84dVc6UhrcAsmdTgYItT2jxOGKPKGg0gzr73LRtt+FG4WGDIs91GwcH
FsZ461FY1Wp1+5EcHyNc32ugqhngRciQChLKeExuGY1Y2rIQQqVGC/1n3hC6bHfO/asu+oIqdMIF
e6yzSiG58K9uvpHT0ZD0/IscoGQ4TiaUlEAC79GdHWlVsbDR6NwMR/1L8lJxHgyBYAp89VX8WkMk
UwGBFPGQFXPkXt6c9PsjctrtdfpXPf9snXbExiYLfLKi8tXvdMnouvtqbEHFip7rufLbpTBlmuIw
U1pOnZSFPGEK37E0ZsIpAEWEWKeMOT+VB0jv+3PKitkDGgMATWXE5mQqyOaWl20fsn06PtinOcuM
ESfOREGPdxmUoZi756Kqt9cwHLOqjoOGg9Nv+AIwsWLYj1is+ZgD29DZ4ALXbBfLWMwAuQtFv4s6
MpmlfHKr0afOn6jm1up7qC00SymI0kSmVHMZG6gDOmAV33vOkVXd4XEoMkjlayysggr619xMnYPg
2H1+NRe42xuctdFF9xQN/P6zQLCIJFy20ATG45rrwood5spo4QrlNAH/AlhWs18Ine4BHHu2Wzla
RqZsApC/3MenqdxHz/17BbVjrOGQCaEMurYqL8Qy1qkUgqUvbCim76nIWG5qUfn70bqoTzKtZbwc
eJB/exF7Y3uxN9bHzmNY9DRLNE6gcmNtVD7Cx/CHwDxHLvKayFvF5O48z6hnCVub0F9P+PqMnvoD
pB64Dm+XsxrxRD28SGpze0ltbrugvpfPz3E6uzlNYti/VM7GklMEuKJahjFqMZzlUHJDBlJZypuh
mSGv20L5bTUfggZMGP2c4YB+kQczcR7bx5KyyIWNxu+Tdmfkf+2Sc//s/MdMmNv3CvveRvveZvve
L9ivFfZrG+3XNtuvbbQ/vxe+wLr271kq6AxJuKfcrK/MtIIHlEqp88X+CHv//lN+opTk/zHwLGEp
T25hvxZz15SmOjM+VeQdnVUKQ9EWm+CNf7J8xOWPAQutnKLhUc7CH0yFIQrejSs/1yB8dhts7IXB
mgbhHYWy0Bbs511B0YuSm+EJKR57wy+zpc89ctkeDgn0v9fts+6KcEk0feNSIn/YQUCThMXRW+R8
wXxZHfV604tYSG3bC/cPGPO2e1b7PRffqDIXXTDVeHBoDoIwNs1JcHjdITfXfqtcRdiocua1HKfs
IfO94R8LffgA21kpUtDPylStE2UBHz8JFq65WAUsomEJqK4FLG5KMAmczCy0g9qZlphGEfQzAsGB
EDlm9E0LJOdRIKrRoH097KKRf9m1/gexdK8lbRAAAA==
EOF
```
   
</details>

**Note**: The patch changes the value of dr_mode in the &usb31 node from "host" to "peripheral" in the device tree file socfpga_agilex5_socdk.dts.

```bash
 &usb31 {
    status = "okay";
    dr_mode = "peripheral";
 };
```

5\. Apply the patch to enable Device Mode:

```bash
cp usb3p1_device_enablement_QPDS26p1.patch $TOP_FOLDER/agilex5e-ed-gsrd/
git apply usb3p1_device_enablement_QPDS26p1.patch
```

6\. Build Hardware Design and Yocto

```bash
cd $TOP_FOLDER/agilex5e-ed-gsrd/a5ed065b-premium-devkit-oobe/baseline-a55
make software-yocto_linux_sd-install-sw
```

7\. The following file is created:

* $TOP_FOLDER/agilex5e-ed-gsrd/a5ed065b-premium-devkit-oobe/baseline-a55/install/binaries/software/yocto_linux_sd/sdimage.tar.gz

### 2.2 Verification - Using the Dev-Kit as a Removable Storage

1\. Boot up the dev-kit with the SD Card and Quartus Programmer, login with “root”.

2\. Run the following commands to set up the dev-kit as a Storage Device.

```bash
dd if=/dev/random of=/tmp/test.img bs=1024 count=4096
mkfs.vfat /tmp/test.img
```

3\. Load the kernel driver for gadget storage.

```bash
modprobe libcomposite
modprobe usb_f_mass_storage
modprobe g_mass_storage file=/tmp/test.img removable=1
```

![Dev Mode Modprobe](./images/d1_modprobe.png)

4\. Plug in the dev-kit’s USB Type-C port with the USB Cable, connect the other end to the Test PC.
Observe that the dev-kit is being seen by Test PC as a storage.

![Dev Drive in Host](./images/16_device_mode_in_win.png)

5\. On the Test PC, write a file “device_test.txt” in the dev-kit storage. This step shows that the USB3.1 is now working in Device mode.

6\. On the dev-kit, create a new mountpoint **mp2**.

```bash
mkdir /mnt/mp2
mount /tmp/test.img /mnt/mp2
```

7\.  You should be able to read the file from both the dev-kit and Test PC.

```bash
ls /mnt/mp2/device_test.txt
```

8\. At the end of the test, unmount the mounted drive. Thus, the Device mode is verified.

```bash
umount -l /mnt/mp2
```

![Dev Mode Verification](./images/d1_verification.png)

## 3. USB 3.1 in Dual-Role Device (DRD) Mode

### 3.1 Build SD Card Binaries with Patch

1\. Setup Environment

```bash
sudo rm -rf agilex5_065b_base.sd
mkdir agilex5_065b_base.sd
cd agilex5_065b_base.sd
export TOP_FOLDER=`pwd`
```

2\. Enable Quartus tools to be called from command line (**Note**: Use your Quartus installation path):

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
source ~/altera_pro/26.1/qinit.sh
```




3\. Setup Hardware Design and Yocto

```bash
cd $TOP_FOLDER
rm -rf agilex5e-ed-gsrd
git clone https://github.com/altera-fpga/agilex5e-ed-gsrd.git agilex5e-ed-gsrd
cd agilex5e-ed-gsrd
git checkout QPDS26.1_REL_GSRD_PR
```

4\. Run the following command in Linux shell to generate the file **usb3p1_drd_enablement_QPDS26p1.patch** from the encoded data.

<details>
   <summary>
      <span style="color: #0056b3; font-weight: bold; cursor: pointer;">
      Click for the command to retrieve the encoded data
      </span>
   </summary>
   
```bash
base64 -d <<'EOF' | gunzip > usb3p1_drd_enablement_QPDS26p1.patch
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
EOF
```
   
</details>

**Note**: The patch changes the value of dr_mode in the &usb31 node from "host" to "otg" in the device tree file socfpga_agilex5_socdk.dts. The patch also implements new changes in the FPGA design to enable DRD Mode, the changes can be seen in the Platform Designer QSYS file.

```bash
 &usb31 {
    status = "okay";
    extcon = <&extcon_usb>;
    dr_mode = "otg";
 };
```

5\. Apply the patch to enable DRD Mode:

```bash
cp usb3p1_drd_enablement_QPDS26p1.patch $TOP_FOLDER/agilex5e-ed-gsrd/
git apply usb3p1_drd_enablement_QPDS26p1.patch
```

6\. Build Hardware Design and Yocto

```bash
cd $TOP_FOLDER/agilex5e-ed-gsrd/a5ed065b-premium-devkit-oobe/baseline-a55
make software-yocto_linux_sd-install-sw
```

7\. The following file is created:

* $TOP_FOLDER/agilex5e-ed-gsrd/a5ed065b-premium-devkit-oobe/baseline-a55/install/binaries/software/yocto_linux_sd/sdimage.tar.gz

### 3.2 Verification - Using the Dev-Kit in DRD Mode

1\. Dual-Role Device Mode essentially means that the user is able to use both Host Mode and Device Mode with the same image.

2\. Boot up the dev-kit with the SD Card and Quartus Programmer, login with “root”.

3\. Run the steps in [1.2 Verification - Transfer a file to a Removable Storage](#12-verification---transfer-a-file-to-a-removable-storage) to verify that Host Mode is working.

4\. Run the steps in [2.2 Verification - Using the Dev-Kit as a Removable Storage](#22-verification---using-the-dev-kit-as-a-removable-storage) to verify that Device Mode is working.

5\. You may try Step 3 &rarr; Step 4 or Step 4 &rarr; Step 3 to see the switching of modes, without the need to reset the dev-kit.
