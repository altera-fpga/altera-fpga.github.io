

## Introduction

This example builds an SD card image that boots Ubuntu on the Agilex 5 FPGA E-Series 065A Premium Development Kit. 

*Note*: You can target other Agilex 5 Development Kits by using a different SOF, and `flash_loader` parameter when creating the QSPI flash image.

*Note*: The example does not use or configure the FPGA fabric.

### Disclaimer

Altera provides these materials to our customers solely as an example of how a Linux operating system may be configured for use with Altera products. Altera does not endorse, certify, or support Ubuntu or any other third-party operating system or software. It is the customer’s sole responsibility to determine whether Ubuntu, or another Linux instance is appropriate for its intended use, and to ensure compliance with all applicable open-source licenses, security requirements and technical or regulatory obligations. Altera offers these instructions “AS-IS” without any warranty of any kind, whether express, implied, statutory or otherwise and Altera will not be liable to customer under any legal theory related to customer’s choice in using or distributing Ubuntu.

### What the Example Provides

The image is an arm64 Ubuntu 26.04.1 LTS base system with a small set of packages added for administration and networking: `sudo`, OpenSSH, NetworkManager, `iputils-ping`, `net-tools`, `ethtool`, `isc-dhcp-client`, `systemd-timesyncd`, `vim-tiny`, and related utilities. Ethernet interfaces are left under NetworkManager control.

The default account is `user` with password `fpga1983`. The account is in the `sudo` group. These credentials are published as part of the example. Change the password after the first login.

### Component Versions

Versions below are the ones this script selects and builds.

| Component | Version | Source revision |
|---|---|---|
| ARM Trusted Firmware | 2.15.0 | `socfpga_v2.15.0` |
| U-Boot | 2026.07 | `socfpga_v2026.07` |
| Linux kernel | 6.18.37 | `socfpga-6.18.37-lts` |
| Ubuntu | 26.04.1 LTS (Resolute Raccoon), arm64 base | ubuntu-base |
| Cross toolchain | GCC 15.2.0, musl, snapshot 2025-09-29 | musl-cross |
| Boot script | `whinlatter` | meta-altera-fpga `uboot.txt` / `uboot_script.its` |

The script checks out those branches. U-Boot is then built with the script’s SD-boot and NAND changes applied.

The kernel FIT image (`kernel.itb`) contains an LZMA-compressed `Image` and the `socfpga_agilex5_socdk` device tree. The kernel is configured from `defconfig` plus `CONFIG_MARVELL_PHY=y` so the on-board Ethernet PHY is available.

### Prerequisites

The following are required to be able to fully exercise this example:

