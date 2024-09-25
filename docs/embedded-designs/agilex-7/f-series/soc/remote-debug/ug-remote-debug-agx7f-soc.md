##  Introduction

Intel offers an integrated set of System Level Debug (SLD) tools, including:

* SignalTap II Logic Analyzer
* In-System Sources and Probes (ISSP),
* In-System Memory Content Editor)

Typically, the System-Level Debugging (SLD) communication solution was interfacing with the outside world through the JTAG. Then either an USB or Ethernet Blaster could be used to interface JTAG to the host PC.

![](images/option1.png)

![](images/option2.png)

Another alternative approach is also available, to interface the SLD to the outside world directly through Ethernet on board, without requiring either an USB or Ethernet Blaster.

![](images/option3.png)

This page presents an example on how enable this remote debug feature on top of the GSRD.

## Architecture

In the traditional approach the SLD communication solution was based on the Altera JTAG Interface (AJI) which interfaced with the JTAG TAP controller (hard atom in Altera devices which implements the JTAG protocol). The SLD tools used the JTAG channel for communication between software and hardware.

![](images/arch1.png)

The remote FPGA debugging solution consists of the following:

* JTAG-Over Protocol (JOP) Component: Platform Designer component which enables access to debug information through an Avalon&reg;-MM slave bus
* Etherlink: HPS application exporting debug information over Ethernet, available on github: https://github.com/altera-opensource/remote-debug-for-intel-fpga

![](images/arch3.png)

The JOP component requires reset and clocking and also provides an Avalon&reg;-MM slave bus through which is configured and debug information is accessed.

Th Etherlink application runs on HPS, accesses the JOP component slave bus to access the debug information, and provides a TCP/IP link from the host PC running the Quartus Pro debug tools to the board.

The etherlink works with the standard UIO Linux kernel driver.

## Example


This section shows an example of how to use the Remote Debug feature. Communication is established from the board to the host PC through Ethernet, so that the board appears as another JTAG device, listed by jtagconfig utility.

