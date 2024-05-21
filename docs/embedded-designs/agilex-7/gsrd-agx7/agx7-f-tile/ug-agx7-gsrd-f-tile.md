# GSRD for Agilex 7 I-Series Transceiver-SoC DevKit (4x F-Tile)

## About this Document
This document will review the Golden System Reference Design for the Intel® Agilex? I-Series Transceiver-SoC Development Kit (4x F-Tile). The GSRD demonstrates the following:

* FPGA side
* LEDs connected to GPIO soft IP modules
* DIP switches and push buttons connected to GPIO soft IP modules
* HPS side
* Linux, booted by U-Boot and ATF
* Board web server
* Sample driver
* Reacting to FPGA DIP switches and push buttons
* Sample applications
* Hello world
* Controlling FPGA LEDs: blink, scroll, toggle
* System check application

## Prerequisites

The following are required in order to be able to fully exercise the GSRD:

* Intel® Agilex? I-Series Transceiver-SoC Development Kit (4x F-Tile), ordering code DK-SI-AGI027FB and DK-SI-AGI027FA (prebuilt binaries and build instructions are provided for both).

    * SD/MMC HPS Daughtercard
    * Mini USB cable for serial output
    * Micro USB cable for on-board Intel FPGA Download Cable II
* Micro SD card (4GB or greater)
* Host PC with
    * Linux - Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too
    * Serial terminal (for example Minicom on Linux and TeraTerm or PuTTY on Windows)
    * Micro SD card slot or Micro SD card writer/reader
    * Intel Quartus Prime Pro Edition
        * v23.3 was used for binary release
        * v23.4 used for rebuilding
* Local Ethernet network, with DHCP server (will be used to provide IP address to the board)

You can identify your board by reviewing the the table in Intel Agilex I-Series Transceiver-SoC Development Kit User Guide, "Overview" section:

| Development Kit Version | Ordering Code| Device Part Number | Serial Number Identifier |
|:---------:|:---------:|:--------:|:------------:|
| Intel Agilex® 7 FPGA I-Series Transceiver-SoC Development Kit(Production 1 4x F-Tile) | DK-SI-AGI027FA (Power Solution 2)| AGIB027R31B1E1V | 2000001 |
| Intel Agilex® 7 FPGA I-Series Transceiver-SoC Development Kit (Production 2)| DK-SI-AGI027FC (Power Solution 2)| AGIB027R31B1E1VB	| 3000001 |
| Intel Agilex® 7 FPGA I-Series Transceiver-SoC Development Kit (ES1 4x F-Tile) | DK-SI-AGI027FB (Power Solution 1) | AGIB027R31B1E1VAA| 0001001 |
| Intel Agilex® 7 FPGA I-Series Transceiver-SoC Development Kit (ES) | DK-SI-AGI027FES (Power Solution 1)| AGIB027R31B1E2VR0| 0000001 |

For the DK-SI-AGI027FB version the following are provided:
* Prebuilt binaries for booting from SD card
* Instructions on how to boot from SD card
* Instructions on how to build the booting from SD card binaries

For the DK-SI-AGI027FA version the following are provided:
* Prebuilt binaries for booting from SD card
* Instructions on how to build the booting from SD card binaries

The DK-SI-AGI027FA version of the board differs from the DK-SI-AGI027FB version in that it uses Linear power regulators instead of Enpirion, and also a different FPGA part number. Apart from this, the functionality is the same for both versions of the board. Refer to Building the GSRD for the DK-SI-AGI027FA Version for details on how to update the hardware design and build the binaries for the DK-SI-AGI027FA version.

The U-Boot and Linux compilation, Yocto compilation and creating the SD card image require a Linux host PC. The rest of the operations can be performed on either a Windows or Linux host PC.

## Release Notes

The Intel FPGA HPS Embedded Software release notes can be accessed from the following link: https://www.rocketboards.org/foswiki/Documentation/IntelFPGAHPSEmbeddedSoftwareRelease

## Binary Release Contents

Binaries for DK-SI-AGI027FB (AGIB027R31B1E1VAA)
The binary release files are accessible at https://releases.rocketboards.org/2023.09/gsrd/agilex7_dk_si_agi027fb_gsrd/ and consist of the following:

