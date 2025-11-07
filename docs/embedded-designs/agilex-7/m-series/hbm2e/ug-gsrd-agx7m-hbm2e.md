

# HPS GSRD User Guide for the Agilex™ 7 FPGA M-Series Development Kit - HBM2e Edition (3x F-Tile & 1x R-Tile)

## Overview 

This page presents the Golden System Reference Design for the [Intel Agilex™ 7 FPGA M-Series Development Kit - HBM2e Edition (3x F-Tile & 1x R-Tile)](https://www.altera.com/products/devkit/a1jui0000049utqmam/agilex-7-fpga-m-series-development-kit-hbm2e-edition-3x-f-tile-1x-r-tile-es). The GSRD demonstrates the following: 

- HPS side 
  - Linux, booted by U-Boot and ATF 
  - Board web server 
  - Sample applications 
  - Hello world 
  - System check application 

### Prerequisites 

The following are required in order to be able to fully exercise the GSRD: 

- Intel Agilex™ 7 FPGA M-Series Development Kit - HBM2e Edition (3x F-Tile & 1x R-Tile), ordering code DK-DEV-AGM039FES (engineering sample version) and DK-DEV-AGM039EA (production version)
  - SD/MMC HPS Daughtercard 
  - Mini USB cable for serial output 
  - Micro USB cable for on-board Intel FPGA Download Cable II 
  - Micro SD card (4GB or greater) 
- Host PC with 
  - Linux - Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too 
  - Serial terminal (for example Minicom on Linux and TeraTerm or PuTTY on Windows) 
  - Micro SD card slot or Micro SD card writer/reader 
  - Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 25.3
- Local Ethernet network, with DHCP server (will be used to provide IP address to the board) 

This page covers both versions of the board. You can identify your board type by looking at the serial number identifier, as shown below:

| Development Kit Version | Ordering Code | Device Part Number | Serial Number Identifier |
| :-- | :-- |  :-- |  :-- |
| Agilex™ 7 FPGA M-Series Development Kit - HBM2e Edition (3x F-Tile and 1x R-Tile) | DK-DEV-AGM039EA | AGMF039R47A1E1VC | AGM82DK0001001 |
| Agilex™ 7 FPGA M-Series Development Kit - HBM2e Edition (3x F-Tile and 1x R-Tile) ES1 | DK-DEV-AGM039FES | AGMF039R47A1E2VR0 | AGM82DK0000001 |

The main difference between the boards, in addition to the FPGA part number, is that they use different memory type for HPS:

* DK-DEV-AGM039EA uses HBM memory for HPS
* DK-DEV-AGM039FES uses DDR5 memory for HPS

The U-Boot and Linux compilation, Yocto compilation and creating the SD card image require a Linux host PC. The rest of the operations can be performed on either a Windows or Linux host PC. 

### Release Notes 

The Intel FPGA HPS Embedded Software release notes can be accessed from the following link: [https://github.com/altera-fpga/gsrd-socfpga/releases/tag/QPDS25.3_REL_GSRD_PR](https://github.com/altera-fpga/gsrd-socfpga/releases/tag/QPDS25.3_REL_GSRD_PR)

### Binary Release Contents 

The binary release files are accessible at:

| Board | Link |
| :-- | :-- | 
| DK-DEV-AGM039EA | [https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_dev_agm039ea_gsrd/](https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_dev_agm039ea_gsrd/)
| DK-DEV-AGM039FES | [https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_dev_agm039fes_gsrd/](https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_dev_agm039fes_gsrd/) |

The source code is also included on the SD card in the Linux rootfs path `/home/root`: 

| File | Description | 
| :-- | :-- | 
| linux-socfpga-v6.12.33-lts-src.tar.gz | Source code for Linux kernel | 
| u-boot-socfpga-v2025.07-src.tar.gz | Source code for U-Boot | 
| arm-trusted-firmware-v2.13.0-src.tar.gz | Source code for Arm Trusted Firmware | 

Before downloading the hardware design please read the agreement in the link [https://www.intel.com/content/www/us/en/programmable/downloads/software/license/lic-prog_lic.html](https://www.intel.com/content/www/us/en/programmable/downloads/software/license/lic-prog_lic.html)

#### Component Versions

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

## Development Kit 

The Agilex™ 7 M-Series HBM Development Kit is shown below: 

![](images/board-large.JPG) 

Refer to the following for more information about the Development Kit: 

- [Installer Package](https://cdrdv2.intel.com/v1/dl/getContent/792725) 
- [Board User Guide](https://www.intel.com/content/www/us/en/docs/programmable/782461/current.html) 

## Running GSRD with Pre-Built Binaries 

### Booting Linux 

1\. Connect the following cables to the board: 

- Power: from board to power supply 
- HPS UART Console: from vertical mini USB connector on the HPS daughtercard to host PC 
- JTAG: from micro USB cable on edge of the board to host PC 

2\. Download, extract and write to SD card the following SD card image: 

| Board Type | Link |
| :-- | :-- | 
| DK-DEV-AGM039FES | [https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_dev_agm039fes_gsrd/sdimage.tar.gz](https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_dev_agm039fes_gsrd/sdimage.tar.gz) |
| DK-DEV-AGM039EA | [https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_dev_agm039ea_gsrd/sdimage.tar.gz](https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_dev_agm039ea_gsrd/sdimage.tar.gz) |

 Then insert SD card into the HPS OOBE Daughtercard socket. 

3\. Configure board to the default settings, making sure set S24 dipswitch to OFF-OFF-OFF-ON, to select MSEL=JTAG, so that board does not configure on power up. 

4\. Power up the board 

5\. Download the HPS RBF file and configure the HPS RBF file over JTAG: 

For DK-DEV-AGM039EA:

```bash 
wget https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_dev_agm039ea_gsrd/ghrd.hps.rbf 
quartus_pgm -c 1 -m jtag -o "p;ghrd.hps.rbf" 
```

For DK-DEV-AGM039FES:

```bash 
wget https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_dev_agm039fes_gsrd/ghrd.hps.rbf 
quartus_pgm -c 1 -m jtag -o "p;ghrd.hps.rbf" 
```

6\. Linux will boot, use 'root' as username to log in, no password will be required. 

### Run Hello World Application 

Change to IntelFPGA folder, and run the hello application, which will display a meesage as shown below: 

```bash 
root@agilex7dkdevagm039:~# cd intelFPGA/ 
root@agilex7dkdevagm039:~/intelFPGA# ./hello 
Hello SoC FPGA! 
```

### Run SysCheck Application 

Run the SysCheck application: 

```bash 
root@agilex7dkdevagm039:~/intelFPGA# ./syschk 
```

It will display some system information: 

```bash 
 ALTERA SYSTEM CHECK 
 
lo : 127.0.0.1 usb1 : DWC OTG Controller 
eth0 : 192.168.1.52 
 serial@ffc02100 : disabled 
hps_led2 : OFF serial@ffc02000 : okay 
hps_led0 : OFF 
hps_led1 : OFF 
```

Press **Q** to exit the appplication. 

### Connect to Web Server 

1\. Boot Linux as described in previous section. 

2\. Determine the IP address of the board using 'ifconfig' as shown above. Note there will be network interfaces of them, either can be used. 

3\. Open a web browser on the host PC and type *http://* on the address box, then type the IP of your board and hit Enter. 

![](images/web-server.png) 

**Caution**: The web server is intended to allow users to control FPGA connected LEDs on the board. Due to an issue in this release, this functionality is not yet enabled. It will be enabled in the next release. 

### Connect over SSH 

1\. The lower bottom of the web page presents instructions on how to connect to the board using an SSH connection. 

![](images/ssh-instructions.png) 

2\. If the SSH client is not installed on your host computer, you can install it by running the following command on CentOS: 

```bash 
$ sudo yum install openssh-clients 
```

or the following command on Ubuntu: 

```bash 
$ sudo apt-get install openssh-client 
```

3\. Connect to the board, and run some commands, such as **pwd**, **ls** and **uname** to see Linux in action: 

```bash 
ssh root@192.168.1.106 
```

![](images/ssh-terminal.png) 

## Build the GSRD for DK-DEV-AGM039FES



### Set up Environment 


Create a top folder for this example, as the rest of the commands assume this location: 


```bash 
sudo rm -rf agilex7m_es.gsrd 
mkdir agilex7m_es.gsrd 
cd agilex7m_es.gsrd 
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





### Build Hardware Design 


Use the following commands to build the hardware design: 


```bash 
cd $TOP_FOLDER 
rm -rf agilex7f-ed-gsrd
wget https://github.com/altera-fpga/agilex7f-ed-gsrd/archive/refs/tags/QPDS25.3_REL_GSRD_PR.zip
unzip QPDS25.3_REL_GSRD_PR.zip
rm QPDS25.3_REL_GSRD_PR.zip
mv agilex7f-ed-gsrd-QPDS25.3_REL_GSRD_PR agilex7f-ed-gsrd
cd agilex7f-ed-gsrd
make agm039fes-soc-devkit-oobe-baseline-all
```


The following files are created: 

- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agm039fes_soc_devkit_oobe_baseline.sof` - FPGA configuration file, without HPS FSBL 
- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agm039fes_soc_devkit_oobe_baseline_hps_debug.sof` - FPGA configuration file, with HPS Debug FSBL 


### Create Core RBF 



```bash 
cd $TOP_FOLDER 
rm -f *jic* *rbf* 
quartus_pfg -c $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agm039fes_soc_devkit_oobe_baseline_hps_debug.sof \ 
 ghrd_agmf039r47a1e2vr0.rbf \ 
 -o hps=1 
rm ghrd_agmf039r47a1e2vr0.hps.rbf 
```


The following files will be created: 

- `$TOP_FOLDER/ghrd_agmf039r47a1e2vr0.core.rbf` - HPS First configuration bitstream, phase 2: FPGA fabric 

Note we are also creating an HPS RBF file, but we are discarding it, as it has the HPS Debug FSBL, while the final image needs to have the U-Boot SPL created by the Yocto recipes. 


### Set Up Yocto


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

Then clone the Yocto script and prepare the build: 


```bash 
cd $TOP_FOLDER 
rm -rf gsrd-socfpga 
git clone -b QPDS25.3_REL_GSRD_PR  https://github.com/altera-fpga/gsrd-socfpga 
cd gsrd-socfpga 
. agilex7_dk_dev_agm039fes-gsrd-build.sh 
build_setup 
```


### Customize Yocto

1\. Copy the rebuilt files to `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files` the name `agilex7_dk_dev_agm039fes_gsrd_ghrd.core.rbf` as expected by the recipes using the following command: 


```bash 
RECIPE=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_dev_agm039fes_gsrd_ghrd.core.rbf 
ln -s $TOP_FOLDER/ghrd_agmf039r47a1e2vr0.core.rbf $CORE_RBF 
```


2\. In the Yocto recipe `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb` modify the agilex_gsrd_code file location to point to the local file: 


```bash 
OLD_URI="\${GHRD_REPO}\/agilex7_dk_dev_agm039fes_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_dev_agm039fes_gsrd_core" 
NEW_URI="file:\/\/agilex7_dk_dev_agm039fes_gsrd_ghrd.core.rbf" 
sed -i "s/$OLD_URI/$NEW_URI/g" $RECIPE 
```


3\. In the same Yocto recipe update the SHA256 checksum for the file: 


```bash 
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ") 
OLD_SHA="SRC_URI\[agilex7_dk_dev_agm039fes_gsrd_core\.sha256sum\] = .*" 
NEW_SHA="SRC_URI[agilex7_dk_dev_agm039fes_gsrd_core.sha256sum] = \"$CORE_SHA\"" 
sed -i "s/$OLD_SHA/$NEW_SHA/g" $RECIPE 
```


4\. Optionally change the following files in `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/u-boot/files/`: 

- [uboot.txt](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/master/recipes-bsp/u-boot/files/uboot.txt) - distroboot script 
- [uboot_script.its](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/master/recipes-bsp/u-boot/files/uboot_script.its) - its file for creating FIT image from the above script 

5\. Optionally change the following file in `$WORKSPACE/meta-intel-fpga-refdes/recipes-kernel/linux/linux-socfpga-lts`: 

- [fit_kernel_agilex7_dk_dev_agm039fes.its](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/master/recipes-kernel/linux/linux-socfpga-lts/fit_kernel_agilex7_dk_dev_agm039fes.its) - its file for creating the kernel.itb image 

### Build Yocto 

Build Yocto: 


```bash 
bitbake_image 
```


Gather files: 


```bash 
package 
```


Once the build is completed successfully, you will see the following two folders are created: 

- `agilex7_dk_dev_agm039fes-gsrd-rootfs`: area used by OpenEmbedded build system for builds. Description of build directory structure - https://docs.yoctoproject.org/ref-manual/structure.html#the-build-directory-build 
- `agilex7_dk_dev_agm039fes-gsrd-images`: the build script copies here relevant files built by Yocto from the `agilex7_dk_dev_agf027f1es-gsrd-rootfs/tmp/deploy/images/agilex7_dk_dev_agm039fes/` folder, but also other relevant files. 

The two most relevant files created in the `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_dev_agm039fes-gsrd-images` folder are: 

| File | Description | 
| :-- | :-- | 
| sdimage.tar.gz | SD Card Image, to be written on SD card | 
| u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex | U-Boot SPL Hex file, to be used for generating the bootable SOF file | 


### Create Bootable HPS RBF File 



```bash 
cd $TOP_FOLDER 
rm -f *rbf* 
quartus_pfg -c $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agm039fes_soc_devkit_oobe_baseline.sof \
 ghrd_agmf039r47a1e2vr0.rbf \ 
 -o hps_path=gsrd-socfpga/agilex7_dk_dev_agm039fes-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \ 
 -o hps=1 
```


The following files will be created: 

- $TOP_FOLDER/ghrd_agmf039r47a1e2vr0.hps.rbf - RBF file to configure the device for HPS first, phase 1 




## Build the GSRD for DK-DEV-AGM039EA



### Set up Environment 


Create a top folder for this example, as the rest of the commands assume this location: 


```bash 
sudo rm -rf agilex7m_prod.gsrd 
mkdir agilex7m_prod.gsrd 
cd agilex7m_prod.gsrd 
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





### Build Hardware Design 


Use the following commands to build the hardware design: 


```bash 
cd $TOP_FOLDER 
rm -rf agilex7f-ed-gsrd
wget https://github.com/altera-fpga/agilex7f-ed-gsrd/archive/refs/tags/QPDS25.3_REL_GSRD_PR.zip
unzip QPDS25.3_REL_GSRD_PR.zip
rm QPDS25.3_REL_GSRD_PR.zip
mv agilex7f-ed-gsrd-QPDS25.3_REL_GSRD_PR agilex7f-ed-gsrd
cd agilex7f-ed-gsrd
make agm039ea-soc-devkit-oobe-baseline-all
```


The following files are created: 

- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agm039ea_soc_devkit_oobe_baseline.sof` - FPGA configuration file, without HPS FSBL 
- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agm039ea_soc_devkit_oobe_baseline_hps_debug.sof` - FPGA configuration file, with HPS Debug FSBL 


### Create Core RBF 



```bash 
cd $TOP_FOLDER 
rm -f *jic* *rbf* 
quartus_pfg -c $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agm039ea_soc_devkit_oobe_baseline_hps_debug.sof \ 
 ghrd_agmf039r47a1e2vc.rbf \ 
 -o hps=1 
rm ghrd_agmf039r47a1e2vc.hps.rbf 
```


The following files will be created: 

- `$TOP_FOLDER/ghrd_agmf039r47a1e2vc.core.rbf` - HPS First configuration bitstream, phase 2: FPGA fabric 

Note we are also creating an HPS RBF file, but we are discarding it, as it has the HPS Debug FSBL, while the final image needs to have the U-Boot SPL created by the Yocto recipes. 


### Set Up Yocto


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

Then clone the Yocto script and prepare the build: 


```bash 
cd $TOP_FOLDER 
rm -rf gsrd-socfpga 
git clone -b QPDS25.3_REL_GSRD_PR  https://github.com/altera-fpga/gsrd-socfpga 
cd gsrd-socfpga 
. agilex7_dk_dev_agm039ea-gsrd-build.sh 
build_setup 
```


### Customize Yocto

1\. Copy the rebuilt files to `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files` the name `agilex7_dk_dev_agm039ea_gsrd_ghrd.core.rbf` as expected by the recipes using the following command: 


```bash 
RECIPE=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_dev_agm039ea_gsrd_ghrd.core.rbf 
ln -s $TOP_FOLDER/ghrd_agmf039r47a1e2vc.core.rbf $CORE_RBF 
```


2\. In the Yocto recipe `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb` modify the agilex_gsrd_code file location to point to the local file: 


```bash 
OLD_URI="\${GHRD_REPO}\/agilex7_dk_dev_agm039ea_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_dev_agm039ea_gsrd_core" 
NEW_URI="file:\/\/agilex7_dk_dev_agm039ea_gsrd_ghrd.core.rbf" 
sed -i "s/$OLD_URI/$NEW_URI/g" $RECIPE 
```


3\. In the same Yocto recipe update the SHA256 checksum for the file: 


```bash 
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ") 
OLD_SHA="SRC_URI\[agilex7_dk_dev_agm039ea_gsrd_core\.sha256sum\] = .*" 
NEW_SHA="SRC_URI[agilex7_dk_dev_agm039ea_gsrd_core.sha256sum] = \"$CORE_SHA\"" 
sed -i "s/$OLD_SHA/$NEW_SHA/g" $RECIPE 
```


4\. Optionally change the following files in `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/u-boot/files/`: 

- [uboot.txt](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/master/recipes-bsp/u-boot/files/uboot.txt) - distroboot script 
- [uboot_script.its](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/master/recipes-bsp/u-boot/files/uboot_script.its) - its file for creating FIT image from the above script 

5\. Optionally change the following file in `$WORKSPACE/meta-intel-fpga-refdes/recipes-kernel/linux/linux-socfpga-lts`: 

- [fit_kernel_agilex7_dk_dev_agm039ea.its](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/master/recipes-kernel/linux/linux-socfpga-lts/fit_kernel_agilex7_dk_dev_agm039ea.its) - its file for creating the kernel.itb image 

### Build Yocto 

Build Yocto: 


```bash 
bitbake_image 
```


Gather files: 


```bash 
package 
```


Once the build is completed successfully, you will see the following two folders are created: 

- `agilex7_dk_dev_agm039ea-gsrd-rootfs`: area used by OpenEmbedded build system for builds. Description of build directory structure - https://docs.yoctoproject.org/ref-manual/structure.html#the-build-directory-build 
- `agilex7_dk_dev_agm039ea-gsrd-images`: the build script copies here relevant files built by Yocto from the `agilex7_dk_dev_agm039ea-gsrd-rootfs/tmp/deploy/images/agilex7_dk_dev_agm039ea/` folder, but also other relevant files. 

The two most relevant files created in the `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_dev_agm039ea-gsrd-images` folder are: 

| File | Description | 
| :-- | :-- | 
| sdimage.tar.gz | SD Card Image, to be written on SD card | 
| u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex | U-Boot SPL Hex file, to be used for generating the bootable SOF file | 


### Create Bootable HPS RBF File 



```bash 
cd $TOP_FOLDER 
rm -f *rbf* 
quartus_pfg -c $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agm039ea_soc_devkit_oobe_baseline.sof \
 ghrd_agmf039r47a1e2vc.rbf \ 
 -o hps_path=gsrd-socfpga/agilex7_dk_dev_agm039ea-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \ 
 -o hps=1 
```


The following files will be created: 

- $TOP_FOLDER/ghrd_agmf039r47a1e2vc.hps.rbf - RBF file to configure the device for HPS first, phase 1 




### How to Manually Update the kernel.itb file




The **kernel.itb** file is a Flattattened Image Tree (FIT) file that includes the following components:

* Linux kernel.
* Several board configurations that indicate what components from the **kernel.itb** (Linux kernel, device tree and 2nd Phase fabric design) should be used for a specific board.
* Linux device tree*.
* 2nd Phase Fabric Design*.

 \* One or more of these components to support the different board configurations.

The **kernel.itb** is created from a **.its** (Image Tree Source file) that describes its structure. In the GSRD, the  **kernel.itb** file is located in the following directory, where you can find also all the components needed to create it, including the .its file:

* **$TOP_FOLDER/gsrd-socfpga/<*device-devkit*>-gsrd-rootfs/tmp/work/<*device-devkit*>-poky-linux/linux-socfpga-lts/<*linux branch*>+git/linux-<*device devkit*>-standard-build/**

If you want to modify the kernel.itb by replacing one of the component or modifying any board configuration, you can do the following:

1. Install **mtools** package in your Linux machine.
   ```bash
   $ sudo apt update
   $ sudo apt install mtools
   ```
   
2. Go to the in which the **kernel.itb** is being created under the GSRD.
   ```bash
   $ cd $TOP_FOLDER/gsrd-socfpga/<device-devkit>-gsrd-rootfs/tmp/work/<device-devkit>-poky-linux/linux-socfpga-lts/<linux branch>+git/linux-<device-devkit>-standard-build/
   $ ls *.its
   fit_kernel_<device-devkit>.its
   ```
   
3. In the .its file, observe the components that integrates the kernel.itb identifying the nodes as indicated next:

   **images** node:<br>
   - **kernel** node - Linux kernel defined with the **data** parameter in the node.<br>
   - **fdt-X** node    - Device tree X defined with the **data** parameter in the node.<br>
   - **fpga-X** node -  2nd Phase FPGA Configuration .rbf defined with the **data** parameter in the node.
   
   **configurations** node:<br>
   - **board-X** node - Board configuration with the name defined with the **description** parameter. The components for a specific board configuration are defined with the **kernel**, **fdt** and **fpga** parameters.   

4. In this directory, you can replace any of the files corresponding to any of the components that integrate the **kernel.itb**, or you can also modify the **.its** to change the name/location of any of the components or change the board configuration.

5. Finally, you need to re-generate the new **kernel.itb** as indicated next.
   ```bash
   $ rm kernel.itb
   $ mkimage -f fit_kernel_<device-devkit>.its kernel.itb
   ```

At this point you can use the new **kernel.itb** as needed. Some options could be:

* Use U-Boot to bring it to your SDRAM board through TFTP to boot Linux or to write it to a SD Card device
* Update the flash image (QSPI, SD Card, eMMC or NAND) from your working machine.
 

### How to Manually Update the Content of the SD Card Image


As part of the Yocto GSRD build flow, the SD Card image is built for the SD Card boot flow. This image includes a couple of partitions. One of these partition (a FAT32) includes the U-Boot proper, a Distroboot boot script and the Linux.itb - which includes the Linux kernel image, , the Linux device tree, the 2nd phase fabric design and board configuration (actually several versions of these last 3 components). The 2nd partition (an EXT3 or EXT4 ) includes the Linux file system. 

![](/rel-25.3/embedded-designs/doc_modules/gsrd/images/sdcard_img.png){: style="height:500px"}

If you want to replace any the components or add a new item in any of these partitions, without having to run again the Yocto build flow. 

This can be done through the **wic** application available on the **Poky** repository that is included as part of the GSRD build directory: **$TOP_FOLDER/gsrd-socfpga/poky/scripts/wic** 

This command allows you to inspect the content of a SD Card image, delete, add or replace any component inside of the image. This command is also provided with help support:

   ```bash
   $ $TOP_FOLDER/gsrd-socfpga/poky/scripts/wic help
   
   Creates a customized OpenEmbedded image.

   Usage:  wic [--version]
           wic help [COMMAND or TOPIC]
           wic COMMAND [ARGS]

       usage 1: Returns the current version of Wic
       usage 2: Returns detailed help for a COMMAND or TOPIC
       usage 3: Executes COMMAND

   COMMAND:

    list   -   List available canned images and source plugins
    ls     -   List contents of partitioned image or partition
    rm     -   Remove files or directories from the vfat or ext* partitions
    help   -   Show help for a wic COMMAND or TOPIC
    write  -   Write an image to a device
    cp     -   Copy files and directories to the vfat or ext* partitions
    create -   Create a new OpenEmbedded image
    :
    :
   ```
   The following steps show you how to replace the **kernel.itb** file inside of the fat32 partition in a .wic image.

1. The **wic ls** command allows you to inspect or navigate over the directory structure inside of the SD Card image. For example you can observe the partitions  in the SD Card image in this way:

   ```bash
   # Here you can inspect the content a wic image see the 2 partitions inside of the SD Card image
   $ $TOP_FOLDER/gsrd-socfpga/poky/scripts/wic ls my_image.wic
   Num     Start        End          Size      Fstype
   1       1048576    525336575    524288000  fat32    
   2     525336576   2098200575   1572864000  ext4   
   
   # Here you can naviagate inside of the partition 1
   $ $TOP_FOLDER/gsrd-socfpga/poky/scripts/wic ls my_image.wic:1
   Volume in drive : is boot       
   Volume Serial Number is 9D2B-6341
   Directory for ::/
   
   BOOTSC~1 UIM      2431 2011-04-05  23:00  boot.scr.uimg
   kernel   itb  15160867 2011-04-05  23:00 
   u-boot   itb   1052180 2011-04-05  23:00 
        3 files          16 215 478 bytes
                        506 990 592 bytes free
   ```
   
2. The **wic rm** command allows you to delete any of the components in the selected partition. For example, you can delete the **kernel.itb** image from the partition 1(fat32 partition).

   ```bash
   $ $TOP_FOLDER/gsrd-socfpga/poky/scripts/wic rm my_image.wic:1/kernel.itb
   ```

3. The **wic cp** command allows you to copy any new item or file from your Linux machine to a specific partition and location inside of the SD Card image. For example, you can copy a new **kernel.itb** to the partition 1.

   ```bash
   $ $TOP_FOLDER/gsrd-socfpga/poky/scripts/wic cp <path_new_kernel.itb> my_image.wic:1/kernel.itb
   ```

**NOTE**: The **wic** application also allows you to modify any image with compatible vfat and ext* type partitions which also covers images used for **eMMC** boot flow. 

## Configure Through AVSTx8 

This section presents the details on how the GSRD can be configured automatically at power up through AVSTx8, instead of using JTAG. 

The required steps are: 

1\. Create the PFG file (optional, PFG file already provided here: [ghrd_agmf039r47a1e2vr0.pfg](https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-7/m-series/hbm2e/collateral/ghrd_agmf039r47a1e2vr0.pfg)) 
2\. Create the POF file, using the above PFG file 
3\. Create the CDF file, used by Quartus Programmer to know how to write the POF file 
4\. Write the the POF file to MAX10 board controller flash, using the Quartus Programmer 
5\. Configure board through AVSTx8 

**Warning**: When using the AVSTx8 configuration method on the DevKit, the 'reboot' command from U-Boot and Linux will not work. This is because the 'reboot' command issues a Cold Reset to HPS, resulting in SDM wiping HPS and waiting for the configuration bitstream to be re-sent through AVSTx8 which is not implemented on this board. In order to make this work you need to inform the external configuration agent to re-send the configuration bitstream once the Cold Reset happens. 

### Create Programmer Generator Configuration for AVSTx8 

The PFG file contains information needed by the Quartus Programming File Generator to create the POF file to be stored on the QSPI flash attached to the MAX 10 board controller. The MAX 10 board controller reads the information from that QSPI file and configures the FPGA device over AVST. 

This section provides the details on how the PFG file is created. A copy of the file is also attached to this page: [ghrd_agmf039r47a1e2vr0.pfg](https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-7/m-series/hbm2e/collateral/ghrd_agmf039r47a1e2vr0.pfg). 

The steps required to create the file are: 

1\. Start Programmer File Generator GUI: 

```bash 
qpfgw & 
```

2\. In the **Output Files** tab: 

- Select **Device family**: Agilex™ 7 
- Select **Configuration mode**: AVSTx8 
- Edit **Name**: ghrd_agmf039r47a1e2vr0 
- Check **Programmer Object File (.pof)** 
- Check **Memory Map File (.map)** 

The window will look similar to this: 

![](images/pfg-1.png) 

3\. Click on the **Input Files** tab, then click on **Add Bitstream...** , then select **Files of type** to be "Raw Binary File (*.rbf)" then browse to the `ghrd_agmf039r47a1e2vr0.hps.rbf` file and click **Open**. 

![](images/pfg-2.png) 

The window will look similar to this: 

![](images/pfg-3.png) 

4\. Go to **Configuration Device** tab, click **Add Device**, select the **CFI_2Gb** option and click **OK**. 

5\. Click on the **OPTIONS** partition to select it, then click the **Edit** button: 

![](images/pfg-4.png) 

6\. In the **Edit Partition** window, select the following: 

- **Address Mode**: Start 
- **Start Address**: 0x00002000 

![](images/pfg-5.png) 

Press **OK**. 

7\. Click on **CFI_2Gb** then click **Add Partition** and select the following: 

- **Name**: P1 
- **Input file**: Bitstream_1 
- **Address mode**: Start 
- **Start address**: 0x00004000 

![](images/pfg-7.png) 

Press **OK**. 

8\. Go to **File** > **Save** menu and save the configuration file as "ghrd_agmf039r47a1e2vr0.pfg" 

![](images/pfg-8.png) 

![](images/pfg-10.png) 

**Note**: The created PFG file contains absolute paths. The attached PFG file was manually edited to use relative paths instead, so it can be used even when moving files in other folders on the host PC. 

9\. At this point you can generate the POF directly by clicking the **Generate** button. 

![](images/pfg-9.png) 

**Caution**: Please use the addresses 0x00002000 for OPTIONS and 0x00004000 for P1, as they are required by the MAX10 board controller. 

### Create POF AVSTx8 Configuration File 

The POF file is created by using the PFG file and running the following command: 

```bash 
cd $TOP_FOLDER 
wget https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-7/m-series/hbm2e/collateral/ghrd_agmf039r47a1e2vr0.pfg
quartus_pfg -c ghrd_agmf039r47a1e2vr0.pfg 
```

The following file is created: 

- $TOP_FOLDER/ghrd_agmf039r47a1e2vr0.pof - contains the MAX 10 flash image required to configure the Agilex™ 7 device over AVST 

### Create CDF Programmer Configuration File 

The provided [ghrd_agmf039r47a1e2vr0.cdf](https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-7/m-series/hbm2e/collateral/ghrd_agmf039r47a1e2vr0.cdf)) file contains the configuration required for the Quartus Programmer to be able to write the POF file to the QSPI attached to the MAX 10 Board Controller. 

This section provides instructions on how this CDF file was created, for reference purposes. 

1\. Set dipswitch S24 to OFF-OFF-OFF-ON so that board configures through JTAG. 

2\. Power up the board 

3\. Start Programmer GUI: 

```bash 
cd $TOP_FOLDER 
quartus_pgmw & 
```

![](images/prog1.png) 

4\. In the Programmer window, click on **Hardware Setup** and select the following: 

- **Currently selected hardware**: Intel Agilex™ M-Series Development Kit - HBM2e Edition 
- **Hardware Frequency**: 16000000 

![](images/prog2.png) 

Then click **Close**. 

5\. In the **Programmer** window click **Autodetect**, then select either option from the **Select Device** window as shown below: 

![](images/prog3.png) 

6\. In the Programmer window, select the **VTAP10** device, then right-click it, and select **Edit** > **Change Device** 

![](images/prog4.png) 

Select the **MAX 10** > **10M50DAF256** device then click **OK**. 

![](images/prog5.png) 

7\. Right click the MAX10 device, and select **Edit** > **Attach Flash Device** 

![](images/prog6.png) 

Select **Quad SPI Flash Memory** > **QSPI_2Gb** option and click **OK** 

![](images/prog7.png) 

8\. Right click the **QSPI_2Gb** entry on the top panel, then click **Change File** 

![](images/prog8.png) 

Browse to "ghrd_agmf039r47a1e2vr0.pof" and click **Open**. 

9\. In the Programmer window, select the **Program/Configure** and **Verify** checkboxes for both "P1" and "OPTION_BITS" partitions 

![](images/prog9.png) 

10\. Go to **File** > **Save** and save the configuration file as "board.cdf" 

**Note**: The output file "ghrd_agmf039r47a1e2vr0.cdf" has an absolute path to the "ghrd_agmf039r47a1e2vr0.pof" file. The provided file was hand edited to use a relative path instead, so files could be located anywhere on the host PC file system. 

11\. At this stage you can also click the **Start** button, for the Programmer to write the file to flash. A progress bar will be shown: 

![](images/prog10.png) 

12\. On successfull completion, the Programmer will show 100% completed: 

![](images/prog11.png) 

### Write POF File Using the CDF File 

1\. Connect the following cables to the board: 

- Power: from board to power supply 
- JTAG: from micro USB cable on edge of the board to host PC 

2\. Configure board to the default settings, except set S24 dipswitch to OFF-OFF-OFF-ON, to select MSEL=JTAG, so that board does not configure on power up. 

3\. Power up the board 

4\. Make sure you have the following files in the current folder: 

- ghrd_agmf039r47a1e2vr0.cdf 
- ghrd_agmf039r47a1e2vr0.pof 

5\. Run the following command to flash the POF file: 

```bash 
cd $TOP_FOLDER 
wget https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-7/m-series/hbm2e/collateral/ghrd_agmf039r47a1e2vr0.cdf
quartus_pgm ghrd_agmf039r47a1e2vr0.cdf 
```

### Boot Linux 

1\. Power down the board 

2\. Set S24 to ON-OFF-OFF-ON to set MSEL=AVSTx8, so that the FPGA device gets configured with the POF on the next power cycle. 

3\. Power up the board 

4\. FPGA device will get configured, the U-Boot SPL will be ran, then U-Boot and then Linux. Log in with 'root' when prompted, no passowrd will be required, just like when configuring board with the RBF file.

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