* Altera&reg; Agilex&trade; 5 FPGA E-Series 065A Premium Development Kit, ordering code DK-A5E065AB32AEA. Refer to [board documentation](https://www.altera.com/products/devkit/po-3285/agilex-5-fpga-e-series-065a-premium-development-kit) for more information.

* Host PC with:
  * Linux OS installed. Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too
  * Serial terminal (for example GtkTerm or Minicom on Linux and TeraTerm or PuTTY on Windows)
  * Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 26.3 - only Quartus Programmer is used
* Internet connection. For downloading the files.

Install the host tools:

```bash
sudo apt update
sudo apt install build-essential bison flex guestfs-tools u-boot-tools \
    python3-setuptools python3-dev libssl-dev bc qemu-user-static \
    xz-utils swig sudo wget git
```

The image is assembled with guestfs (`guestfish`). Two host settings make that step reliable:

* The kernel images in `/boot` must be readable by every user: `sudo chmod a+r /boot/vmlinuz-*`
* The user running the script should be in the `kvm` group: `sudo usermod -aG kvm "$USER"`

Log out and back in after joining `kvm`. Without it, guestfs still runs, but much more slowly.

## Build Example



This sections contains instructions on how to build the example.

### Setup Build Environment



Create a top folder for the example:


```bash
sudo rm -rf agilex5_065a_pdk.ubuntu
mkdir agilex5_065a_pdk.ubuntu
cd agilex5_065a_pdk.ubuntu
export TOP_FOLDER=`pwd`
```


Enable Quartus tools to be called from command line:


```bash
source ~/altera_pro/26.3/qinit.sh
```






### Build SD Card Image



1\. Create the `mk_ubuntu_sd.sh` build script using the following command:


```bash
cd $TOP_FOLDER
base64 -d <<'EOF' | gunzip > mk_ubuntu_sd.sh
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
EOF
```


2\. Run the build script - will run for 30min or more, depending on your computer and internet speeds:


```bash
chmod +x mk_ubuntu_sd.sh
./mk_ubuntu_sd.sh -y
```


`-y` records that you have read the disclaimer and skips the keypress prompt. Without `-y`, the script waits for a keypress. `-h` prints usage and the disclaimer.

The script downloads the toolchain, firmware, U-Boot, kernel, boot script, and Ubuntu base archive, builds them, installs the extra Ubuntu packages, and writes `build_output/sdcard.img`. The first run takes a long time. Later runs reuse downloaded archives and existing source trees, then rebuild the components and recreate the image.

The script will create the file `$TOP_FOLDER/build_output/sdcard.img`, of size 2 GiB (2,147,483,648 bytes), with an MBR partition table and the following layout:

| Partition | Filesystem | Size | Contents |
|---|---|---|---|
| 1 | FAT | 50 MiB | `u-boot.itb`, `kernel.itb`, `boot.scr.uimg` |
| 2 | ext4 | remainder of the image (about 1.9 GiB) | Ubuntu root filesystem |


The following relevant files are built in  the folder `$TOP_FOLDER/build_output/`:

| File | Role |
|---|---|
| `sdcard.img` | Image to write to the SD card |
| `u-boot-spl-dtb.hex` | SPL hex file passed to `quartus_pfg` as `hps_path` |
| `kernel.itb` | Kernel and device tree FIT image copied onto the boot partition |
| `boot.scr.uimg` | U-Boot boot script copied onto the boot partition |
| `u-boot-socfpga/u-boot.itb` | U-Boot image copied onto the boot partition |
| `linux-socfpga/arch/arm64/boot/Image` | Uncompressed kernel image used to build `kernel.itb` |
| `linux-socfpga/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dtb` | Board device tree |
| `ubuntu-base-26.04.1-base-arm64.tar.gz` | Ubuntu base archive downloaded by the script |

If image creation fails part way through, remove the partial file and run the script again:

```bash
rm -f build_output/sdcard.img
./mk_ubuntu_sd.sh -y
```

The root filesystem time zone follows the build host (`/etc/timezone`). To force a different zone, set `UBUNTU_TIMEZONE` in the script, for example `America/Chicago`, before building.



### Create QSPI Image File



The HPS SPL is stored in QSPI flash. The SD card holds U-Boot, the kernel, and the root filesystem. Generate a `.jic` from the GHRD `.sof` and the SPL hex file produced by this script, `build_output/u-boot-spl-dtb.hex`.

1\. Change to the build folder, and download the SOF file for the HPS Baseline System Example Design for the board:


```bash
cd $TOP_FOLDER/build_output
wget https://releases.rocketboards.org/2026.10/gsrd/agilex5_dk_a5e065ab32aea_gsrd.baseline-a55/baseline_a55.sof
```


2\. Create the QSPI image:


```bash
quartus_pfg \
    -c baseline_a55.sof baseline_a55.jic \
    -o device=MT25QU128 \
    -o flash_loader=A5ED065AB32AE1V \
    -o hps_path=u-boot-spl-dtb.hex \
    -o mode=ASX4 \
    -o hps=1
```


The following files will be created:

* `$TOP_FOLDER/build_output/baseline_a55.hps.jic`: QSPI image file
* `$TOP_FOLDER/build_output/baseline_a55.core.rbf`: ignored, as this example does not configure the FPGA fabric




## Run Example

1\. Write `sdcard.img` to the SD card and insert the card.

2\. Program the JIC and power-cycle the board.

3\. The SPL in QSPI loads U-Boot from the SD card.

4\. U-Boot loads the kernel and device tree from `kernel.itb`.

5\. Linux mounts the Ubuntu root filesystem from the SD card and starts user space.

The serial console is `serial0` at 115200 8N1. Log in as `user` with password 'fpga1983'. After the Ethernet interface has an address, SSH is available on the same account.

6\.Once logged in, confirm that the clock was set by NTP:

```bash
timedatectl show
```

`NTPSynchronized=yes` means the clock is synchronized. If the value is `no`, NTP did not reach a server, which is often a firewall issue. Set the clock manually until that is resolved:

```bash
sudo date -s "2026-11-10 21:51:24"
```

7\. Update package information:

```bash
sudo apt-get update
```

8\. Upgrade packages:

```bash
sudo apt-get upgrade -y
```

9\. Install an additional application, for example `mc`:

```bash
sudo apt-get install mc -y
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