The example is based on the [GSRD](https://www.rocketboards.org/foswiki/Documentation/AgilexSoCGSRD), with the following changes:

 * Adding JOP component to the GHRD
 * Adding JOP to the Linux device tree

Notes:

 * UIO driver is enabled as module in the default kernel configuration file
 * etherlink is already part of the rootfs, built by the Yocto recipes

### Prerequisites

The following are required:

* Altera Agilex&trade; 7 FPGA F-Series Transceiver-SoC Development Kit (Production 1 P-Tiles & E-Tiles) ordering code DK-SI-AGF014EB.
  * SD/MMC HPS Daughtercard
  * Mini USB cable for serial output
  * Micro USB cable for on-board Intel&reg; FPGA Download Cable II
  * Micro SD card
* Host PC with:
  * 64 GB of RAM. Less will be fine for only exercising the binaries, and not rebuilding the GSRD.
  * Linux OS installed. Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too
  * Serial terminal (for example GtkTerm or Minicom on Linux and TeraTerm or PuTTY on Windows)
  * Altera Quartus<sup>&reg;</sup> Prime Pro Edition Version 24.2
* Local Ethernet network, with DHCP server
* Internet connection. For downloading the files, especially when rebuilding the GSRD.

Refer to [board documentation](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/si-agf014.html) for more details about the devkit.

### Set up Environment


Create a top folder for this example, as the rest of the commands assume this location:


```bash
sudo rm -rf agilex7.remote_debug
mkdir agilex7.remote_debug
cd agilex7.remote_debug
export TOP_FOLDER=$(pwd)
```

Download the compiler toolchain, add it to the PATH variable, to be used by the GHRD makefile to build the HPS Debug FSBL:


```bash
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/\
gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
```

Enable Quartus tools to be called from command line:


```bash
export QUARTUS_ROOTDIR=~/intelFPGA_pro/24.2/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```




### Build Hardware Design


The hardware design is based on the GSRD, just that the JOP component is added, and connected to clock, reset and the LWH2F bridge. The following instructions are used:


```bash
cd $TOP_FOLDER
rm -rf ghrd-socfpga agilex_soc_devkit_ghrd
git clone -b QPDS24.2_REL_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga
mv ghrd-socfpga/agilex_soc_devkit_ghrd .
rm -rf ghrd-socfpga
cd agilex_soc_devkit_ghrd
export BOARD_PWRMGT=linear
export ENABLE_JOP=1
make scrub_clean_all
make generate_from_tcl
make all
unset ENABLE_JOP 
unset BOARD_PWRMGT
cd ..
```



The following files are created:

 * `$TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agfb014r24b2e2v.sof` - FPGA configuration file, without HPS FSBL
 * `$TOP_FOLDER/agilex_soc_devkit_ghrd/software/hps_debug/hps_debug.ihex` - HPS Debug FSBL
 * `$TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agfb014r24b2e2v_hps_debug.sof` - FPGA configuration file, with HPS Debug FSBL


For reference, the JOP component can be added manually to a Platform Designer system as follows:

1\. In the IP Catalog search for jop and double-click the component to add it to the system:

![](images/add-jop-1.png)

2\. Configure the JOP component as follows:

![](images/add-jop-2.png)

3\. Connect the reset and clock to JOP component, also connect it's slave bus to the HPS LW bridge, and map it to the desired offset:

![](images/add-jop-3.png)



### Build Core.RBF File


This section shows how to create the core RBF file, which is needed by the Yocto recipes:


```bash
cd $TOP_FOLDER
rm -f *jic* *rbf*
quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agfb014r24b2e2v_hps_debug.sof \
  ghrd_agfb014r24b2e2v.jic \
  -o device=MT25QU02G \
  -o flash_loader=AGFB014R24B2E2V \
  -o mode=ASX4 \
  -o hps=1
rm ghrd_agfb014r24b2e2v.hps.jic
```


The following file is created:

* `$TOP_FOLDER/ghrd_agfb014r24b2e2v.core.rbf`



### Build Yocto


Perform the following steps to build Yocto:

1\. Make sure you have Yocto system requirements met: https://docs.yoctoproject.org/3.4.1/ref-manual/system-requirements.html#supported-linux-distributions.

The command to install the required packages on Ubuntu 22.04 is:

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install openssh-server mc libgmp3-dev libmpc-dev gawk wget git diffstat unzip texinfo gcc \
build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping \
python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd \
liblz4-tool git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison xinetd \
tftpd tftp nfs-kernel-server libncurses5 libc6-i386 libstdc++6:i386 libgcc++1:i386 lib32z1 \
device-tree-compiler curl mtd-utils u-boot-tools net-tools swig -y
```

On Ubuntu 22.04 you will also need to point the /bin/sh to /bin/bash, as the default is a link to /bin/dash:

```bash
 sudo ln -sf /bin/bash /bin/sh
```

**Note**: You can also use a Docker container to build the Yocto recipes, refer to https://rocketboards.org/foswiki/Documentation/DockerYoctoBuild for details. When using a Docker container, it does not matter what Linux distribution or packages you have installed on your host, as all dependencies are provided by the Docker container.

2\. Clone the Yocto script and prepare the build:


```bash
cd $TOP_FOLDER
rm -rf gsrd_socfpga
git clone -b QPDS24.2_REL_GSRD_PR https://github.com/altera-opensource/gsrd_socfpga
cd gsrd_socfpga
. agilex7_dk_si_agf014eb-gsrd-build.sh
build_setup
```


3\. Enable the JOP UIO driver in the Linux device tree, by editing the file `meta-intel-fpga-refdes` to inlcude the changes shown below:

```patch
diff --git a/recipes-bsp/device-tree/files/socfpga_ilc.dtsi b/recipes-bsp/device-tree/files/socfpga_ilc.dtsi
index 387d8bd..156dbb8 100644
--- a/recipes-bsp/device-tree/files/socfpga_ilc.dtsi
+++ b/recipes-bsp/device-tree/files/socfpga_ilc.dtsi
@@ -14,5 +14,10 @@
 			status = "disabled";
 			altr,sw-fifo-depth = <32>;
 		};
+		 jop@f9008000{
+                                compatible = "generic-uio";
+                                reg = <0xf9008000 0x5000>;
+                                reg-names = "jop";
+                };
 	};
 };