|File| Description |
|:-----:|:-----:|
|rootfs/console-image-minimal-agilex7.tar.gz| File system minimal |
| rootfs/gsrd-console-image-agilex7.tar.gz	| File system |
| Image |	Kernel image |
| Image.lzma |	Kernel image compressed| 
| agilex7-gsrd-4.2.3-23.3-source.tar.gz |	Source files|
agilex_revb_soc_devkit_ghrd_enpirion_QPDS-23.3pro-23.1std.tar.gz	ghrd
boot.scr.uimg	Boot script FIT image
fit_kernel_agilex7.its	Linux kernel ITS fule
ghrd.core.rbf	FPGA Core RBF
ghrd.hps.rbf	HPS RBF
ghrd_agib027r31b1e1vaa.jic.tar.gz	QSPI Flash Image
ghrd_agib027r31b1e1vaa_hps.sof	HPS SOF file
ghrd_agib027r31b1e1vaa_hps_debug.sof	HPS Debug SOF file
kernel.itb	Linux Kernel FIT image
sdimage.tar.gz	Compressed SD Card Image
sdimage.tar.gz.md5sum	Compressed SD Card Image
socfpga_agilex7_socdk.dtb	Linux device tree
u-boot-spl-dtb.hex	FSBL
u-boot.itb	U-Boot FIT image
u-boot.txt	Boot script
The source code is also included on the SD card in the Linux rootfs path /home/root:
Fixme
File	Description
linux-socfpga-v6.1.38-lts-src.tar.gz	Source code for Linux kernel
u-boot-socfpga-v2023.04-src.tar.gz	Source code for U-Boot
arm-trusted-firmware-v2.9-src.tar.gz	Source code for Arm Trusted Firmware
Binaries for DK-SI-AGI027FA (AGIB027R31B1E1V)
The binary release files are accessible at https://releases.rocketboards.org/2023.09/gsrd/agilex7_dk_si_agi027fa_gsrd/ and consist of the following:
File	Description
rootfs/console-image-minimal-agilex7.tar.gz	File system minimal
rootfs/gsrd-console-image-agilex7.tar.gz	File system
Image	Kernel image
agilex7-gsrd-4.2.3-23.3-source.tar.gz	Source files
agilex_revb_soc_devkit_ghrd_linear_QPDS-23.3pro-23.1std.tar.gz	ghrd
boot.scr.uimg	Boot script FIT image
fit_kernel_agilex7.its	Linux kernel ITS fule
ghrd.core.rbf	FPGA Core RBF
ghrd.hps.rbf	HPS RBF
ghrd_agib027r31b1e1v.jic.tar.gz	QSPI Flash Image
ghrd_agib027r31b1e1v_hps.sof	HPS SOF file
ghrd_agib027r31b1e1v_hps_debug.sof	HPS Debug SOF file
kernel.itb	Linux Kernel FIT image
sdimage.tar.gz	Compressed SD Card Image
sdimage.tar.gz.md5sum	Compressed SD Card Image
socfpga_agilex7_socdk.dtb	Linux device tree
u-boot-spl-dtb.hex	FSBL
u-boot.itb	U-Boot FIT image
u-boot.txt	Boot script
The source code is also included on the SD card in the Linux rootfs path /home/root:
Fixme
File	Description
linux-socfpga-v6.1.38-lts-src.tar.gz	Source code for Linux kernel
u-boot-socfpga-v2023.04-src.tar.gz	Source code for U-Boot
arm-trusted-firmware-v2.9-src.tar.gz	Source code for Arm Trusted Firmware
Before downloading the hardware design please read the agreement in the link https://www.intel.com/content/www/us/en/programmable/downloads/software/license/lic-prog_lic.html
Source Code Release
Quartus Prime Pro v23.4 and the following software component versions are used to build the GSRD:
Component	Location	Branch	Commit ID/Tag
GHRD	https://github.com/altera-opensource/ghrd-socfpga	master	QPDS23.4_REL_GSRD_PR
Linux	https://github.com/altera-opensource/linux-socfpga	socfpga-6.1.55-lts	QPDS23.4_REL_GSRD_PR
Arm Trusted Firmware	https://github.com/arm-trusted-firmware	socfpga_v2.9.1	QPDS23.4_REL_GSRD_PR
U-Boot	https://github.com/altera-opensource/u-boot-socfpga	socfpga_v2023.07	QPDS23.4_REL_GSRD_PR
Yocto Project	https://git.yoctoproject.org/poky	nanbield	latest
Yocto Project: meta-intel-fpga	https://git.yoctoproject.org/meta-intel-fpga	nanbield	latest
Yocto Project: meta-intel-fpga-refdes	https://github.com/altera-opensource/meta-intel-fpga-refdes	nanbield	QPDS23.4_REL_GSRD_PR
Running GSRD with Pre-Built Binaries
Note: The instructions provided here are referred to for DK-SI-AGI027FB, but the same procedure applies for DK-SI-AGI027FA using the corresponding set of files.
Booting Linux
Configuring Board
fm87-devkit.jpg
Set up the board default settings, as listed by the the Intel Agilex I-Series Transceiver-SoC Development Kit User Guide, "Default Settings" section:
Switch	Default Position
S19 [1:4]	OFF/OFF/ON/ON
S20 [1:4]	ON/ON/ON/ON
S9 [1:4]	ON/OFF/OFF/X
S10 [1:4]	ON/ON/ON/ON
S15 [1:4]	ON/ON/ON/OFF
S1 [1:4]	OFF/OFF/OFF/OFF
S6 [1:4]	OFF/OFF/OFF/OFF
S22 [1:4]	ON/ON/ON/ON
S23 [1:4]	ON/ ON / ON / ON
S4 [1:4]	ON/ ON / ON / ON
Writing SD Card
This section explains how to create the SD card necessary to boot Linux, using the SD card image available with the pre-built Linux binaries package. Once the SD card has been created, insert the card into the SD slot of the Micro SD daughter card.
Writing SD Card on Linux
1. Download the SD card image and extract it:
For DK-SI-AGI027FB board:
wget https://releases.rocketboards.org/2023.09/gsrd/agilex7_dk_si_agi027fb_gsrd/sdimage.tar.gz  
tar xf sdimage.tar.gz
For DK-SI-AGI027FA board:
wget https://releases.rocketboards.org/2023.09/gsrd/agilex7_dk_si_agi027fa_gsrd/sdimage.tar.gz  
tar xf sdimage.tar.gz
The extacted file is named gsrd-console-image-agilex.wic.
2. Determine the device associated with the SD card on the host by running the following command before and after inserting the card.
$ cat /proc/partitions 
Let's assume it is /dev/sdx.
3. Use dd utility to write the SD image to the SD card.
$ sudo dd if=gsrd-console-image-agilex.wic of=/dev/sdx bs=1M 
Note we are using sudo to be able to write to the card.
4. Use sync utility to flush the changes to the SD card.
$ sudo sync 
Writing SD Card on Windows
1. Download the SD card and extract it:
For DK-SI-AGI027FB board: https://releases.rocketboards.org/2023.09/gsrd/agilex7_dk_si_agi027fb_gsrd/sdimage.tar.gz
For DK-SI-AGI027FA board: https://releases.rocketboards.org/2023.09/gsrd/agilex7_dk_si_agi027fa_gsrd/sdimage.tar.gz
The extacted file is named gsrd-console-image-agilex.wic.
2. Rename the wic file as sdcard.img
3. Use Win32DiskImager to write the image to the SD card. The tool can be downloaded from https://sourceforge.net/projects/win32diskimager/files/latest/download
win32diskimager.png
Configuring Serial Connection
The OOBE Daughter Card has a built-in FTDI USB to Serial converter chip that allows the host computer to see the board as a virtual serial port. Ubuntu and other modern Linux distributions have built-in drivers for the FTDI USB to Serial converter chip, so no driver installation is necessary on those platforms. On Windows, the SoC EDS Pro installer automatically installs the required drivers if necessary.
The serial communication parameters are:
Baud-rate: 115,200
Parity: none
Flow control: none
Stop bits: 1
On Windows, utilities such as TeraTerm and PuTTY can be used to connect to the board. They are easily configured from the tool menus.
On Linux, the minicom utility can be used. Here is how to configure it:
1. The virtual serial port is usually named /dev/ttyUSB0. In order to determine the device name associated with the virtual serial port on your host PC, please perform the following:
Use the following command to determine which USB serial devices are already installed: ls /dev/ttyUSB*
Connect mini USB cable from J7 to the PC. This will enable the PC to communicate with the board, even if the board is not powered yet.
Use the ls /dev/ttyUSB* command command again to determine which new USB serial device appeared.
2. Install minicom application on host PC, if not installed.
On Ubuntu, use sudo apt-get install minicom
3. Configure minicom.
$ sudo minicom -s
Under Serial Port Setup choose the following:
Serial Device: /dev/ttyUSB0 (edit to match the system as necessary)
Bps/Par/Bits: 115200 8N1
Hardware Flow Control: No
Software Flow Control: No
Hit [ESC] to return to the main configuration menu
Select Save Setup as dfl to save the default setup. Then select Exit.
Writing JIC Image to QSPI Flash
The QSPI JIC image contains the FPGA configuration bitstream, and the U-Boot SPL.
1. Download and extract the image file:
cd $TOP_FOLDER
wget https://releases.rocketboards.org/2023.09/gsrd/agilex7_dk_si_agi027fb_gsrd/ghrd_agib027r31b1e1vaa.jic.tar.gz
tar xf ghrd_agib027r31b1e1vaa.jic.tar.gz
2. Configure MSEL to JTAG:
S9 [1:4]	ON/ON/ON/X
3. Power cycle the board
4. Write the image using the following commands:
cd $TOP_FOLDER
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh \
quartus_pgm -c 1 -m jtag -o "pvi;ghrd_agib027r31b1e1vaa.jic"
5. Configure MSEL back to QSPI:
S9 [1:4]	ON/OFF/OFF/X
Booting Linux
1. Make sure to have the SD card inserted in the board slot.
2. Start serial terminal (when using Minicom it will connect using the selected settings, for others connect manually).
3. Power up the board
4. The device will be configured from QSPI, HPS will be loaded with the U-Boot SPL, which will then load ATF and U-Boot proper, then Linux will be booted. Login using 'root' and no password:
U-Boot SPL 2023.04 (Sep 27 2023 - 06:39:00 +0000)
Reset state: Cold
MPU          1350000 kHz
L4 Main	      400000 kHz
L4 sys free   100000 kHz
L4 MP         200000 kHz
L4 SP         100000 kHz
SDMMC          50000 kHz
DDR: 8192 MiB
SDRAM-ECC: Initialized success with 1548 ms
QSPI: Reference clock at 400000 kHz
WDT:   Started watchdog@ffd00200 with servicing every 1000ms (10s timeout)
denali-nand-dt nand@ffb90000: timeout while waiting for irq 0x2000
denali-nand-dt nand@ffb90000: reset not completed.
Trying to boot from MMC1
## Checking hash(es) for config board-4 … OK
## Checking hash(es) for Image atf … crc32+ OK
## Checking hash(es) for Image uboot … crc32+ OK
## Checking hash(es) for Image fdt-0 … crc32+ OK
NOTICE:  BL31: v2.9.0(release):v2.3-5691-g5c59b622c
NOTICE:  BL31: Built : 01:02:16, Sep 25 2023

