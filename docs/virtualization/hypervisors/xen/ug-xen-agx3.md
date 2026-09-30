

# HPS Xen Hypervisor GSRD System Example Design: Agilex™ 3 FPGA and SoC C-Series Development Kit

##  Introduction

This page presents the Xen GSRD, which is based on the [Linux GSRD for the Agilex™ 3 FPGA and SoC C-Series Development Kit](https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-3/c-series/gsrd/ug-gsrd-agx3/). The Xen GSRD uses the HPS Enablement Board, and SD card for storing the root filesystem.

### Xen Overview

Xen is a free open-source Type-1 hypervisor which enables efficient and secure virtualization of hardware resources to run multiple operating systems on a single physical machine. 

![](images/xen-architecture.svg)

In Xen's architecture, there are two domains. Dom0 is the privileged management domain that runs the hypervisor and has full access to physical hardware, acting as the bridge between the hypervisor and other virtual machines. DomUs are unprivileged guest domains that run operating systems or applications, relying on Dom0 for resource allocation. Dom0 and DomUs operate independently, ensuring isolation and security.

### Prerequisites

The following are required to be able to fully exercise the guides from this page:

* Agilex™ 3 FPGA and SoC C-Series Development Kit, ordering code DK-A3W135BM16AEA.

* Host PC with:

  * 64 GB of RAM. Less will be fine for only exercising the binaries, and not rebuilding the GSRD.
  * Linux OS installed. Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too
  * Serial terminal (for example GtkTerm or Minicom on Linux and TeraTerm or PuTTY on Windows)
  * SSH server installer, to enable using 'scp' command from target board to host PC
  * Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 25.3 
  
* Local Ethernet network, with DHCP server
* Internet connection. For downloading the files, especially when rebuilding the GSRD.


 Refer to [board documentation](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a3y135b.html) for more information about the development kit.

### Prebuilt Binaries