```

Note that the range of memory where the JOP is located is `0xf9008000` .. `0xf900dfff`.

This can be done with the provided patch file:


```bash
rm -f agilex7-dts-add-jop.patch
wget https://altera-fpga.github.io/rel-24.2/embedded-designs/agilex-7/f-series/soc/remote-debug/collateral/agilex7-dts-add-jop.patch
pushd meta-intel-fpga-refdes
patch -p1 < ../agilex7-dts-add-jop.patch
popd
```


4\. Update your Yocto recipes to use the core RBF file you have built, similar to how the GSRD does it:


```bash
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agf014eb_gsrd_ghrd.core.rbf
ln -s $TOP_FOLDER/ghrd_agfb014r24b2e2v.core.rbf $CORE_RBF
OLD_URI="\${GHRD_REPO}\/agilex7_dk_si_agf014eb_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_gsrd_core"
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ")
NEW_URI="file:\/\/agilex7_dk_si_agf014eb_gsrd_ghrd.core.rbf;sha256sum=$CORE_SHA"
sed -i "s/$OLD_URI/$NEW_URI/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
sed -i "/agilex7_dk_si_agf014eb_gsrd_core\.sha256sum/d" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
```


5\. Fix issue stemming from community changes after the GSRD tag was released:


```bash
sed -i '/fix-potential-signed-overflow-in-pointer-arithmatic.patch/d' meta-intel-fpga-refdes/recipes-connectivity/openssh/openssh_%.bbappend
```


6\. Build the Yocto recipes:


```bash
bitbake_image
```


7\. Gather the Yocto binaries:


```bash
package
```


The following relevant files are created:

* `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex`
* `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/sdimage.tar.gz`



### Build QSPI Image


Run the following commands to build the QSPI image:


```bash
cd $TOP_FOLDER
rm -f *jic* *rbf*
quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agfb014r24b2e2v.sof \
  ghrd_agfb014r24b2e2v.jic \
  -o hps_path=gsrd_socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \
  -o device=MT25QU02G \
  -o flash_loader=AGFB014R24B2E2V \
  -o mode=ASX4 \
  -o hps=1
```


The following file is created:

* `$TOP_FOLDER/ghrd_agfb014r24b2e2v.hps.jic`



### Run Example

The instructions from this section present how to run the remote debug example. Refer to the [GSRD](https://www.rocketboards.org/foswiki/Documentation/AgilexSoCGSRD) for more detailed instructions on how to set up the board, serial port, and write the binaries.

1\. Write the QSPI image `$TOP_FOLDER/ghrd_agfb014r24b2e2v.hps.jic` to flash.

2\. Extract and write the SD card image `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/sdimage.tar.gz` to the SD card

3\. Boot board and log into Linux.

4\. Determine board IP address by running the `ifconfig` command:


```bash
root@agilex7dksiagf014eb:~# ifconfig
eth0: flags=-28605<UP,BROADCAST,RUNNING,MULTICAST,DYNAMIC>  mtu 1500
        inet 10.122.105.175  netmask 255.255.255.0  broadcast 10.122.105.255
        inet6 fe80::7097:4bff:fe41:b7c2  prefixlen 64  scopeid 0x20<link>
        ether 72:97:4b:41:b7:c2  txqueuelen 1000  (Ethernet)
        RX packets 218  bytes 23619 (23.0 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 78  bytes 11072 (10.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 22  
```

5\. Remove pre-existing instances of the driver, and load it again:

```bash
root@agilex7dksiagf014eb:~# rmmod uio_pdrv_genirq
root@agilex7dksiagf014eb:~# modprobe uio_pdrv_genirq of_id="generic-uio"
s```

6\. Start the etherlink application, specifying which port to accept connections on as shown below:

```bash

root@agilex7dksiagf014eb:~# etherlink --port=33301
INFO: Etherlink Server Configuration:
INFO:    H2T/T2H Memory Size  : 4096
INFO:    Listening Port       : 33301
INFO:    IP Address           : 0.0.0.0
INFO: UIO Platform Configuration:
INFO:    Driver Path: /dev/uio0
INFO:    Address Span: 20480
INFO:    Start Address: 0x0
INFO: Server socket is listening on port: 33301
```

7\. On the host, establish the JTAG communication to the board through Ethernet, using the board IP and the selected port number:

```bash
$ jtagconfig --add JTAG-over-protocol sti://localhost:0/intel/remote-debug/10.122.105.175:33301/0
```

8\. Also on the host, run the 'jtagconfig' command to show the newly added connection:

```bash
$ jtagconfig
1) JTAG-over-protocol [sti://localhost:0/intel/remote-debug/10.122.105.175:33301/0]
  020D10DD   VTAP10
```

At this point, the connection can be used by the tools which need a JTAG connection, like SignalTap.



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