U-Boot 2023.04 (Sep 27 2023 - 06:39:00 +0000)socfpga_agilex

CPU:   Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-A53)
Model: SoCFPGA Agilex SoCDK
DRAM:  2 GiB (effective 8 GiB)
Core:  29 devices, 24 uclasses, devicetree: separate
WDT:   Started watchdog@ffd00200 with servicing every 1000ms (10s timeout)
NAND:  denali-nand-dt nand@ffb90000: timeout while waiting for irq 0x2000
denali-nand-dt nand@ffb90000: reset not completed.
Failed to initialize Denali NAND controller. (error -5)
0 MiB
MMC:   dwmmc0@ff808000: 0
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
Loading Environment from UBI... denali-nand-dt nand@ffb90000: timeout while waiting for irq 0x2000
denali-nand-dt nand@ffb90000: reset not completed.
SF: Detected mt25qu02g with page size 256 Bytes, erase size 64 KiB, total 256 MiB
Could not find a valid device for ffb90000.nand.0
Volume env not found!

** Unable to read env from root:env **
In:    serial0@ffc02000
Out:   serial0@ffc02000
Err:   serial0@ffc02000
Net:   
Warning: ethernet@ff800000 (eth0) using random MAC address - 2a:e8:8d:b2:c2:d7
eth0: ethernet@ff800000
Hit any key to stop autoboot:  5

switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:1...
Found U-Boot script /boot.scr.uimg
2403 bytes read in 3 ms (782.2 KiB/s)
## Executing script at 05ff0000
crc32+ Trying to boot Linux from device mmc0
Found kernel in mmc0
11161999 bytes read in 502 ms (21.2 MiB/s)
## Loading kernel from FIT Image at 02000000 …
   Using 'board-4' configuration
   Verifying Hash Integrity … OK
   Trying 'kernel' kernel subimage
     Description:  Linux Kernel
     Type:         Kernel Image
     Compression:  lzma compressed
     Data Start:   0x020000dc
     Data Size:    9245428 Bytes = 8.8 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: 0x06000000
     Entry Point:  0x06000000
     Hash algo:    crc32
     Hash value:   27acbb6f
   Verifying Hash Integrity … crc32+ OK
