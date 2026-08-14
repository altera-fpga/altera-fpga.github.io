## Introduction

Xen is a free open-source hypervisor originally developed by the University of Cambridge, and now part of [Linux Foundation](https://www.linuxfoundation.org/)'s [Xen Project](https://xenproject.org/). This page presents and overview of Xen, and details about the Altera&reg; support for Xen on the Agilex™ 7, Agilex™ 5, and Agilex™ 3 devices.

Xen enables efficient and secure virtualization of hardware resources to run multiple operating systems on a single physical machine. As a Type-1 hypervisor, Xen operates directly on the hardware, providing high performance and low overhead by managing CPU, memory, and I/O resources for guest virtual machines. It is widely used in cloud computing, server virtualization, and embedded systems due to its scalability, robustness, and support for a variety of guest operating systems. Xen's architecture emphasizes security through isolation, making it a popular choice for environments requiring strong separation between virtual machines.

## Architecture

The Xen hypervisor is the core component that runs directly on the hardware and manages CPU, memory, and interrupts. It provides a virtualized environment for guest operating systems by abstracting hardware resources.

In Xen's architecture, there are two domains. Dom0 is the privileged management domain that runs the hypervisor and has full access to physical hardware, acting as the bridge between the hypervisor and other virtual machines. DomUs are unprivileged guest domains that run operating systems or applications, relying on Dom0 for resource allocation. Dom0 and DomUs operate independently, ensuring isolation and security. 

![](images/xen-architecture.svg)

On Altera&reg; SoC FPGAs, the following OSes are currently supported:

| Device | Dom0 OS| DomU OS |
| :--: | :--: |  :--: |
| Agilex™ 7 |  Linux | Linux |
| Agilex™ 5 | Linux| Linux, Zephyr |
| Agilex™ 3 | Linux| Linux |

Dom0 runs Linux OS and supports xen tools(xl) to create, configure, and manage Xen VMs. Linux guest OS on the Dom0 has by default native access to IO subsystem (peripheral devices).

## Virtualization Modes

Xen supports three primary virtualization modes for physical hardware: passthrough, paravirtualization, and device emulation using HVM (Hardware Virtual Machine). Passthrough enables virtual machines (VMs) to directly access physical hardware, delivering near-native performance for demanding workloads. Paravirtualization enhances VM efficiency by modifying the guest OS to collaborate with the hypervisor, minimizing overhead. HVM mode provides fully emulated devices, allowing unmodified guest operating systems to interact with hardware without direct access. 

On Altera&reg; SoC FPGAs, only passthrough mode is supported, as shown in the table below:

| Device | Passthrough Support |
| :-: | :-: |
| Agilex™ 7  | Ethernet, QSPI, USB, SD |
| Agilex™ 5 | Ethernet, QSPI, USB |
| Agilex™ 3 | QSPI, USB |

Peripherals that are assigned as passthrough are not managed by Dom0, instead they are available to be allocated to DomUs.

**Note**: peripherals like UART, I2C, SPI and GPIO which are not memory mapped at the 4KB MMU page granularity, cannot be configured for Xen passthrough.

## SMMU Support

Xen Hypervisor owns the SMMU peripheral device entirely and setup the STE, CD and others on the SMMU. Xen Hypervisor creates the SMMU stage-2 translation table: IPA(40bits) to PA (40bits). 

For embedded use case when the system memory is in few Gigabytes(<1TB), Xen Hypervisor uses fixed IPA base address 0x4000_0000 for DOMUs, and the mapping of DOMU guest IPA to PA  is managed by the Xen hypervisor.  

Agilex™ 7 HPS uses ARM SMMUv2, and the Xen driver (*xen/drivers/passthrough/arm/smmu.c*) is responsible for managing Stage 2 translation. In this context, Stage 2 translation refers to the translation of IPA (Intermediate Physical Address) to PA (Physical Address), which is crucial for memory management in guest virtual machines. The SMMUv2 in Xen supports both stages of translation. Stage 1 handles IOVA (Input/Output Virtual Address) to IPA conversion, while Stage 2 converts IPA to PA. 

Agilex™ 5 and AgilexAgilex™ 3 HPS, however, uses ARM SMMUv3, and the corresponding Xen driver (*xen/drivers/passthrough/arm/smmu-v3.c*) is responsible for Stage 2 translation only. The current Xen SMMUv3 driver is in technical preview mode and only supports Stage 2 translation (IPA to PA), as opposed to the Linux SMMUv3 driver, which supports both Stage 1 and Stage 2. This limitation implies that while guest virtual machines can access memory through Stage 2 (IPA to PA) translation, Stage 1 translations (IOVA to IPA) are not supported by Xen for SMMUv3. Therefore Partial Reconfiguration (PR), and Remote System Update (RSU),  is not functional yet on Agilex™ 5 since Linux stratix10-svc driver is using stage 1 translation. 

## Boot Flow

The Xen Hypervisor boot flow is similar to regular GSRD boot flow, with the main difference being that instead of U-Boot loading the Linux kernel, it loads the Xen hypervisor, then the Xen hypervisor loads the Linux kernel. 

A significant amount of storage is required for the guest OS root filesystem, and that requires a large storage medium, such as SD card or eMMC device. The provided examples support SD card as storage.

The following diagram shows the regular GSRD boot flow on the top, and the Xen Hypervisor boot flow on the bottom:


![](images/xen-boot-flow.svg)

The boot steps are:

1\. Configuration management firmware (CMF) running on SDM loads the HPS first-stage bootloader (FSBL) into HPS OCRAM and takes the HPS boot core out of reset. 

2\. U-Boot SPL loads into DDR and runs the SSBL image, composed of ATF BL31 and U-Boot proper.

3\. U-Boot Proper is responsible for booting either native Linux operating system or the Xen Hypervisor, depending on the boot configuration.  In the provided Xen GSRD examples, this is achieved by using a different boot script.

Default GSRD boot flow uses native Linux flow and the u-boot distro autoboot runs the *boot.scr.uimg* script to load the Linux Kernel, dtb and/or core.rbf files. 


To boot Xen Hypervisor you need to stop at u-boot prompt by pressing enter during the countdown and instead load and run the Xen uboot script (*boot.scr.xen.uimg*). This is to ensure customer can use the single GSRD image to either boot native Linux or Xen Hypervisor.  

No code change is required in U-boot or ATF to run Xen Hypervisor. 

U-boot boot script (uimg) has been added to Yocto build to boot Xen Hypervisor. 

Additional Linux kernel configuration has been enabled to use Linux kernel with Xen Hypervisor.

## Linux Device Tree

Xen Hypervisor requires device tree and typically Linux device tree is used as base line and xen specific changes are updated using u-boot Flattened Device Tree (FDT) commands.

The example below shows the Agilex™ 5 xen device tree changes, for reference:

```bash
fdt rm /chosen bootargs
fdt set /chosen \#address-cells <1>
fdt set /chosen \#size-cells <1>
fdt set /chosen \xen,xen-bootargs "console=dtuart dtuart=serial0 $xen_bootargs bootscrub=0 maxcpus=4 hmp-unsafe=true log_level=debug Dom0_max_vcpus=2 Dom0_vcpus_pin watchdog_timeout=0 timer_slop=0 iommu=verbose iommu=debug "
fdt set /chosen \xen,Dom0-bootargs "rdinit=/bin/sh console=hvc0 earlycon=xen earlyprintk=xen root=/dev/mmcblk0p2 rw rootwait "
fdt mknod /chosen Dom0
fdt set /chosen/Dom0 compatible "multiboot,kernel" "multiboot,module"
fdt set /chosen/Dom0 reg <0x83000000 0x${filesize}>
fdt mknod /chosen dom1
fdt set /chosen/dom1 compatible "multiboot,ramdisk" "multiboot,module"
fdt set /chosen/dom1 reg <0x8b000000 0x8000000>
```

To configure any device for Xen pass-through mode, use below fdt command from u-boot console: 

```bash
fdt set /soc@0/<device@physical_address> xen,passthrough
```

For example this is how you set the QSPI as passthrough, to be used by DomUs instead of Dom0:

## Domain Configuration

Altera support for Xen on the Agilex™ 7 and Agilex™ 5 devices uses  Dom0 standard configuration, which allows to control and manage multiple VMs (DomUs). 

 **Dom0 Standard Configuration**:
This configuration is common in traditional Xen setups and is suitable for scenarios where a management domain (Dom0) is required to control and manage the virtualization environment. Dom0 provides the control and management of DomUs.

 **Dom0-less Configuration**

Xen also offers a Dom0-less configuration, which is not currently supported for Altera Agilex™ 7 and Agilex™ 5 devices.

In a Dom0-less (or DomU-only) configuration, Dom0 is not required, allowing guest operating systems to run DomUs without a privileged management domain. Such systems are typically configured statically, meaning the number and setup of DomUs are predefined and cannot be easily modified after boot. Additionally, if any DomU operating system crashes, the entire system, including all DomUs, must be rebooted.

For typical embedded use cases, a Dom0-less Xen configuration is preferred. However, it slows down development since setting up and managing a Dom0-less environment is initially more complex. Additionally, it lacks support for the Xen management tool *xl vcpu-pi*, which optimizes CPU resource allocation for performance and workload characterization, and it does not allow dynamic creation or destruction of VMs.


### Dom0 Configuration 

Dom0 is responsible for creating and managing other unprivileged domains (DomUs) that can run various operating systems in parallel.

Xen project best practices suggest initial amount of DOM0 memory should be >= 1024MB and it can be increased based on the practical needs.  

Device tree changes are required for Xen hypervisor (Agilex™ 5 example), xen bootargs responsible for Xen boot up and DOM0 configuration, while dom0-bootargs is for DOM0 Linux kernel.

```xml
	chosen {
		stdout-path = "serial0:115200n8";
		#address-cells = <1>;
		#size-cells = <1>;

    	xen,dom0-bootargs = "rdinit=/bin/sh console=hvc0 earlycon=xen earlyprintk=xen root=/dev/mmcblk0p2 rw rootwait";
    	xen,xen-bootargs = "console=dtuart dtuart=serial0 dom0_mem=2048M  guest_loglvl=all loglvl=all maxcpus=4 hmp-unsafe=true dom0_max_vcpus=2 dom0_vcpus_pin iommu=verbose iommu=debug";	

		dom0 {
			compatible = "multiboot,kernel", "multiboot,module";
			reg = <0x82000000 [Size of Kernel Image]>;
		};
		dom1 {
			compatible = "multiboot,ramdisk", "multiboot,module";
			reg = <0x8b000000 [Size of Ramdisk]>; 
		};
	};
```
**Xen Bootargs** : 

* *console = dtuart*: Xen uses the UART specified in the device tree for console messages
* *dtuart=serial0*: serial0 is used as device tree UART (dtuart).
* *dom0_mem=2048M*: Allocates 2048 MB (2 GB) of memory to DOM0.
* *dom0_vcpus_pin*: Pins DOM0's vCPUs to specific physical CPUs (pCPUs), ensuring that DOM0's vCPUs always run on dedicated pCPUs without being moved around by the hypervisor. This is to improve performance by reducing context-switch overhead and ensuring that DOM0 has dedicated CPU resources.
* *dom0_max_vcpus=2* : Limits the maximum number of virtual CPUs (vCPUs) that DOM0 can use to 2 vCPUs. 
* *hmp-unsafe = true* : Xen Hypervisor supports HMP (Heterogeneous Multi-Processing), commonly known as big.LITTLE architecture. Where system have mix of high-performance “big” cores (e.g. A76) and power-efficient “LITTLE” cores(e.g. A55).

The "unsafe" setting indicates that Xen will not take the necessary precautions to ensure secure scheduling between the heterogeneous cores, user need to ensure the CPU affinity is set correctly. Usually, DOM0 are pinned to big cores with higher performance and security features. This can help avoid the risk of running privileged code or security-sensitive tasks on less capable LITTLE cores. 

For Agilex™ 5 *hmp-unsafe = true* is mandatory to enable all the 4 cores otherwise only 2 cores are enabled by Xen Hypervisor.

**Dom0 Bootargs** :

* *root = /dev/mmcblk0p2*: Specifies the location of the root filesystem on the SD card partition for the Linux kernel in DOM0. To boot using ramdiks image instead of SD card, use the following dom0-bootargs: *xen,dom0-bootargs = "initrd=0x8b000000 root=/dev/ram0 rw init=/sbin/init console=hvc0 earlycon=xen";*

* *Console=hvc0*: All output from the Linux kernel running in DOM0 will be directed to Hypervisor Virtual Console (hvc0). Xen manages the HVC consoles by creating a virtual console for each domain (DOM0 or DOMU). Each domain has its own independent virtual console, and Xen routes console I/O (input/output) for each domain appropriately. The HVC driver in the guest OS (DOM0 or DOMU) communicates with Xen via hypercalls, with Xen acting as an intermediary to route the data between the virtual console and the actual hardware UART port.

DOM0 Linux guest OS have direct access to all the IO subsystem (peripheral device) like native Linux running without Xen Hypervisor, except for devices set for xen,passthrough.

Once Xen boots the DOM0 Linux, the  xl tool is used to create a virtual machine (DOMU).

To create a VM/DOMU, use the following command:

```bash
xl create -c <domU configuration file>
```

###  DomU Configuration

Before creating DOMU guest VM, a ramdisk image “*xen-image-minimal-agilexX.cpio.gz* “ needs to be copied to boards xen folder in DOM0 Linux. The ramkdisk image “*xen-image-minimal-agilexX.cpio.gz”* is not a part of the GSRD WIC image to reduce the size of the rootfs on SDcard/eMMC. Xen folder on SD card already contains partial device trees for the passthrough device (.dtb) and xen domu configuration file (.cfg)

Below is the example DomU configuration file:

```bash
# Guest name
name = "DomU1"

# Kernel image to boot
kernel = "/boot/Image"

# Ramdisk
ramdisk = "xen-image-minimal-agilex5.cpio.gz"

# Linux boot args
extra = "root=/dev/ram0 init=/bin/sh console=hvc0 rdinit=/sbin/init"

# Initial memory allocation (MB)
memory = 1024

# QSPI device passthrough example for dtb, iomem and irq parameters
device_tree = "spi@108d2000.dtb"
iomem = [ "0x108d2,1", "0x10900,100" ]
irqs = [ 35 ]
```

Parameters:

* *iomem*: IOMEM setup, assigned 1 page starting at "0x108d20000"  and 100 pages starting at “0x10900000” base address for QSPI peripheral in DOMU.

* *irqs*: Device specific interrupt. Xen irqs parameter is using GIC absolute interrupt numbering. In this example Shared Peripheral Interrupt number is 0x3, so additing 32 for the SPI interrupt to get the absolute interrupt used by GIC controller. 
 irqs = 3 + 32 = 35


 **Note** : To switch from DomU console to Dom0 console, use CTRL+ ] on terminal console. CTRL + ] doesn't work over the telnet, direct UART console access is required.