The Agilex™ 3 FPGA and SoC C-Series Development Kit Xen GSRD binaries are located at [https://releases.rocketboards.org/2025.10/xen/agilex3_xen/](https://releases.rocketboards.org/2025.10/xen/agilex3_xen/).

### Component Versions

Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 25.3 and the following software component versions integrate the 25.3 release. 

**Note:** Regarding the GHRD components in the following table, only the device-specific GHRD is used in this page.

| Component                             | Location                                                     | Branch                       | Commit ID/Tag       |
| :------------------------------------ | :----------------------------------------------------------- | :--------------------------- | :------------------ |
| Agilex 3 GHRD | [https://github.com/altera-fpga/agilex3c-ed-gsrd](https://github.com/altera-fpga/agilex3c-ed-gsrd)    | main  | QPDS25.3_REL_GSRD_PR   |
| Agilex 5 GHRD - Include GSRD 2.0 baseline design + meta_custom | [https://github.com/altera-fpga/agilex5e-ed-gsrd](https://github.com/altera-fpga/agilex5e-ed-gsrd) | main                    | QPDS25.3_REL_GSRD_PR |
| Agilex 7 GHRD                         | [https://github.com/altera-fpga/agilex7f-ed-gsrd](https://github.com/altera-fpga/agilex7f-ed-gsrd) | main | QPDS25.3_REL_GSRD_PR |
| Stratix 10 GHRD                       | [https://github.com/altera-fpga/stratix10-ed-gsrd](https://github.com/altera-fpga/stratix10-ed-gsrd) | main | QPDS25.3_REL_GSRD_PR |
| Arria 10 GHRD                         | [https://github.com/altera-fpga/arria10-ed-gsrd](https://github.com/altera-fpga/arria10-ed-gsrd)  | main | QPDS25.3_REL_GSRD_PR |
| Linux                                 | [https://github.com/altera-fpga/linux-socfpga](https://github.com/altera-fpga/linux-socfpga) | socfpga-6.12.33-lts | QPDS25.3_REL_GSRD_PR |
| Arm Trusted Firmware                  | [https://github.com/altera-fpga/arm-trusted-firmware](https://github.com/altera-fpga/arm-trusted-firmware) | socfpga_v2.13.0   | QPDS25.3_REL_GSRD_PR |
| U-Boot                                | [https://github.com/altera-fpga/u-boot-socfpga](https://github.com/altera-fpga/u-boot-socfpga) | socfpga_v2025.07 | QPDS25.3_REL_GSRD_PR |
| Yocto Project                         | [https://git.yoctoproject.org/poky](https://git.yoctoproject.org/poky) | walnascar | latest              |
| Yocto Project: meta-altera-fpga (for GSRD 2.0) | [https://github.com/altera-fpga/meta-altera-fpga](https://github.com/altera-fpga/meta-altera-fpga) | walnascar | QPDS25.3_REL_GSRD_PR |
| Yocto Project: meta-intel-fpga (for Legacy GSRD) | [https://git.yoctoproject.org/meta-intel-fpga](https://git.yoctoproject.org/meta-intel-fpga) | walnascar | latest |
| Yocto Project: meta-intel-fpga-refdes (for Legacy GSRD) | [https://github.com/altera-fpga/meta-intel-fpga-refdes](https://github.com/altera-fpga/meta-intel-fpga-refdes) | walnascar | QPDS25.3_REL_GSRD_PR |
| Legacy GSRD | [https://github.com/altera-fpga/gsrd-socfpga](https://github.com/altera-fpga/gsrd-socfpga) | walnascar | QPDS25.3_REL_GSRD_PR |

**Note:** The combination of the component versions indicated in the table above has been validated through the use cases described in this page and it is strongly recommended to use these versions together. If you decided to use any component with different version than the indicated, there is not warranty that this will work.

### Release Notes

See [https://github.com/altera-fpga/gsrd-socfpga/releases/tag/QPDS25.3_REL_GSRD_PR](https://github.com/altera-fpga/gsrd-socfpga/releases/tag/QPDS25.3_REL_GSRD_PR).

## Exercise Prebuilt Binaries

This section presents how to use the prebuilt binaries included with this Xen example.

Running the boot from SD card section of the GSRD is a prerequisite step for running the Xen examples, as not all steps are as detailed on this page as in the GSRD page. Refer to the following links for help on getting started:

| Link | Description |
| :- | :- |
| [Board Documentation](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a3y135b.html) | Board user guide, schematics, etc |
| [GSRD Development Kit Section](https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-3/c-series/gsrd/ug-gsrd-agx3/#development-kit) | Details about the development kit |
| [GSRD Board Setup Section](https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-3/c-series/gsrd/ug-gsrd-agx3/#configure-board) | Setting up the development kit |
| [GSRD Serial Console Section](https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-3/c-series/gsrd/ug-gsrd-agx3/#configure-serial-console) | Setting up serial console |
| [GSRD Write SD Card Section](https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-3/c-series/gsrd/ug-gsrd-agx3/#booting-from-sd-card)  | Writing SD card image |

### Write Binaries

This section shows presents downloading and flashing the SD card image and JIC files, and downloading the xen rootfs cpio archive to be used by DomUs VMs.

1\. Download and write to SD card the image [https://releases.rocketboards.org/2025.10/xen/agilex3_xen/sdimage.tar.gz](https://releases.rocketboards.org/2025.10/xen/agilex3_xen/sdimage.tar.gz)

2\. Download and write to QSPI flash the JIC file [https://releases.rocketboards.org/2025.10/xen/agilex3_xen/ghrd_a3cw135bm16ae6s.hps.jic.tar.gz](https://releases.rocketboards.org/2025.10/xen/agilex3_xen/ghrd_a3cw135bm16ae6s.hps.jic.tar.gz)

3\. On the host computer, download the xen rootf cpio archive:

```bash
wget https://releases.rocketboards.org/2025.10/xen/agilex3_xen/xen-image-minimal-agilex3.cpio.gz
```

5\. On the Linux on target board, copy over the above downloaded file in 'xen' folder:

```bash
cd xen
scp <host_user>@<host-ip>:/<host-folder>/xen-image-minimal-agilex3.cpio.gz .
```

### Boot Xen GSRD

This section shows how to boot the Xen GSRD. By default, if no other operation is done, the board boots into normal, non-Xen enabled GSRD on a power cycle. In order to boot with the Xen Hypervisor, you need to stop the U-Boot countdown, and boot Linux manually using the commands shown in the below sections. This is provided for convenience, and when used in a real production system, U-Boot can be configured to boot the required Xen configuration automatically.

![](images/xen-boot-flow.svg)

<h4>Boot Without Passthrough</h4>

1\. Power cycle the board

2\. Press any key during U-Boot countdown to stop it

3\. Run the following U-Boot commands:

```bash
fatls mmc 0:1
fatload mmc 0:1 $loadaddr boot.scr.xen.uimg
source $loadaddr
booti 0x8a000000 - 0x88000000
```

4\. Xen console messages will be shown, then regular Linux boot console messages.

5\. Log into Linux as usual with 'root' login and no passoword will be requested

<h4>Boot With Passthrough</h4>

The instructions are the same as without passthrough, just that the following command needs to be added befote the 'booti' command:

| Device Passthrough | Command |
| :- | :- |
| QSPI | fdt set /soc@0/spi@108d2000 xen,passthrough |
| USB | fdt set /soc@0/usb1@11000000 xen,passthrough |

### Manage VMs

This section shows how to use the 'xl' Xen utility to manage VMs running on DomUs. Only a few options are used, refer to 'xl' command help for more options.

1\. Boot Xen GSRD as shown above. It can be either with or without passthrough

2\. Create VM1 configuration file:

```bash
cat << EOT > test_vm_1.cfg
# Guest name
name = "DomU1"

# Kernel image to boot
kernel = "/boot/Image"

ramdisk = "xen-image-minimal-agilex3.cpio.gz"

extra = "root=/dev/ram0 init=/bin/sh console=hvc0 rdinit=/sbin/init"

# Initial memory allocation (MB)
memory = 650
EOT
```

3\. Start VM1:

```bash
xl create test_vm_1.cfg
```

4\. List running VMs:

```bash
xl list
```

5\. Connect to VM1 console:

```bash
xl console DomU1
```

6\. Run some commands in VM1:

```bash
pwd
ls -la
```

7\. Exit from VM1 console by pressing CTRL + ]. Note this works only from serial console, and not over SSH connection.

8\. Shutdown VM1:

```bash
xl shutdown DomU1
```

The above command politely asks DomU1 to shut down by using the ACPI shutdown signal and letting the OS shut down.

Alternatively, when needed, you can also use 'destroy' commands which acts as a hard power cycle:

```bash
xl destroy DomU1
```

12\. List VMs again, it will not show VM1 anymore

```bash
xl list
```


## Rebuild Xen GSRD

This section presents how to build the Xen GSRD binaries. The instructions are the same as for the GSRD, except that the environment variable BUILD_HYP=1 needs to be set for building the Xen enabled GSRD version. This environment variable is only used by the Yocto GSRD script.



<h5>Yocto Build Prerequisites</h5>

1\. Make sure you have Yocto system requirements met: https://docs.yoctoproject.org/5.0.1/ref-manual/system-requirements.html#supported-linux-distributions.

The command to install the required packages on Ubuntu 22.04 is:

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install openssh-server mc libgmp3-dev libmpc-dev gawk wget git diffstat unzip texinfo gcc \
build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping \
python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint xterm python3-subunit mesa-common-dev zstd \
liblz4-tool git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison xinetd \
tftpd tftp nfs-kernel-server libncurses5 libc6-i386 libstdc++6:i386 libgcc++1:i386 lib32z1 \
device-tree-compiler curl mtd-utils u-boot-tools net-tools swig -y
```

On Ubuntu 22.04 you will also need to point the /bin/sh to /bin/bash, as the default is a link to /bin/dash:

```bash
 sudo ln -sf /bin/bash /bin/sh
```

**Note**: You can also use a Docker container to build the Yocto recipes, refer to https://rocketboards.org/foswiki/Documentation/DockerYoctoBuild for details. When using a Docker container, it does not matter what Linux distribution or packages you have installed on your host, as all dependencies are provided by the Docker container.

The following diagram shows an overview of how the build process works for this use case:

![](images/agilex3-build-sd-flow.svg)

<h5>Setup Environment</h5>

1\. Create the top folder to store all the build artifacts:


```bash
sudo rm -rf agilex3_gsrd.xen
mkdir agilex3_gsrd.xen
cd agilex3_gsrd.xen
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





<h5>Build Hardware Design</h5>


```bash
cd $TOP_FOLDER
rm -rf agilex3_soc_devkit_ghrd && mkdir agilex3_soc_devkit_ghrd && cd agilex3_soc_devkit_ghrd
wget https://github.com/altera-fpga/agilex3c-ed-gsrd/releases/download/QPDS25.3_REL_GSRD_PR/a3cw135-devkit-oobe-legacy-baseline.zip
unzip a3cw135-devkit-oobe-legacy-baseline.zip
rm -f a3cw135-devkit-oobe-legacy-baseline.zip
make legacy_baseline-build
make legacy_baseline-sw-build
quartus_pfg -c output_files/legacy_baseline.sof \
  output_files/legacy_baseline_hps_debug.sof \
  -o hps_path=software/hps_debug/hps_wipe.ihex
cd ..
```


The following files are created:

* `$TOP_FOLDER/agilex3_soc_devkit_ghrd/output_files/legacy_baseline.sof`
* `$TOP_FOLDER/agilex3_soc_devkit_ghrd/output_files/legacy_baseline_hps_debug.sof`
<h5>Build Core RBF</h5>



```bash
cd $TOP_FOLDER
rm -f ghrd_a3cw135bm16ae6s.rbf
quartus_pfg -c agilex3_soc_devkit_ghrd/output_files/legacy_baseline_hps_debug.sof ghrd_a3cw135bm16ae6s.rbf -o hps=1
```


The following file is created:

* `$TOP_FOLDER/ghrd_a3cw135bm16ae6s.core.rbf`


<h5>Set Up Yocto</h5>

1\. Clone the Yocto script and prepare the build:

```bash
cd $TOP_FOLDER
rm -rf gsrd-socfpga
git clone -b walnascar https://github.com/altera-fpga/gsrd-socfpga
cd gsrd-socfpga
export HYP_BUILD=1
. agilex3-gsrd-build.sh
build_setup
```


<h5>Customize Yocto</h5>

1\. Save the `core.rbf` as `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex3_gsrd_ghrd.core.rbf`

2\. Update the recipe `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb` as follows:  

* Replace the entry `${GHRD_REPO}/agilex3_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex3_gsrd_core` with `file://agilex3_gsrd_ghrd.core.rbf;sha256sum=<CORE_SHA>` where `CORE_SHA` is the sha256 checksum of the file
* Delete the line `SRC_URI[agilex3_gsrd_core.sha256sum] = "bf11c8cb3b6d9487f93ce0e055b1e5256998a25b25ac4690bef3fcd6225ee1ae"`
The above are achieved by the following instructions:

```bash
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex3_gsrd_ghrd.core.rbf
ln -s $TOP_FOLDER/ghrd_a3cw135bm16ae6s.core.rbf $CORE_RBF
OLD_URI="\${GHRD_REPO}\/agilex3_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex3_gsrd_core"
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ")
NEW_URI="file:\/\/agilex3_gsrd_ghrd.core.rbf;sha256sum=$CORE_SHA"
sed -i "s/$OLD_URI/$NEW_URI/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
sed -i "/agilex3_gsrd_core\.sha256sum/d" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
```


<h5>Build Yocto</h5>

Build Yocto:

```bash
bitbake_image
```

Gather files:

```bash
package
```


The following files are created:

* `$TOP_FOLDER/gsrd-socfpga/agilex3-gsrd-images/u-boot-agilex3-socdk-gsrd-atf/u-boot-spl-dtb.hex`
* `$TOP_FOLDER/gsrd-socfpga/agilex3-gsrd-images/u-boot.itb`
* `$TOP_FOLDER/gsrd-socfpga/agilex3-gsrd-images/sdimage.tar.gz`


<h5>Build QSPI Image</h5>


```bash
cd $TOP_FOLDER
rm -f ghrd_a3cw135bm16ae6s.hps.jic ghrd_a3cw135bm16ae6s.core.rbf
quartus_pfg \
-c agilex3_soc_devkit_ghrd/output_files/legacy_baseline.sof ghrd_a3cw135bm16ae6s.jic \
-o device=MT25QU128 \
-o flash_loader=A3CW135BM16AE6S \
-o hps_path=gsrd-socfpga/agilex3-gsrd-images/u-boot-agilex3-socdk-gsrd-atf/u-boot-spl-dtb.hex \
-o mode=ASX4 \
-o hps=1
```


The following file is created:

* `$TOP_FOLDER/ghrd_a3cw135bm16ae6s.hps.jic`

<h5>Build HPS RBF</h5>
This is an optional step, in which you can build an HPS RBF file, which can be used to configure the HPS through JTAG instead of QSPI though the JIC file.


```bash
cd $TOP_FOLDER
rm -f ghrd_a3cw135bm16ae6s.hps.rbf
quartus_pfg \
-c agilex3_soc_devkit_ghrd/output_files/legacy_baseline.sof  ghrd_a3cw135bm16ae6s.rbf \
-o hps_path=gsrd-socfpga/agilex3-gsrd-images/u-boot-agilex3-socdk-gsrd-atf/u-boot-spl-dtb.hex \
-o hps=1
```


The following file is created:

* `$TOP_FOLDER/ghrd_a3cw135bm16ae6s.hps.rbf`



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