## Loading fdt from FIT Image at 02000000 …
   Using 'board-4' configuration
   Verifying Hash Integrity … OK
   Trying 'fdt-4' fdt subimage
     Description:  socfpga_socdk_combined
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x028d8cb4
     Data Size:    32233 Bytes = 31.5 KiB
     Architecture: AArch64
     Hash algo:    crc32
     Hash value:   6dc9fb74
   Verifying Hash Integrity … crc32+ OK
   Booting using the fdt blob at 0x28d8cb4
Working FDT set to 28d8cb4
## Loading fpga from FIT Image at 02000000 …
   Trying 'fpga-4' fpga subimage
     Description:  FPGA bitstream for GHRD
     Type:         FPGA Image
     Compression:  uncompressed
     Data Start:   0x028e0b50
     Data Size:    1851392 Bytes = 1.8 MiB
     Load Address: 0x0a000000
     Hash algo:    crc32
     Hash value:   ba465aec
   Verifying Hash Integrity … crc32+ OK
   Loading fpga from 0x028e0b50 to 0x0a000000
..FPGA reconfiguration OK!
Enable FPGA bridges
   Programming full bitstream... OK
   Uncompressing Kernel Image
   Loading Device Tree to 000000007ead6000, end 000000007eae0de8 … OK
Working FDT set to 7ead6000
Removing MTD device #2 (root) with use count 1
Error when deleting partition "root" (-16)
SF: Detected mt25qu02g with page size 256 Bytes, erase size 64 KiB, total 256 MiB
Enabling QSPI at Linux DTB...
Working FDT set to 7ead6000
libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND
libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND
QSPI clock frequency updated
RSU: Firmware or flash content not supporting RSU
RSU: Firmware or flash content not supporting RSU
RSU: Firmware or flash content not supporting RSU
RSU: Firmware or flash content not supporting RSU

Starting kernel …

Deasserting all peripheral resets
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.1.38-altera (oe-user@oe-host) (aarch64-poky-linux-gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40.0.20230703) #1 SMP PREEMPT Tue Sep 12 05:01:29 UTC 2023
[    0.000000] Machine model: SoCFPGA Agilex SoCDK
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000000000000, size 32 MiB
[    0.000000] OF: reserved mem: initialized node svcbuffer@0, compatible id shared-dma-pool
[    0.000000] earlycon: uart0 at MMIO32 0x00000000ffc02000 (options '115200n8')
:
Welcome to 1mPoky (Yocto Project Reference Distro) 4.2.3 (nanbield)0m!

[    2.520830] systemd[1]: Hostname set to .
[    2.968024] systemd[1]: Queued start job for default target Multi-User System.
[    3.019535] systemd[1]: Created slice Slice /system/getty.
:
[   10.246330] socfpga-dwmac ff800000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   10.255015] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   10.281692] 8021q: 802.1Q VLAN Support v1.8

Poky (Yocto Project Reference Distro) 4.2.3 agilex7dksiagi027fb ttyS0

agilex7dksiagi027fb login: root

