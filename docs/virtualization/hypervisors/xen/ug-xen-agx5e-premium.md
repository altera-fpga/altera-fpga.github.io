

##  Introduction

This page presents the Xen System Example Design, which is based on the [HPS Baseline System Example Design User Guide: Agilex 5 FPGA E-Series 065B Premium Development Kit (ES)](https://altera-fpga.github.io/rel-26.1.1/embedded-designs/agilex-5/e-series/premium/gsrd/ug-gsrd-agx5e-premium/). 

The Xen System Example Design targets the HPS Enablement Board, and uses SD card for storing the root filesystem.

### Xen Overview

Xen is a free open-source Type-1 hypervisor which enables efficient and secure virtualization of hardware resources to run multiple operating systems on a single physical machine. 

![](images/xen-architecture.svg)

In Xen's architecture, there are two domains. Dom0 is the privileged management domain that runs the hypervisor and has full access to physical hardware, acting as the bridge between the hypervisor and other virtual machines. DomUs are unprivileged guest domains that run operating systems or applications, relying on Dom0 for resource allocation. Dom0 and DomUs operate independently, ensuring isolation and security.

### Prerequisites

The following are required to be able to fully exercise the Agilex 5 Premium Development Kit GSRD:

* [Altera&reg; Agilex&trade; 5 FPGA E-Series 065A Premium Development Kit](https://www.altera.com/products/devkit/po-3002/agilex-5-fpga-and-soc-e-series-premium-development-kit-es), ordering code DK-A5E065BB32AES1.

  * HPS Enablement Expansion Board. Included with the development kit.
  * Mini USB Cable. Included with the development kit.
  * Micro USB Cable. Included with the development kit.
  * Ethernet Cable. Included with the development kit.
  * Micro SD card and USB card writer. Included with the development kit.

* Host PC with:

  * 64 GB of RAM. Less will be fine for only exercising the binaries, and not rebuilding the GSRD.
  * Linux OS installed. Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too
  * Serial terminal (for example GtkTerm or Minicom on Linux and TeraTerm or PuTTY on Windows)
  * SSH server installer, to enable using 'scp' command from target board to host PC
  * Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 26.1.1 
  
* Local Ethernet network, with DHCP server
* Internet connection. For downloading the files, especially when rebuilding the GSRD.


### Prebuilt Binaries

The Agilex&trade; 5 Premium Development Kit Xen binaries are located at 

* [https://releases.rocketboards.org/2026.08/xen/agilex5_dk_a5e065bb32aes1_xen.baseline-a55/](https://releases.rocketboards.org/2026.08/xen/agilex5_dk_a5e065bb32aes1_xen.baseline-a55/)
* [https://releases.rocketboards.org/2026.08/xen/agilex5_dk_a5e065bb32aes1_xen.baseline-a76/](https://releases.rocketboards.org/2026.08/xen/agilex5_dk_a5e065bb32aes1_xen.baseline-a76/)


### Component Versions

Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 26.1.1 and the following software component versions integrate the 26.1.1 release. 


| Component                             | Location                                                     | Branch                       | Commit ID/Tag       |
| :------------------------------------ | :----------------------------------------------------------- | :--------------------------- | :------------------ |
| Agilex 5 Design | [https://github.com/altera-fpga/agilex5e-ed-gsrd](https://github.com/altera-fpga/agilex5e-ed-gsrd) | main                    | QPDS26.1.1_REL_GSRD_PR |
| Linux                                 | [https://github.com/altera-fpga/linux-socfpga](https://github.com/altera-fpga/linux-socfpga) | socfpga-6.18.20-lts | QPDS26.1.1_REL_GSRD_PR |
| Arm Trusted Firmware                  | [https://github.com/altera-fpga/arm-trusted-firmware](https://github.com/altera-fpga/arm-trusted-firmware) | socfpga_v2.14.1   | QPDS26.1.1_REL_GSRD_PR |
| U-Boot                                | [https://github.com/altera-fpga/u-boot-socfpga](https://github.com/altera-fpga/u-boot-socfpga) | socfpga_v2026.04 | QPDS26.1.1_REL_GSRD_PR |
| Yocto Project                         | [https://git.yoctoproject.org/poky](https://git.yoctoproject.org/poky) | wrynose | latest              |
| Yocto meta-altera-fpga Layer | [https://github.com/altera-fpga/meta-altera-fpga](https://github.com/altera-fpga/meta-altera-fpga) | wrynose | QPDS26.1.1_REL_GSRD_PR |
| KAS | [https://github.com/siemens/kas/](https://github.com/siemens/kas/) | master | 5.4 |

**Note:** The combination of the component versions indicated in the table above has been validated through the use cases described in this page and it is strongly recommended to use these versions together. If you decided to use any component with different version than the indicated, there is not warranty that this will work.

### Release Notes

See [https://github.com/altera-fpga/gsrd-socfpga/releases/tag/QPDS26.1.1_REL_GSRD_PR](https://github.com/altera-fpga/gsrd-socfpga/releases/tag/QPDS26.1.1_REL_GSRD_PR)

## Exercise Prebuilt Binaries

Two sets of binaries are provided, the only difference being what boot core is used by the bootloader. Once Linux loads, the two examples have identical behavior. The instructions show how the `baseline-a55` version is used, but `baseline-a76` has identical instructions, just different file names.

Refer to [HPS Baseline System Example Design User Guide: Agilex 5 FPGA E-Series 065B Premium Development Kit (ES)](https://altera-fpga.github.io/rel-26.1.1/embedded-designs/agilex-5/e-series/premium/gsrd/ug-gsrd-agx5e-premium/) for instructions on setting up the development kit.

### Write Binaries

This section shows presents downloading and flashing the SD card image and JIC files, and downloading the xen rootfs cpio archive to be used by DomUs VMs.

1\. Download and write to SD card the image [https://releases.rocketboards.org/2026.08/xen/agilex5_dk_a5e065bb32aes1_xen.baseline-a55/sdimage.tar.gz](https://releases.rocketboards.org/2026.08/xen/agilex5_dk_a5e065bb32aes1_xen.baseline-a55/sdimage.tar.gz)

2\. Download and write to QSPI flash the JIC file [https://releases.rocketboards.org/2026.08/xen/agilex5_dk_a5e065bb32aes1_xen.baseline-a55/ghrd.hps.jic](https://releases.rocketboards.org/2026.08/xen/agilex5_dk_a5e065bb32aes1_xen.baseline-a55/ghrd.hps.jic)

3\. Set MSEL to QSPI, and power cycle the board to boot to Linux.

4\. On the host computer, download the xen rootfs cpio archive:

```bash
wget https://releases.rocketboards.org/2026.08/xen/agilex5_dk_a5e065bb32aes1_xen.baseline-a55/xen-image-minimal-agilex5.rootfs.cpio.gz
```

5\. On the Linux on target board, copy over the above downloaded file in 'xen' folder:

```bash
cd xen
scp <host_user>@<host-ip>:/<host-folder>/xen-image-minimal-agilex5.rootfs.cpio.gz .
```

### Boot Xen Example Design

This section shows how to boot the Xen Example Design. By default, if no other operation is done, the board boots into normal, non-Xen enabled GSRD on a power cycle. In order to boot with the Xen Hypervisor, you need to stop the U-Boot countdown, and boot Linux manually using the commands shown in the below sections. This is provided for convenience, and when used in a real production system, U-Boot can be configured to boot the required Xen configuration automatically.

![](images/xen-boot-flow.svg)

<h4>Boot Without Passthrough</h4>

1\. Set MSEL to QSPI, and power cycle the board

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
| Ethernet | fdt set /soc@0/ethernet@10830000 xen,passthrough |

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

ramdisk = "xen-image-minimal-agilex5.rootfs.cpio.gz"

extra = "root=/dev/ram0 init=/bin/sh console=hvc0 rdinit=/sbin/init"

# Initial memory allocation (MB)
memory = 1024
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

8\. Create VM2 configuration file:

```bash
cat << EOT > test_vm_2.cfg
# Guest name
name = "DomU2"

# Kernel image to boot
kernel = "/boot/Image"

ramdisk = "xen-image-minimal-agilex5.rootfs.cpio.gz"

extra = "root=/dev/ram0 init=/bin/sh console=hvc0 rdinit=/sbin/init"

# Initial memory allocation (MB)
memory = 1024
EOT
```

9\. Start VM2:

```bash
xl create test_vm_2.cfg
```

10\. List running VMs:

```bash
xl list
```

11\. Shutdown VM1:

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

### Ethernet Passthrough

![](images/ethernet-passthrough.svg)

This section shows an example of how to assign the Ethernet IP to a DomU VM, instead of being used by Dom0, which is the default.

1\. Write binaries

2\. Boot to U-Boot prompt by interrupting the U-Boot countdown

3\. Run the following U-Boot commands:

```bash
fatls mmc 0:1
fatload mmc 0:1 $loadaddr boot.scr.xen.uimg
source $loadaddr
fdt set /soc@0/ethernet@10830000 xen,passthrough
booti 0x8a000000 - 0x88000000
```

4\. Xen console messages will be shown, then regular Linux boot console messages.

5\. Log into Linux as usual with 'root' login and no passoword will be requested

6\. Run 'ifconfig' to confirm Dom0 Linux does not have Ethernet anymore:

```bash
root@agilex5e:~# ifconfig
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2172  bytes 134772 (131.6 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2172  bytes 134772 (131.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

7\. Go to xen folder and look at the provided Ethernet passthrough files (dtb file and VM configuration file)

```bash
root@agilex5e:~/# cd xen
root@agilex5e:~/xen# ls *ethernet*
ethernet@10830000.cfg  ethernet@10830000.dtb
root@agilex5e:~/xen# cat ethernet@10830000.cfg
# SPDX-License-Identifier: MIT-0
# Guest name
name = "DomU1"

# Kernel image to boot
kernel = "/boot/Image"

ramdisk = "/home/root/xen/xen-image-minimal-agilex5.rootfs.cpio.gz"

extra = "root=/dev/ram0 init=/bin/sh console=hvc0 rdinit=/sbin/init"

# Initial memory allocation (MB)
memory = 1024

device_tree = "ethernet@10830000.dtb"
dtdev = [ "/soc@0/ethernet@10830000" ]
iomem = [ "0x10830,4","0x10d12,1" ]
irqs = [ 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 267, 268, 269, 270, 271, 272 ]
```

8\. Start the VM:

```bash
xl create ethernet\@10830000.cfg
```

9\. Connect to VM console 

```bash
xl console DomU1
```

10\. In the VM console, login with 'root' account, then do an 'ifconfig' or other commands to confirm Ethernet is working:

```bash
root@agilex5e:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 1A:CD:51:03:2A:55  
          inet addr:192.168.1.154  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::18cd:51ff:fe03:2a55/64 Scope:Link
          inet6 addr: 2603:8081:7700:1092::1bb7/128 Scope:Global
          inet6 addr: 2603:8081:7700:1092:18cd:51ff:fe03:2a55/64 Scope:Global
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:12 errors:0 dropped:0 overruns:0 frame:0
          TX packets:20 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:1715 (1.6 KiB)  TX bytes:2275 (2.2 KiB)
          Interrupt:14 Base address:0xc000 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```


### QSPI Passthrough

This section shows an example of how to assign the QSPI IP to a DomU VM, instead of being used by Dom0, which is the default.

![](images/qspi-passthrough.svg)

1\. Write binaries

2\. Boot to U-Boot prompt by interrupting the U-Boot countdown

3\. Run the following U-Boot commands:

```bash
fatls mmc 0:1
fatload mmc 0:1 $loadaddr boot.scr.xen.uimg
source $loadaddr
fdt set /soc@0/spi@108d2000 xen,passthrough
booti 0x8a000000 - 0x88000000
```

4\. Xen console messages will be shown, then regular Linux boot console messages.

5\. Log into Linux as usual with 'root' login and no passoword will be requested

6\. Go to xen folder and look at the provided QSPI passthrough files (dtb file and VM configuration file):

```bash
root@agilex5e:~/# cd xen
root@agilex5e:~/xen# ls *spi*
spi@108d2000.cfg  spi@108d2000.dtb
root@agilex5e:~/xen# cat spi@108d2000.cfg
#SPDX-License-Identifier: MIT-0
# Guest name
name = "DomU1"

# Kernel image to boot
kernel = "/boot/Image"

# Ramdisk
ramdisk = "/home/root/xen/xen-image-minimal-agilex5.rootfs.cpio.gz"

extra = "root=/dev/ram0 init=/bin/sh console=hvc0 rdinit=/sbin/init"

# Initial memory allocation (MB)
memory = 1024

device_tree = "spi@108d2000.dtb"
iomem = [ "0x108d2,1", "0x10900,100" ]
irqs = [ 35 ]

```

7\. Start the VM, and connect to its console

```bash
xl create spi@108d2000.cfg
xl console DomU1
```

8\. In the VM console, login with 'root' account, then run a couple of commands to see QSPI is enabled:

```bash
root@agilex5e:~# mtdinfo
Count of MTD devices:           2
Present MTD devices:            mtd0, mtd1
Sysfs interface supported:      yes
root@agilex5e:~# cat /proc/mtd 
dev:    size   erasesize  name
mtd0: 04200000 00010000 "u-boot"
mtd1: 0be00000 00010000 "root"
```

### Physical Core Assignment to Virtual Machines

When Xen creates a new virtual machine, the Xen scheduler will assign a physical core to be used by this VM depending on load and configuration. However, you can assign specific cores through CPU pinning. Here is described how you can assign a specific core to any of the VM created.

In order to exercise this, you can use any of the test procedures described previously, but the following example will show you how to do it using the procedure described in [Manage VMs](#manage-vms) (booting without passthrough).

1\.  Boot to Linux and create DomU1 and DomU2 VMs keeping both alive. You can check that both of them exist using the following command:

```bash
root@agilex5e:~/xen# xl list
Name                 ID   Mem VCPUs      State   Time(s)
Domain-0              0  2048     2     r-----      45.0
DomU1                 1  1024     1     -b----      23.7
DomU2                 2  1024     1     r-----      15.7
```

2\. Check the current core assignment for each one of the VMs created using the **xl vcpu-list** command:

```bash
root@agilex5e:~/xen# xl vcpu-list
Name             ID  VCPU   CPU State   Time(s) Affinity (Hard / Soft)
Domain-0         0     0    0   r--      27.5    0 / all
Domain-0         0     1    1   -b-      21.3    1 / all
DomU1            1     0    3   -b-      30.6    all / all
DomU2            2     0    2   -b-      30.6    all / all
```

The output of this command indicates in the **CPU** column whcih is the current physical core assigned to each one of the VM. In this case we can see that **DomU1** is running in the physical core 3 while **DomU2** is runninng in the physical core 2.  Also observe the **Affinity** column, in whcih for the **DomU1** and **Dom2**, the Hard Affinity is not restricted to any specific core as it is indicated with **all**.

3\. You can change the core assigned to the VMs using the **xl vcpu-pin** command. The syntax of this command is as follow:

   **xl vcpu-pin**  <VM Domain ID>  <VCPU>  <Physical core>

The parameters of this command can been retrieved from the information provided by the **xl vcpu-list** command.

4\. In this exercise, let's restrict the physical core that can be assinged to the **DomU1** and **DomU2** inverting the core observed in the step 2. In this case we will assign the physical core 2 to **DomU1** and the physical core 3 to **DomU2**.

```bash
root@agilex5e:~/xen# xl vcpu-pin 1 0 2
root@agilex5e:~/xen# xl vcpu-pin 2 0 3
root@agilex5e:~/xen#  xl vcpu-list
Name             ID  VCPU   CPU State   Time(s) Affinity (Hard / Soft)
Domain-0         0     0    0   r--      36.1    0 / all
Domain-0         0     1    1   -b-      30.6    1 / all
DomU1            1     0    2   -b-      64.2    2 / all
DomU2            2     0    3   -b-      64.2    3 / all
```

From the previous campture you can verify that now the core 2 is being assigned to **DOMU1**  and the core 3 is being assigned to **DomU2**. Also observe that in the **Affinity** column these cores are the only ones that can be used by these VMs.

If you want to go beyond, you can compile the following **getCore** application and take it to any created VM. The output of this application tells you in which physical core this is being executed. The easier way to transfer this to a VM is by using the [Ethernet Passthrough](#ethernet-passthrough) example.  You can build the application in your development computer,  and then take it to your VM created in your board through TFTP or SCP applications.

```bash
/* getCore.c app to get the physical core used to execute it.
   This can be compiled with the following command after the appropiate setup of ARM Tool chain
   gcc -g -o getCore getCore.c 
*/
#define _GNU_SOURCE
#include <stdio.h>

unsigned long int read_mpidr(void)
{
    unsigned long int value;
    asm volatile("mrs %[result], mpidr_el1" : [result] "=r" (value));
    return value;
}

unsigned int getCore(){  
   unsigned long mpidr;
   unsigned int core;

   mpidr = read_mpidr();
   core = (mpidr >> 8) & 0xFF;    
   
   return core;
}

int main()
{

  unsigned int core;    
  core = getCore();
  printf("=== My Debug example started on Core %d ===\n", core); 
  
  return 0;
}
```
In any of the VMs created, you can execute  this application before and after calling the **xl vcpu-pin** command to assign an exclusive core and observe that the physical core in which the application is running is changed as expected. This is shown in the following capture. In this capture only one VM is being created. You can see that initially the core 2 was assigned to the **DomU1** VM and when the **getCore** application was run in this VM, it indicates that  this was run in that core. Then in **Domain-0** , the **xl vcpu-pin 1 0 3** is used to assign the core 3 to the **DomU1** VM and when the **getCore** application is run there we can confirm that this is being executed in the core 3.

```bash
#In Domain-0
root@agilex5e:~/xen# xl vcpu-list
Name           ID  VCPU   CPU State   Time(s) Affinity (Hard / Soft)
Domain-0       0     0    0   r--      20.5     0 / all
Domain-0       0     1    1   -b-      16.7     1 / all
DomU1          1     0    2   -b-      36.5     all / all

root@agilex5e:~/xen# xl console DomU1 
<Now in DomU1>
root@agilex5e:~/# tftp -gr getCore 10.10.0.1
root@agilex5e:~/# chmod +x ./getCore
root@agilex5e:~/# ./getCore
=== My Debug example started on Core 2 ===
# Exit from DomU1 with Ctrl+] and return to Domain-0
root@agilex5e:~/xen# xl vcpu-pin 1 0 3
root@agilex5e:~/xen# xl vcpu-list
Name          ID  VCPU   CPU State   Time(s) Affinity (Hard / Soft)
Domain-0      0     0    0   -b-      34.1  0 / all
Domain-0      0     1    1   r--      32.7  1 / all
DomU1         1     0    3   -b-      60.6  3 / all
# Return to DomU1
root@agilex5e:~/# xl console DomU1
root@agilex5e:~/# ./getCore        
=== My Debug example started on Core 3 ===
```

### Memory Isolation in VMs

When creating a secondary virtual machine (i.e. **DomUx**), this runs as a guest and is given access only to the resources given by Xen. Typically, only the RAM is assigned to a VM, like in the VMs created at [Manage VMs](#manage-vms). When Xen creates this VM, it creates a virtualized memory map based on the  resources assigned to this and Xen keeps the mapping in internal tables. These resources could be RAM memory or peripheral that could be configured as passthrough. The main VM (i.e. **Dom0**) will show the full memory map as defined in the device Technical Refernece Manual unless any peripheral is transfer to a secondary VM also using PassThrough mechanism. Xen Hypervisor provide complete isolation between different VMs. Xen uses Guest Physical Addresses **(GPAs)** to represent the physical address space inside a guest OS. Each **DomU** is given its own **GPA** (Guest Physical Addresses ) space, which Xen maps to different  **MFN** (Machine Frame Numbers) in the host’s actual memory. Even though  the VM memory map observed through **/proc/iomem** inside multiple DomUs may look identical, the GPAs are backed by different host memory pages, ensuring isolation between VMs (unless a shared memory region is explicitly defined as part of the VMs configuration).

The following example demonstrates the memory isolation feature in the VMs. This is based on the [Manage VMs](#manage-vms) using only **Dom0** and **DomU1**. This example, demonstrates the memory layout for each one of these VMs using **cat /proc/iomem**. The exercise also access one memory location that is included in the local memory layout, using **devmem2**, to confirm that this is accessible from the same VM. Finally, the exercise tries to access a memory location that belongs to the other VM, verifying that this is not possible as they are isolated from each other.

In **Dom0** read the memory layout and read the 1st  memory location in **GICD**:
```bash
root@agilex5e:~/xen/# cat /proc/iomem 
00000000-0007ffff : 0.sram sram@0
10808000-10808fff : 10808000.mmc0 mmc0@10808000
10830000-108334ff : 10830000.ethernet ethernet@10830000
108d2000-108d20ff : 108d2000.spi spi@108d2000
10900000-109fffff : 108d2000.spi spi@108d2000
10b00000-10b3ffff : 10b00000.usb usb@10b00000
10c03200-10c032ff : 10c03200.gpio gpio@10c03200
10c03300-10c033ff : 10c03300.gpio gpio@10C03300
10d00200-10d002ff : 10d00200.watchdog watchdog@10d00200
10d00300-10d003ff : 10d00300.watchdog watchdog@10d00300
10d00400-10d004ff : 10d00400.watchdog watchdog@10d00400
10d00500-10d005ff : 10d00500.watchdog watchdog@10d00500
10d00600-10d006ff : 10d00600.watchdog watchdog@10d00600
10d10000-10d10fff : 10d10000.clock-controller clock-controller@10d10000
10d11000-10d11fff : 10d11000.rstmgr rstmgr@10d11000
10da0000-10da0fff : 10da0000.i3c i3c@10da0000
10da1000-10da1fff : 10da1000.i3c i3c@10da1000
10db0000-10db04ff : 10db0000.dma-controller dma-controller@10db0000
10dc0000-10dc04ff : 10dc0000.dma-controller dma-controller@10dc0000
11000000-11007fff : usb1@11000000
  11000000-11007fff : xhci-hcd.0.auto usb1@11000000
1100c100-110fffff : 11000000.usb1 usb1@11000000
16002000-16002fff : 16002000.pmu-tcu pmu-tcu@16002000
16042000-16042fff : 16042000.pmu-tbu pmu-tbu@16042000
16062000-16062fff : 16062000.pmu-tbu pmu-tbu@16062000
16082000-16082fff : 16082000.pmu-tbu pmu-tbu@16082000
160a2000-160a2fff : 160a2000.pmu-tbu pmu-tbu@160A2000
160c2000-160c2fff : 160c2000.pmu-tbu pmu-tbu@160C2000
160e2000-160e2fff : 160e2000.pmu-tbu pmu-tbu@160E2000
1d000000-1d00ffff : GICD
1d060000-1d15ffff : GICR
20000000-2fffffff : System RAM
80000000-81ffffff : reserved
98000000-f7ffffff : System RAM
  98010000-99e9ffff : Kernel code
  99ea0000-9a17ffff : reserved
  9a180000-9a71ffff : Kernel data
  a0000000-a0006fff : reserved
  a0200000-a81fffff : reserved
  f2000000-f7ffffff : reserved
9c0000000-9dfffffff : System RAM
  9dd440000-9df9fffff : reserved
  9dfaa8000-9dfaa8fff : reserved
  9dfaa9000-9dfadafff : reserved
  9dfadd000-9dfadefff : reserved
  9dfadf000-9dfadffff : reserved
  9dfae0000-9dfae0fff : reserved
  9dfae1000-9dfbe4fff : reserved
  9dfbe5000-9dfc09fff : reserved
  9dfc0a000-9dfffffff : reserved
  
root@agilex5e:~/xen/# devmem2 0x1d000000
/dev/mem opened.
Memory mapped at address 0xffffa178b000.
Read at address  0x1D000000 (0xffffa178b000): 0x00000012
```

In **DomU1** read the memory layout and read the 1st  memory location in **GICD**:
```bash
root@agilex5e:~# cat /proc/iomem 
03001000-03010fff : GICD
03020000-0401ffff : GICR
40000000-7fffffff : System RAM
  40010000-41e9ffff : Kernel code
  41ea0000-4217ffff : reserved
  42180000-4271ffff : Kernel data
  48000000-4e3e4fff : reserved
  7ca00000-7fbfffff : reserved
  7fc65000-7fc67fff : reserved
  7fc68000-7fce8fff : reserved
  7fce9000-7fd01fff : reserved
  7fd04000-7fd06fff : reserved
  7fd07000-7fe0afff : reserved
  7fe0b000-7fffffff : reserved
root@agilex5e:~# devmem2 0x03001000
/dev/mem opened.
Memory mapped at address 0xffffb8980000.
Read at address  0x03001000 (0xffffb8980000): 0x00000012
```

In **DomU1** read the read the 1st  memory location in **GICD** using the memory address indicated in **Dom0**  to confirm that this is not accessible:
```bash
root@agilex5e:~# devmem2 0x1d000000
/dev/mem opened.
Memory mapped at address 0xffff87bfe000.
Killed
```
In **Dom0** read the read the 1st  memory location in **GICD** using the memory address indicated in **DomU1** to confirm that this is not accessible:
```bash
root@agilex5e:~/xen/# devmem2 0x03001000
/dev/mem opened.
Memory mapped at address 0xffffb738b000.
Killed
```

## Rebuild Xen System Example Design

The embedded software for this System Example Design is built with Yocto, using KAS.

[Kas](https://github.com/siemens/kas) is a Python-based lightweight build orchestration layer on top of BitBake/Yocto. Kas allows you to define your build environment in a YAML manifest, so you can perform checkout, environment setup, configuration, and build invocation with a single command. Kas provides a more maintainable build description, it offers improved reproducibility, reduced setup friction, and a clearer abstraction for managing multiple layers, revisions, and configuration fragments. 

The software source code for this System Example Design is released inside the [software/yocto_linux](https://github.com/altera-fpga/agilex5e-ed-gsrd/tree/QPDS26.1.1_REL_GSRD_PR/dk-a5e065bb32aes1-enablement/baseline-a55/software/yocto_linux) directory. Accessing the link will display a README page with details regarding the software.

For more details about Kas, refer to the official documentation at [https://kas.readthedocs.io/en/latest/](https://kas.readthedocs.io/en/latest/).

### Kas Build Prerequisites

Firtst, the same [prerequisites](#yocto-build-prerequisites) as for regular Yocto build are required. 

1\. Make sure you have Yocto system requirements met: [https://docs.yoctoproject.org/scarthgap/ref-manual/system-requirements.html#supported-linux-distributions](https://docs.yoctoproject.org/scarthgap/ref-manual/system-requirements.html#supported-linux-distributions).

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

In addition to the above, you must also install `python3-newt`, and `python3.10-venv` with a command like this:

```bash
sudo apt-get install python3-newt python3.10-venv
```

### Build SD Card Binaries



The following diagram shows an overview of the building process:

![](images/kas-sd.svg)

<h5>Setup Environment</h5>

1\. Create the top folder to store all the build artifacts:


```bash
sudo rm -rf agilex5_pdk_065b_es_xen.sd
mkdir agilex5_pdk_065b_es_xen.sd
cd agilex5_pdk_065b_es_xen.sd
export TOP_FOLDER=`pwd`
```


Enable Quartus tools to be called from command line:


```bash
source ~/altera_pro/26.1.1/qinit.sh
```






<h5>Build Quartus Design</h5>




```bash
cd $TOP_FOLDER
rm -rf agilex5_soc_devkit_ghrd && mkdir agilex5_soc_devkit_ghrd && cd agilex5_soc_devkit_ghrd
wget https://github.com/altera-fpga/agilex5e-ed-gsrd/releases/download/QPDS26.1.1_REL_GSRD_PR/dk-a5e065bb32aes1-enablement-baseline-a55.zip
unzip dk-a5e065bb32aes1-enablement-baseline-a55.zip
rm -f dk-a5e065bb32aes1-enablement-baseline-a55.zip
make baseline_a55-install
```


The following files are created:

* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/baseline_a55.sof`
* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/baseline_a55_hps_debug.sof`
* `$TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/ghrd.core.rbf`


<h5>Build Yocto Using Kas</h5>



1\. Create and enter a new Python virtual environment:


```bash
cd $TOP_FOLDER/agilex5_soc_devkit_ghrd/software/yocto_linux
python3 -m venv venv --system-site-packages
source venv/bin/activate
pip install --upgrade pip
pip install kas
pip install --upgrade kas
pip install kconfiglib
```


2\. Copy the core.rbf file to where Kas expects it to be:


```bash
cp $TOP_FOLDER/agilex5_soc_devkit_ghrd/install/binaries/ghrd.core.rbf \
   $TOP_FOLDER/agilex5_soc_devkit_ghrd/software/yocto_linux/meta-custom/recipes-fpga/fpga-bitstream/files/baseline_a55_hps_debug.core.rbf
```


3\. Build Yocto with Kas:


```bash
kas build kas.yml:xen_enable.yml gsrd-console-image
```


The following relevant files are created in `$TOP_FOLDER/agilex5_soc_devkit_ghrd/software/yocto_linux/build/tmp/deploy/images/agilex5e/`:

* `gsrd-console-image-agilex5e.rootfs.wic`
* `u-boot-spl-dtb.hex`

> **Note**: If you experience build failures related to file-locks, you can work around these by reducing the parallelism of your build by running the following commands before running `kas`:

```bash
export PARALLEL_MAKE="-j 8"
export BB_NUMBER_THREADS="8"
export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS PARALLEL_MAKE BB_NUMBER_THREADS"
```



<h5>Build QSPI Image</h5>


```bash
cd $TOP_FOLDER
rm -f baseline.hps.jic baseline.core.rbf
quartus_pfg \
-c agilex5_soc_devkit_ghrd/install/binaries/baseline_a55.sof baseline.jic \
-o device=MT25QU128 \
-o flash_loader=A5ED065BB32AE6SR0 \
-o hps_path=agilex5_soc_devkit_ghrd/software/yocto_linux/build/tmp/deploy/images/agilex5e/u-boot-spl-dtb.hex \
-o mode=ASX4 \
-o hps=1
```


The following file is created:

* `$TOP_FOLDER/baseline.hps.jic`




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