To switch from Dom0 console to DomU console:
```bash
xl console <Domain Name>
```


## CPU Allocation

Xen Hypervisor supports CPU core allocation at boot time (static CPU allocation) and can switch to another CPU core during runtime (dynamic CPU allocation) for Xen domains. Xen introduced the concept of vCPUs (virtual CPU) and pCPUs (physical CPU). 

**Static CPU allocation** **:** Xen parameters like “maxcpus” and “dom0_max_vcpus” define the maximum number of CPUs available to Xen and DOM0. The “dom0_vcpus_pin” parameter allows vCPUs to be statically pinned to the specific pCPUs, improving performance and reducing overhead by avoiding unnecessary context switches. The “vcpus” parameter in the DOMU configuration file specifies the number of vCPUs per domain. 

**Dynamic CPU allocation** : If static configuration for vCPUs and pCPUs is not defined for Xen or domains, Xen will allocate vCPUs and pCPUs dynamically. 

To determine which physical CPU (pCPU) a Xen domain/guest is running on, you can use the `xl` command-line tool:

```bash
xl vcpu-list <domain_name>
```

It is also possible to switch the physical CPU (pCPU) for any Xen domain using:

```bash
xl vcpu-pin <domain-id> <vcpu-id> <pcpu> 
```
Parameters:
*  <domain-id>: The ID of the domain (VM). Use xl vcpu-list to get the domain ID. 
*  <vcpu-id>: The ID of the vCPU within the VM that you want to pin to a different pCPU.
*  <pCPU>: The physical CPU to which you want to switch the vCPU.