5. Run 'ifconfig' command to determine the IP of the board:
root@agilexfm87:~# ifconfig
eth0: flags=4163  mtu 1500
        inet 192.168.1.172  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::54c0:6cff:fe8e:fbac  prefixlen 64  scopeid 0x20
        ether 56:c0:6c:8e:fb:ac  txqueuelen 1000  (Ethernet)
        RX packets 100  bytes 7640 (7.4 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 52  bytes 7830 (7.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 21  base 0x2000  

lo: flags=73  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 100  bytes 8468 (8.2 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 100  bytes 8468 (8.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
Running Sample Applications
The GSRD includes a number of sample Linux applications that help demonstrate some of the features of the platform:
Display Hello World message
Control LEDs
Detect interrupts from push buttons and DIP switches
The sample applications can be used as a starting point for users to write their own applications that interact with software IP through Linux drivers.
Prerequisites
1. Boot Linux on the target board as described in Booting Linux. You will not need to use the serial terminal if you plan on using ssh connection.
2. Connect to the board using one of the following options:
Connect using serial console, as described in Booting Linux
Connect using ssh, as described in Connect Using SSH
3. In serial console, or ssh client console, change current folder to be /home/root/intelFPGA. This is where the application binaries are stored.
root@agilexfm87:~# cd /home/root/intelFPGA/
Display Hello World Message
Run the following command to display the Hello World message on the console:
root@agilexfm87:~/intelFPGA# ./hello 
Hello SoC FPGA!%ENDCOLOR
Exercise Soft PIO Driver for LED Control
The following green LEDs are exercised:
USER LED0
USER LED1
USER LED2
USER LED4
Note: USER LED3 is always on, red colored, and cannot be controlled from software.
1. In order to blink an LED in a loop, with a specific delay in ms, run the following command:
./blink <led_number> <delay_ms> 
The led_number specifies the desired LED, and is a value between 0 and 3.
The delay_ms is a number that specifies the desired delay in ms between turning the LED on and off.
2. In order to turn an individual LED on or off, run the following command:
./toggle <led_number> <state> 
The led_number specifies the desired LED, and is a value between 0 and 3.
The state needs to be 0 to turn the LED off, and 1 to turn the LED on.
3. In order to scroll the FPGA LEDs with a specific delay, please run the following command:
./scroll_client <delay> 
The delay specifies the desired scrolling behavior:
delay > 0 - specify new scrolling delay in ms, and start scrolling
delay < 0 - stop scrolling
delay = 0 - display current scroll delay
Register Interrupts and Call Interrupt Service Routine
The following are exercised:
User FPGA DIP switches
USER_SW0
USER_SW1
USER_SW2
USER_SW3
User FPGA push buttons
USER_PB0
USER_PB1
In order to register an interrupt handler to a specific GPIO, you will first need to determine the GPIO number used.
1. Open the Linux Device Tree socfpga_agilex7_ghrd.dtsi file and look up the labels for the DIP switches and Push button GPIOs:
		button_pio: gpio@f9001060 {
				compatible = "altr,pio-1.0";
				reg = <0xf9001060 0x10>;
				interrupt-parent = <&intc>;	
				interrupts = <0 18 4>;
				altr,gpio-bank-width = <4>;
				altr,interrupt-type = <2>;      
				#gpio-cells = <2>;
				gpio-controller;
		};

		dipsw_pio: gpio@f9001070 {
				compatible = "altr,pio-1.0";
				reg = <0xf9001070 0x10>;
				interrupt-parent = <&intc>;	
				interrupts = <0 17 4>;
				altr,gpio-bank-width = <4>;
				altr,interrupt-type = <3>;      
				#gpio-cells = <2>;
				gpio-controller;
		};
2. Run the following to determine the GPIO numbers for the DIP switches
root@agilexfm87:~/intelFPGA#  grep -r "gpio@f9001070" /sys/class/gpio/gpiochip*/label 
/sys/class/gpio/gpiochip1928/label:/soc/gpio@f9001070
This means that the GPIOs 1928 .. 1931 are allocated to the DIP switches (there are 4 of them).
3. Run the followinig to determine the GPIO numbers for the pushbuttons
root@agilexfm87:~/intelFPGA# grep -r "gpio@f9001060" /sys/class/gpio/gpiochip*/label
/sys/class/gpio/gpiochip1960/label:/soc/gpio@f9001060
This means that the GPIOs 1960, 1961 are allocated to the push buttons (there are 2 of them).
4. Register interrupt for one of the dipswiches, using the appropriate GPIO number, as determined in a previous step:
root@agilexfm87:~/intelFPGA# modprobe gpio_interrupt gpio_number=1928 intr_type=3
[  893.594901] gpio_interrupt: loading out-of-tree module taints kernel.
[  893.602212] Interrupt for GPIO:1928
[  893.602212]  registered
5. Toggle the USER_SW0/SW1.1 dipswitch a few times, you will see messages from the interrupt handler
[  933.872016] Interrupt happened at gpio:1928
[  936.630233] Interrupt happened at gpio:1928
[  938.737038] Interrupt happened at gpio:1928
[  939.951513] Interrupt happened at gpio:1928
6. Remove the driver
root@agilexfm87:~/intelFPGA# rmmod gpio_interrupt
7. Register the pushbutton interrupt, using the appropriate GPIO number as determine on a previous step
root@agilexfm87:~/intelFPGA# modprobe gpio_interrupt gpio_number=1960 intr_type=2
[ 1138.025297] Interrupt for GPIO:1960
[ 1138.025297]  registered
8. Push the pusbutton USER_PB0/S2 a few times, you will see interrupt handler messages
[ 1141.672192] Interrupt happened at gpio:1960
[ 1142.110673] Interrupt happened at gpio:1960
[ 1142.499468] Interrupt happened at gpio:1960
[ 1142.884199] Interrupt happened at gpio:1960
9. Once done, remove the handler
root@agilexfm87:~/intelFPGA# rmmod gpio_interrupt
Note: If you are on the ssh console, you will need to run the program dmesg after pressing the button in order to see the messages:
root@stratix10:~/intelFPGA# dmesg 
System Check Application
System check application provides a glance of system status of basic peripherals such as:
USB: USB device driver
Network IP (IPv4): Network IP address
HPS LEDs: HPS LED state
FPGA LEDs: FPGA LED state
Run the application by issuing the following command:
root@agilexfm87:~/intelFPGA# ./syschk
The window will look as shown below - press 'q' to exit:
                                                                               ALTERA SYSTEM CHECK

lo                    : 127.0.0.1                                                  usb1                  : DWC OTG Controller
eth0                  : 192.168.1.172
                                                                                   serial@ffc02100	 : disabled
fpga_led2             : ON                                                         serial@ffc02000	 : okay
hps_led2              : OFF
fpga_led0             : OFF
hps_led0              : OFF
fpga_led3             : OFF
fpga_led1             : OFF
hps_led1              : OFF
Connecting to Board Web Server and SSH Client
Connect to Web Server
1. Boot Linux as described in Booting Linux.
2. Determine the IP address of the board using 'ifconfig' as shown above. Note there will be network interfaces of them, either can be used.
3. Open a web browser on the host PC and type http:// on the address box, then type the IP of your board and hit Enter.
fm87-web.jpg
4. In the section named Interacting with Agilex SoC Development Kit you can perform the following actions:
See which LEDs are ON and which are off in the LED Status. Note that if the LEDs are setup to be scrolling, the displayed scrolling speed will not match the actual scrolling speed on the board.
Stop LEDs from scrolling, by clicking START and STOP buttons. The delay between LEDs turning ON and OFF is set in the LED Lightshow box.
Turn individual LEDs ON and OFF with the ON and OFF buttons. Note that this action is only available when the LED scrolling/lightshow is stopped.
Blink individual LEDs by typing a delay value in ms then clicking the corresponding BLINK button. Note that this action is only available when the LED scrolling/lightshow is stopped.
Connect Using SSH
1. The lower bottom of the web page presents instructions on how to connect to the board using an SSH connection.
fm87-ssh.jpg
2. If the SSH client is not installed on your host computer, you can install it by running the following command on CentOS:
$ sudo yum install openssh-clients 
or the following command on Ubuntu:
$ sudo apt-get install openssh-client 
3. Connect to the board, and run some commands, such as pwd, ls and uname to see Linux in action:
fm87-ssh-logged.jpg
Building the GSRD for the DK-SI-AGI027FB Version
Important Note: The instructions from this section build the latest version of the GSRD.
Quartus Prime Pro v23.3 and the following software component versions are used to build the GSRD:
Component	Location	Branch	Commit ID/Tag
GHRD	https://github.com/altera-opensource/ghrd-socfpga	master	QPDS23.4_REL_GSRD_PR
Linux	https://github.com/altera-opensource/linux-socfpga	socfpga-6.1.55-lts	QPDS23.4_REL_GSRD_PR
Arm Trusted Firmware	https://github.com/arm-trusted-firmware	socfpga_v2.9.1	QPDS23.4_REL_GSRD_PR
U-Boot	https://github.com/altera-opensource/u-boot-socfpga	socfpga_v2023.07	QPDS23.4_REL_GSRD_PR
Yocto Project	https://git.yoctoproject.org/poky	nanbield	-
Yocto Project: meta-intel-fpga	https://git.yoctoproject.org/meta-intel-fpga	nanbield	-
Yocto Project: meta-intel-fpga-refdes	https://github.com/altera-opensource/meta-intel-fpga-refdes	nanbield	QPDS23.4_REL_GSRD_PR
Build Flow
The following diagram illustrates the full build flow for the GSRD based on source code from GitHub.
fm87-build-flow.svg
Setting up Environment
Create a top folder for this example, as the rest of the commands assume this location:
sudo rm -rf agilex_gsrd
mkdir agilex_gsrd
cd agilex_gsrd
export TOP_FOLDER=$(pwd)
Download the compiler toolchain, add it to the PATH variable, to be used by the GHRD makefile to build the HPS Debug FSBL:
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/\
gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
Building the Hardware Design
Use the following commands to build the hardware design:
cd $TOP_FOLDER
rm -rf ghrd-socfpga agilex_soc_devkit_ghrd
git clone -b QPDS23.4_REL_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga
mv ghrd-socfpga/agilex_soc_devkit_ghrd .
rm -rf ghrd-socfpga
cd agilex_soc_devkit_ghrd
export BOARD_TYPE=devkit_fm87
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh make scrub_clean_all
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh make generate_from_tcl
# fix issues in top level verilog file, if not already fixed
sed -i 's/fpga_reset_n,/fpga_reset_n/g' ghrd_agilex_top.v
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh make all
unset BOARD_TYPE
cd ..
The following files are created:
$TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vaa_hps_debug.sof - FPGA configuration file, without HPS FSBL
$TOP_FOLDER/agilex_soc_devkit_ghrd/software/hps_debug/hps_debug.ihex - HPS Debug FSBL
$TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vaa_hps_debug.sof - FPGA configuration file, with HPS Debug FSBL
Building Core RBF
Create the Core RBF file to be used in the rootfs created by Yocto by using the HPS Debug SOF built by the GHRD makefile:
cd $TOP_FOLDER
rm -f *jic* *rbf*
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh \
  quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vaa_hps_debug.sof \
  ghrd_agib027r31b1e1vaa.jic \
  -o device=MT25QU02G \
  -o flash_loader=AGIB027R31B1E1VAA \
  -o mode=ASX4 \
  -o hps=1
rm ghrd_agib027r31b1e1vaa.hps.jic
The following files will be created:
$TOP_FOLDER/ghrd_agib027r31b1e1vaa.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric
Note we are also creating an HPS JIC file, but we are discarding it, as it has the HPS Debug FSBL, while the final image needs to have the U-Boot SPL created by the Yocto recipes.
Setting Up Yocto Build System
1. First, make sure you have Yocto system requirements met: https://docs.yoctoproject.org/3.4.1/ref-manual/system-requirements.html#supported-linux-distributions.
The command to install the required packages on Ubuntu 20.04 is:
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install openssh-server mc libgmp3-dev libmpc-dev gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd liblz4-tool git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison  xinetd tftpd tftp nfs-kernel-server libncurses5 libc6-i386 libstdc++6:i386 libgcc++1:i386 lib32z1 device-tree-compiler curl mtd-utils u-boot-tools net-tools swig -y
On Ubuntu 20.04 you will also need to point the /bin/sh to /bin/bash, as the default is a link to /bin/dash:
 sudo ln -sf /bin/bash /bin/sh
Note: You can also use a Docker container to build the Yocto recipes, refer to https://rocketboards.org/foswiki/Documentation/DockerYoctoBuild for details. When using a Docker container, it does not matter what Linux distribution or packages you have installed on your host, as all dependencies are provided by the Docker container.
2. Clone the Yocto script and prepare the build:
cd $TOP_FOLDER
rm -rf gsrd_socfpga
git clone -b nanbield https://github.com/altera-opensource/gsrd_socfpga
cd gsrd_socfpga
. agilex7_dk_si_agi027fb-gsrd-build.sh
build_setup
Note: Run the following commands to set up again the yocto build environments, if you closed the current window (for example when rebooting the Linux host) and want to resume the next steps:
cd $TOP_FOLDER/gsrd_socfpga
. ./poky/oe-init-build-env agilex7_dk_si_agi027fb-gsrd-rootfs/
Customize Yocto Build
1. Copy the rebuilt files to $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files using the following names, as expected by the yocto recipes:
agilex7_dk_si_agi027fb_gsrd_ghrd.core.rbf - core rbf file for configuring the fabric
In our case we just copy the core.ghrd file in the Yocto recipe location:
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agi027fb_gsrd_ghrd.core.rbf 
ln -s $TOP_FOLDER/ghrd_agib027r31b1e1vaa.core.rbf $CORE_RBF
2. In the Yocto recipe $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb modify the agilex_gsrd_code file location:
SRC_URI:agilex7_dk_si_agi027fb ?= "\
		${GHRD_REPO}/agilex7_dk_si_agi027fb_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agi027fb_gsrd_core \
		"
to look like this:
SRC_URI:agilex7_dk_si_agi027fb ?= "\
		file://agilex7_dk_si_agi027fb_gsrd_ghrd.core.rbf  \
		"
using the following commands:
OLD_URI="\${GHRD_REPO}\/agilex7_dk_si_agi027fb_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agi027fb_gsrd_core"
NEW_URI="file:\/\/agilex7_dk_si_agi027fb_gsrd_ghrd.core.rbf"
sed -i "s/$OLD_URI/$NEW_URI/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
3. In the same Yocto recipe update the SHA256 checksum for the file:
SRC_URI[agilex7_dk_si_agi027fb_gsrd_core.sha256sum] = "225869090fe181cb3968eeaee8422fc409c11115a9f3b366a31e3219b9615267"
by using the following commands:
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ")
OLD_SHA="SRC_URI\[agilex7_dk_si_agi027fb_gsrd_core\.sha256sum\] = .*"
NEW_SHA="SRC_URI[agilex7_dk_si_agi027fb_gsrd_core.sha256sum] = \"$CORE_SHA\""
sed -i "s/$OLD_SHA/$NEW_SHA/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
4. Optionally change the following files in $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/u-boot/files/:
uboot.txt - distroboot script
uboot_script.its - its file for creating FIT image from the above script
5. Optionally change the following file in $WORKSPACE/meta-intel-fpga-refdes/recipes-kernel/linux/linux-socfpga-lts:
fit_kernel_agilex7_dk_si_agf014eb.its - its file for creating the kernel.itb image
Build Yocto
Build Yocto:
bitbake_image
Gather files:
package
Once the build is completed successfully, you will see the following two folders are created:
agilex7_dk_si_agi027fb-gsrd-rootfs: area used by OpenEmbedded build system for builds. Description of build directory structure - https://docs.yoctoproject.org/ref-manual/structure.html#the-build-directory-build
agilex7_dk_si_agi027fb-gsrd-images=: the build script copies here relevant files built by Yocto from the agilex7_dk_si_agi027fb-gsrd-rootfs/tmp/deploy/images/agilex folder, but also other relevant files.
The two most relevant files created in the $TOP_FOLDER/gsrd_socfpga/agilex7_dk_si_agi027fb-gsrd-images folder are:
File	Description
sdimage.tar.gz	SD Card Image, to be written on SD card
u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex	U-Boot SPL Hex file, to be used for generating the bootable SOF file
Building QSPI Flash Image
The QSPI image will contain the FPGA configuration data and the HPS FSBL and it can be built using the following command:
cd $TOP_FOLDER
rm -f *jic* *rbf*
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh \
  quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vaa.sof \
  ghrd_agib027r31b1e1vaa.jic \
  -o hps_path=gsrd_socfpga/agilex7_dk_si_agi027fb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \
  -o device=MT25QU02G \
  -o flash_loader=AGIB027R31B1E1VAA\
  -o mode=ASX4 \
  -o hps=1
The following files will be created:
$TOP_FOLDER/ghrd_agib027r31b1e1vaa.hps.jic - Flash image for HPS First configuration bitstream, phase 1: HPS and DDR
$TOP_FOLDER/ghrd_agib027r31b1e1vaa.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric, discarded, as we already have it on the SD card
Building the GSRD for the DK-SI-AGI027FA Version
The DK-SI-AGI027FA version of the board differs from the DK-SI-AGI027FB version in that it uses Linear power regulators instead of Enpirion, and also a different FPGA part number. Apart from this, the functionality is the same for both versions of the board.
No binaries are provided for the DK-SI-AGI027FA version, and this section presents how to build the binaries to enable booting from SD card on this board. The instructions are basically the same as for the DK-SI-AGI027FB version, only that:
The hardware design is updated with the new part number and to use the Linear regulators
All the relevant instructions were updated to use the new part number (such as those using the SOF filenames, or the QSPI flash loader name)
Build Flow
The following diagram illustrates the full build flow for the GSRD based on source code from GitHub.
fm87-build-flow.svg
Setting up Environment
Create a top folder for this example, as the rest of the commands assume this location:
sudo rm -rf agilex_gsrd_linear
mkdir agilex_gsrd_linear
cd agilex_gsrd_linear
export TOP_FOLDER=$(pwd)
Download the compiler toolchain, add it to the PATH variable, to be used by the GHRD makefile to build the HPS Debug FSBL:
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/\
gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
rm -f gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
export PATH=`pwd`/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
Building the Hardware Design
Use the following commands to build the hardware design:
cd $TOP_FOLDER
rm -rf ghrd-socfpga agilex_soc_devkit_ghrd
git clone -b QPDS23.4_REL_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga
mv ghrd-socfpga/agilex_soc_devkit_ghrd agilex_soc_devkit_ghrd
rm -rf ghrd-socfpga
cd agilex_soc_devkit_ghrd
export BOARD_TYPE=devkit_fm87
export BOARD_PWRMGT=linear
export QUARTUS_DEVICE=AGIB027R31B1E1V
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh make scrub_clean_all
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh make generate_from_tcl
# fix issues in top level verilog file, if not already fixed
sed -i 's/fpga_reset_n,/fpga_reset_n/g' ghrd_agilex_top.v
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh make all
unset BOARD_TYPE
unset BOARD_PWRMGT
unset QUARTUS_DEVICE
cd ..
The following files are created:
$TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1v.sof - FPGA configuration file, without HPS FSBL
$TOP_FOLDER/agilex_soc_devkit_ghrd/software/hps_debug/hps_debug.ihex - HPS Debug FSBL
$TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1v_hps_debug.sof - FPGA configuration file, with HPS Debug FSBL
Building Core RBF
Create the Core RBF file to be used in the rootfs created by Yocto by using the HPS Debug SOF built by the GHRD makefile:
cd $TOP_FOLDER
rm -f *jic* *rbf*
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh \
  quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1v_hps_debug.sof \
  ghrd_agib027r31b1e1v.jic \
  -o device=MT25QU02G \
  -o flash_loader=AGIB027R31B1E1V \
  -o mode=ASX4 \
  -o hps=1
rm ghrd_agib027r31b1e1v.hps.jic
The following files will be created:
$TOP_FOLDER/ghrd_agib027r31b1e1v.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric
Note we are also creating an HPS JIC file, but we are discarding it, as it has the HPS Debug FSBL, while the final image needs to have the U-Boot SPL created by the Yocto recipes.
Setting Up Yocto Build System
1. First, make sure you have Yocto system requirements met: https://docs.yoctoproject.org/3.4.1/ref-manual/system-requirements.html#supported-linux-distributions.
The command to install the required packages on Ubuntu 20.04 is:
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install openssh-server mc libgmp3-dev libmpc-dev gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd liblz4-tool git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison  xinetd tftpd tftp nfs-kernel-server libncurses5 libc6-i386 libstdc++6:i386 libgcc++1:i386 lib32z1 device-tree-compiler curl mtd-utils u-boot-tools net-tools swig -y
On Ubuntu 20.04 you will also need to point the /bin/sh to /bin/bash, as the default is a link to /bin/dash:
 sudo ln -sf /bin/bash /bin/sh
Note: You can also use a Docker container to build the Yocto recipes, refer to https://rocketboards.org/foswiki/Documentation/DockerYoctoBuild for details. When using a Docker container, it does not matter what Linux distribution or packages you have installed on your host, as all dependencies are provided by the Docker container.
2. Clone the Yocto script and prepare the build:
cd $TOP_FOLDER
rm -rf gsrd_socfpga
git clone -b nanbield https://github.com/altera-opensource/gsrd_socfpga
cd gsrd_socfpga
. agilex7_dk_si_agi027fa-gsrd-build.sh
build_setup
Note: Run the following commands to set up again the yocto build environments, if you closed the current window (for example when rebooting the Linux host) and want to resume the next steps:
cd $TOP_FOLDER/gsrd_socfpga
. ./poky/oe-init-build-env agilex7_dk_si_agi027fa-gsrd-rootfs/
Customize Yocto Build
1. Copy the rebuilt files to $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files using the following names, as expected by the yocto recipes:
agilex7_dk_si_agi027fa_gsrd_ghrd.core.rbf - core rbf file for configuring the fabric
In our case we just copy the core.ghrd file in the Yocto recipe location:
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agi027fa_gsrd_ghrd.core.rbf
ln -s $TOP_FOLDER/ghrd_agib027r31b1e1v.core.rbf $CORE_RBF
2. In the Yocto recipe $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb modify the agilex_gsrd_code file location:
SRC_URI:agilex7_dk_si_agi027fa ?= "\
      ${GHRD_REPO}/agilex7_dk_si_agi027fa_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agi027fa_gsrd_core \
      "
to look like this:
SRC_URI:agilex7_dk_si_agi027fa ?= "\
      file://agilex7_dk_si_agi027fa_gsrd_ghrd.core.rbf \
      "
using the following commands:
OLD_URI="\${GHRD_REPO}\/agilex7_dk_si_agi027fa_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agi027fa_gsrd_core"
NEW_URI="file:\/\/agilex7_dk_si_agi027fa_gsrd_ghrd.core.rbf"
sed -i "s/$OLD_URI/$NEW_URI/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
3. In the same Yocto recipe update the SHA256 checksum for the file:
SRC_URI[agilex7_dk_si_agi027fa_gsrd_core.sha256sum] = "225869090fe181cb3968eeaee8422fc409c11115a9f3b366a31e3219b9615267"
by using the following commands:
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ")
OLD_SHA="SRC_URI\[agilex7_dk_si_agi027fa_gsrd_core\.sha256sum\] = .*"
NEW_SHA="SRC_URI[agilex7_dk_si_agi027fa_gsrd_core.sha256sum] = \"$CORE_SHA\""
sed -i "s/$OLD_SHA/$NEW_SHA/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
4. Optionally change the following files in $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/u-boot/files/:
uboot.txt - distroboot script
uboot_script.its - its file for creating FIT image from the above script
5. Optionally change the following file in $WORKSPACE/meta-intel-fpga-refdes/recipes-kernel/linux/linux-socfpga-lts:
fit_kernel_agilex7_dk_si_agi027fa.its - its file for creating the kernel.itb image
Build Yocto
Build Yocto:
bitbake_image
Gather files:
package
Once the build is completed successfully, you will see the following two folders are created:
agilex7_dk_si_agi027fa-gsrd-rootfs: area used by OpenEmbedded build system for builds. Description of build directory structure - https://docs.yoctoproject.org/ref-manual/structure.html#the-build-directory-build
agilex7_dk_si_agi027fa-gsrd-images: the build script copies here relevant files built by Yocto from the agilex7_dk_si_agi027fa-gsrd-rootfs/tmp/deploy/images/agilex folder, but also other relevant files.
The two most relevant files created in the $TOP_FOLDER/gsrd_socfpga/agilex-gsrd-images folder are:
File	Description
sdimage.tar.gz	SD Card Image, to be written on SD card
u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex	U-Boot SPL Hex file, to be used for generating the bootable SOF file
Building QSPI Flash Image
The QSPI image will contain the FPGA configuration data and the HPS FSBL and it can be built using the following command:
cd $TOP_FOLDER
rm -f *jic* *rbf*
~/intelFPGA_pro/23.4/nios2eds/nios2_command_shell.sh \
  quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1v.sof \
  ghrd_agib027r31b1e1v.jic \
  -o hps_path=gsrd_socfpga/agilex7_dk_si_agi027fa-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \
  -o device=MT25QU02G \
  -o flash_loader=AGIB027R31B1E1V\
  -o mode=ASX4 \
  -o hps=1
The following files will be created:
$TOP_FOLDER/ghrd_agib027r31b1e1v.hps.jic - Flash image for HPS First configuration bitstream, phase 1: HPS and DDR
$TOP_FOLDER/ghrd_agib027r31b1e1v.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric, discarded, as we already have it on the SD card