The number of vCPUs and pCPUs assigned to a specific domain is highly depends on real time workload and performance characterization. 


## GSRD Build with Xen Hypervisor

Xen Hypervisor is built using Yocto “meta-virtualization” layer, with recipe-extended included in “meta-intel-fpga-refdes” layer to build Xen Hypervisor using altera github repository as part of GSRD.

The “build.sh” script has been updated to include the “meta-virtualization” layer for GSRD build. The environment variable BUILD_HYP needs to be set to 1, then the “conf/layer.conf” will include the “recipes-extended” that builds Xen Hypervisor. 

The Yocto changes are implemented in such a way that the same “gsrd-console-image-xxxx.wic” image can be used to boot either regular Linux or the Xen Hypervisor using a u-boot boot script. The first partition of the “gsrd-console-image-agilexX.wic” image contains the Linux kernel Image, device tree, core.rbf, boot.scr.xen.uimg and Xen binaries. 

Additional Linux kernel configuration for Xen Hypervisor is enabled “recipes-kernel/linux/linux-socfpga-lts/xen.cfg” and it gets included in default Linux kernel config (defconfig) for “hyp_build”.  

A U-boot boot script, “recipes-bsp/u-boot/files/agilexX_uboot_xen.txt”, has been added to update or modify Linux device tree for Xen Hypervisor boot by adding/removing required properties.

Additionally, “recipes-bsp/u-boot/files/agilexX_uboot_script_xen.its” has been added, and “recipes-bsp/u-boot/u-boot-socfpga-scr.bb” has been updated to create the U-boot boot.scr image files using “agilexX_uboot_xen.txt”. The user can interrupt the U-Boot autoboot process and run the “boot.scr.xen.uimg” to boot the Xen Hypervisor. 

New image, “xen-image-minimal”, has been added to the GSRD Yocto build to use with DOM0/DOMU Linux guest OS. The file “recipes-extended/images/xen-image-minimal.bbappend” has been added to create a smaller image by removing unnecessary packages.

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