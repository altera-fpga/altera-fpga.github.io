

# HPS GSRD User Guide for the Agilex™ 7 FPGA F-Series Transceiver-SoC Development Kit (P-Tiles & E-Tile)

## Overview

The Golden System Reference Design (GSRD) is a reference design running on the Agilex™ 7 FPGA F-Series Transceiver-SoC Development Kit (P-Tiles & E-Tile).

The GSRD is comprised of the following components:

- Golden Hardware Reference Design (GHRD)
- Reference HPS software including:
  - Arm Trusted Firmware
  - U-Boot
  - Linux Kernel
  - Linux Drivers
  - Sample Applications

### Prerequisites

The following are required in order to be able to fully exercise the GSRD:

- [Agilex™ 7 FPGA F-Series Transceiver-SoC Development Kit (P-Tiles & E-Tile)](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/si-agf014.html) ordering code DK-SI-AGF014EB
- SD/MMC HPS Daughtercard
  - SDM QSPI Bootcard
  - Mini USB cable for serial output
  - Micro USB cable for on-board Altera® FPGA Download Cable II
  - Micro SD card (4GB or greater)
- Host PC with
  - Linux - Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too
  - Serial terminal (for example Minicom on Linux and TeraTerm or PuTTY on Windows)
  - Micro SD card slot or Micro SD card writer/reader
  - Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 25.3
  - Local Ethernet network, with DHCP server (will be used to provide IP address to the board)

You can determine your board version by referring to the following table from [https://www.intel.com/content/www/us/en/docs/programmable/683752/current/overview.html](https://www.intel.com/content/www/us/en/docs/programmable/683752/current/overview.html)

| Development Kit Version | Ordering Code | Device Part Number | Starting Serial Number |
| :-- | :-- | :-- | --: |
| Altera® Agilex™ 7 FPGA F-Series Transceiver-SoC Development Kit (Production 2 P-Tiles & E-Tiles) | DK-SI-AGF014EB | AGFB014R24B2E2V (Power Solution 2) | 00205001 |
| Altera® Agilex™ 7 FPGA F-Series Transceiver-SoC Development Kit (Production 1 P-Tiles & E-Tiles) | DK-SI-AGF014EA | AGFB014R24B2E2V (Power Solution 1) | 0001101 |
| Altera® Agilex™ 7 FPGA F-Series Transceiver-SoC Development Kit (ES P-Tiles & E-Tiles) | DK-SI-AGF014E3ES | AGFB014E3ES (Power Solution 1) | 0001001 |

The DK-SI-AGF014E3ES and DK-SI-AGF014EA are deprecated, and not supported anymore. Refer to previous versions of this page for more information about them.

The U-Boot and Linux compilation, Yocto compilation and creating the SD card image require a Linux host PC. The rest of the operations can be performed on either a Windows or Linux host PC.

### Release Contents

#### Release Notes

The Altera® FPGA HPS Embedded Software release notes can be accessed from the following link: [https://github.com/altera-fpga/gsrd-socfpga/releases/tag/QPDS25.3_REL_GSRD_PR](https://github.com/altera-fpga/gsrd-socfpga/releases/tag/QPDS25.3_REL_GSRD_PR)

#### Prebuilt Binaries

<h5>SD Card Boot</h5>

The release files are accessible at [https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_si_agf014eb_gsrd/](https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_si_agf014eb_gsrd/)


The source code is also included on the SD card in the Linux rootfs path `/home/root`:

| File | Description |
| :-- | :-- |
| linux-socfpga-v6.12.33-lts-src.tar.gz | Source code for Linux kernel |
| u-boot-socfpga-v2025.07-src.tar.gz | Source code for U-Boot |
| arm-trusted-firmware-v2.13.0-src.tar.gz | Source code for Arm Trusted Firmware |

Before downloading the hardware design please read the agreement in the link [https://www.intel.com/content/www/us/en/programmable/downloads/software/license/lic-prog_lic.html](https://www.intel.com/content/www/us/en/programmable/downloads/software/license/lic-prog_lic.html)

<h5>NAND Boot</h5>

The release files are accessible at [https://releases.rocketboards.org/2025.10/nand/agilex7_dk_si_agf014eb_nand/](https://releases.rocketboards.org/2025.10/nand/agilex7_dk_si_agf014eb_nand/)

To load the binaries in the development kit see [Write NAND Binaries](#write-nand-binaries).

<h5>QSPI Boot</h5>

The release files are accessible at [https://releases.rocketboards.org/2025.10/qspi/agilex7_dk_si_agf014eb_qspi/](https://releases.rocketboards.org/2025.10/qspi/agilex7_dk_si_agf014eb_qspi/).

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

### GHRD Overview

The Golden Hardware Reference Design is an important part of the GSRD and consists of the following components:

- Hard Processor System (HPS)
  - Quad Arm Cortex-A53 MPCore Processor
  - HPS Peripherals connected to Out-of-Box Experience (OOBE) Daughter Card:
  - Micro SD for HPS storage
  - EMAC
  - HPS JTAG debug
  - I2C
  - USB UART
  - USB 2.0 OTG
  - Two Push buttons and Three LEDs
- Hard Memory Controller (HMC) for HPS External Memory Interface (EMIF)
- FPGA Peripherals connected to Lightweight HPS-to-FPGA (LWH2F) AXI Bridge and JTAG to Avalon Master Bridge
  - Three user LED outputs
  - Four user DIP switch inputs
  - Four user push-button inputs
  - Interrupt Latency Counter
  - System ID
- FPGA Peripherals connected to HPS-to-FPGA (H2F) AXI Bridge
  - 256KB of FPGA on-chip memory
- JTAG to Avalon Master Bridges connected to:
  - FPGA-to-SDRAM 0/1/2 Interfaces
  - FPGA-to-HPS AXI Bridge

![](images/s10-ghrd.png)

The GHRD allows hardware designers to access each peripheral in the FPGA portion of the SoC with System Console, through the JTAG master module. This signal-level access is independent of the driver readiness of each peripheral.

#### MPU Address Maps

This section presents the address maps as seen from the MPU (Cortex-A53) side.

<h5>HPS-to-FPGA Address Map</h5>

The MPU region provide windows of 4 GB into the FPGA slave address space. The lower 1.5 GB of this space is mapped to two separate addresses - firstly from 0x8000_0000 to 0xDFFF_FFFF and secondly from 0x20_0000_0000 to 0x20_5FFF_FFFF. The following table lists the offset of each peripheral from the HPS-to-FPGA bridge in the FPGA portion of the SoC.

| Peripheral | Address Offset | Size (bytes) | Attribute |
| :-- | :-- | :-- | :-- |
| onchip_memory2_0 | 0x0 | 256K | On-chip RAM as scratch pad |

<h5>Lightweight HPS-to-FPGA Address Map</h5>

The the memory map of system peripherals in the FPGA portion of the SoC as viewed by the MPU (Cortex-A53), which starts at the lightweight HPS-to-FPGA base address of **0xF900_0000**, is listed in the following table.

| Peripheral | Address Offset | Size (bytes) | Attribute |
| :-- | :-- | :-- | :-- |
| sysid | 0x0000_0000 | 8 | Unique system ID |
| led_pio | 0x0000_1080 | 16 | LED outputs |
| button_pio | 0x0000_1060 | 16 | Push button inputs |
| dipsw_pio | 0x0000_1070 | 16 | DIP switch inputs |
| ILC | 0x0000_1100 | 256 | Interrupt latency counter (ILC) |

#### JTAG Master Address Map

There are two JTAG master interfaces in the design, one for accessing non-secure peripherals in the FPGA fabric, and another for accessing secure peripheral in the HPS through the FPGA-to-HPS Interface.

The following table lists the address of each peripheral in the FPGA portion of the SoC, as seen through the non-secure JTAG master interface.

| Peripheral | Address Offset | Size (bytes) | Attribute |
| :-- | :-- | :-- | :-- |
| onchip_memory2_0 | 0x0000_0000 | 256K | On-chip RAM |
| sysid | 0x0004_0000 | 8 | Unique system ID |
| led_pio | 0x0004_0080 | 16 | LED outputs |
| button_pio | 0x0004_0060 | 16 | Push button inputs |
| dipsw_pio | 0x0004_0070 | 16 | DIP switch inputs |
| ILC | 0x0004_0100 | 256 | Interrupt latency counter (ILC) |

#### Interrupt Routing

The HPS exposes 64 interrupt inputs for the FPGA logic. The following table lists the interrupt connections from soft IP peripherals to the HPS interrupt input interface.

| Peripheral | Interrupt Number | Attribute |
| :-- | :-- | :-- |
| dipsw_pio | f2h_irq0[0] | 4 DIP switch inputs |
| button_pio | f2h_irq0[1] | 4 Push button inputs |

The interrupt sources are also connected to an interrupt latency counter (ILC) module in the system, which enables System Console to be aware of the interrupt status of each peripheral in the FPGA portion of the SoC.

### Typical HPS Boot Flow

The GSRD boot flow includes the following stages:

1\. SDM

2\. U-Boot SPL

3\. ATF

4\. U-Boot

5\. Linux

6\. Application

![](images/s10_agilex_hps_boot_flow.png)

The following table presents a short description of the different boot stages:

| Stage | Description |
| :-- | :-- |
| SDM | Secure Device Manager boots first |
| U-Boot SPL | Configures IO, FPGA, brings up SDRAM |
| ATF | Arm Trusted Firmware, provides SMC handler |
| U-Boot | Loads Linux kernel |
| Linux | Operating system |
| Application | User application |

For more information, please refer to [Altera® Agilex™ Hard Processor System Technical Reference Manual](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/agilex/mnl-1100.pdf) (Booting and Configuration chapter).

## Exercise Prebuilt GSRD

### Configure Board

This section presents the necessary board settings in order to run the GSRD on the development board.

First, confirm the following:

- SD Card/OOBE Daughter card is installed on HPS Daughter card socket

Then the board switches need to be configured as follows:

- SW1: ON-OFF-OFF-ON
- SW2: all OFF
- SW3: OFF-OFF-ON-ON-ON-ON
- SW4: OFF-OFF-OFF-ON
- SW5: all OFF
- SW6: OFF-OFF-OFF-ON
- SW9: OFF-OFF
- SW10: OFF-ON

### Configure Serial Connection

The OOBE Daughter Card has a built-in FTDI USB to Serial converter chip that allows the host computer to see the board as a virtual serial port. Ubuntu and other modern Linux distributions have built-in drivers for the FTDI USB to Serial converter chip, so no driver installation is necessary on those platforms. On Windows, the SoC EDS Pro installer automatically installs the required drivers if necessary.

The serial communication parameters are:

- Baud-rate: 115,200
- Parity: none
- Flow control: none
- Stop bits: 1

On Windows, utilities such as TeraTerm and PuTTY can be used to connect to the board. They are easily configured from the tool menus.

On Linux, the minicom utility can be used. Here is how to configure it:

The virtual serial port is usually named /dev/ttyUSB0. In order to determine the device name associated with the virtual serial port on your host PC, please perform the following:

- Use the following command to determine which USB serial devices are already installed: ls /dev/ttyUSB*
- Connect mini USB cable from J7 to the PC. This will enable the PC to communicate with the board, even if the board is not powered yet.
- Use the ls /dev/ttyUSB* command command again to determine which new USB serial device appeared.
- Install **minicom** application on host PC, if not installed.

- On Ubuntu, use *sudo apt-get install minicom*
- Configure minicom.

```bash
$ sudo minicom -s
```

Under **Serial Port Setup** choose the following:

- Serial Device: **/dev/ttyUSB0** (edit to match the system as necessary)
- Bps/Par/Bits: **115200 8N1**
- Hardware Flow Control: **No**
- Software Flow Control: **No**
- Hit **[ESC]** to return to the main configuration menu

Select **Save Setup as dfl** to save the default setup. Then select **Exit**.

### Boot from SD Card

This section presents how to write the QSPI Falsh and SD Card image files, configure the board and boot Linux.

#### Write QSPI Image

The QSPI JIC image contains the FPGA configuration bitstream, and the U-Boot SPL.

1\. Download and extract the image file:

```bash
cd $TOP_FOLDER
wget https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_si_agf014eb_gsrd/ghrd_agfb014r24b2e2v.jic.tar.gz
tar xf ghrd_agfb014r24b2e2v.jic.tar.gz
```

2\. Configure MSEL to JTAG:

- SW1: ON-ON-ON-ON

3\. Power cycle the board

4\. Write the image using the following commands:

```bash
cd $TOP_FOLDER
quartus_pgm -c 1 -m jtag -o "pvi;ghrd_agfb014r24b2e2v.jic"
```

5\. Configure MSEL back to QSPI:

- SW1: ON-OFF-OFF-ON


#### Write SD Card Image

This section explains how to create the SD card necessary to boot Linux, using the SD card image available with the pre-built Linux binaries package. Once the SD card has been created, insert the card into the SD slot of the Micro SD daughter card.

<h5>Write SD Card on Linux</h5>

1\. Download the SD card image and extract it:

```bash
wget https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_si_agf014eb_gsrd/sdimage.tar.gz
tar xf sdimage.tar.gz
```

The extacted file is named `gsrd-console-image-agilex7.wic`.

2\. Determine the device associated with the SD card on the host by running the following command before and after inserting the card.

```bash
$ cat /proc/partitions
```

Let's assume it is /dev/sdx.

3\. Use *dd* utility to write the SD image to the SD card.

```bash
$ sudo dd if=gsrd-console-image-agilex7.wic of=/dev/sdx bs=1M
```

Note we are using *sudo* to be able to write to the card.

4\. Use *sync* utility to flush the changes to the SD card.

```bash
$ sudo sync
```

<h5> Write SD Card on Windows</h5>

1\. Download the SD card image and extract it: [https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_si_agf014eb_gsrd/sdimage.tar.gz](https://releases.rocketboards.org/2025.10/gsrd/agilex7_dk_si_agf014eb_gsrd/sdimage.tar.gz)

The extacted file is named `gsrd-console-image-agilex7.wic`.

2\. Rename the wic file as `sdcard.img`

3\. Use Win32DiskImager to write the image to the SD card. The tool can be downloaded from [https://sourceforge.net/projects/win32diskimager/files/latest/download](https://sourceforge.net/projects/win32diskimager/files/latest/download)

![](images/win32diskimager.png)


#### Boot Linux

This section presents how to boot Linux on the board. The required steps are:

1\. Start serial terminal (when using Minicom it will connect using the selected settings, for others connect manually).

2\. Power up the board.

3\. U-Boot SPL is ran

4\. U-Boot is ran

5\. Linux boots.

6\. Login using 'root' and no password.

7\. Run 'ifconfig' command to determine the IP of the board

```bash
root@agilex7dksiagf014eb:~# ifconfig
eth0: flags=4163 mtu 1500
 inet 192.168.1.163 netmask 255.255.255.0 broadcast 192.168.1.255
 inet6 fe80::20cd:5eff:fe36:dbaf prefixlen 64 scopeid 0x20
 ether 22:cd:5e:36:db:af txqueuelen 1000 (Ethernet)
 RX packets 14 bytes 2126 (2.0 KiB)
 RX errors 0 dropped 0 overruns 0 frame 0
 TX packets 43 bytes 7513 (7.3 KiB)
 TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0
 device interrupt 21 base 0x2000

eth1: flags=4099 mtu 1500
 ether 5a:4d:ca:de:cd:f6 txqueuelen 1000 (Ethernet)
 RX packets 0 bytes 0 (0.0 B)
 RX errors 0 dropped 0 overruns 0 frame 0
 TX packets 0 bytes 0 (0.0 B)
 TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0
 device interrupt 22 base 0xc000

lo: flags=73 mtu 65536
 inet 127.0.0.1 netmask 255.0.0.0
 inet6 ::1 prefixlen 128 scopeid 0x10
 loop txqueuelen 1000 (Local Loopback)
 RX packets 100 bytes 8468 (8.2 KiB)
 RX errors 0 dropped 0 overruns 0 frame 0
 TX packets 100 bytes 8468 (8.2 KiB)
 TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0
```

**Note**: there are two IP addresses, one coming from the Ethernet port on the HPS Daughtercard, and one from the Ethernet port on the DevKit, which is connected throgh SGMII.

#### Run Sample Applications

The GSRD includes a number of sample Linux applications that help demonstrate some of the features of the platform:

- Display Hello World message
- Control LEDs
- Detect interrupts from push buttons and DIP switches

The sample applications can be used as a starting point for users to write their own applications that interact with software IP through Linux drivers.

<h5>Prerequisites </h5>

1\. Boot Linux on the target board as described in [Boot Linux](#boot-linux). You will not need to use the serial terminal if you plan on using ssh connection.

2\. Connect to the board using one of the following options:

- Connect using serial console, as described in [Boot Linux](#boot-linux)
- Connect using ssh, as described in [Connect With SSH](#connect-with-ssh)

3\. In serial console, or ssh client console, change current folder to be */home/root/intelFPGA*. This is where the application binaries are stored.

```bash
root@agilex7dksiagf014eb:~# cd /home/root/intelFPGA/
root@agilex7dksiagf014eb:~/intelFPGA#
```

<h5>Display Hello World Message</h5>

Run the following command to display the Hello World message on the console:

```bash
root@agilex7dksiagf014eb:~/intelFPGA# ./hello
Hello SoC FPGA!
```

<h5>Exercise Soft PIO Driver for LED Control</h5>

The following LEDs are exercised:

| User FPGA LED Number | Corresponding Board LED |
| :-- | :-- |
| 0 | D21 |
| 1 | D23 |
| 2 | D25 |

Note: User FPGA LED #3 / D27 is quickly blinking, and cannot be controlled from software.

1\. In order to blink an LED in a loop, with a specific delay in ms, run the following command:

```bash
./blink <led_number> <delay_ms>
```

- The **led_number** specifies the desired LED, and is a value between 0 and 3.
- The **delay_ms** is a number that specifies the desired delay in ms between turning the LED on and off.

2\. In order to turn an individual LED on or off, run the following command:

```bash
./toggle <led_number> <state>
```

- The **led_number** specifies the desired LED, and is a value between 0 and 3.
- The **state** needs to be 0 to turn the LED off, and 1 to turn the LED on.

3\. In order to scroll the FPGA LEDs with a specific delay, please run the following command:

```bash
./scroll_client <delay>
```

The **delay** specifies the desired scrolling behavior:

- **delay > 0** - specify new scrolling delay in ms, and start scrolling
- **delay < 0** - stop scrolling
- **delay = 0** - display current scroll delay

<h5>System Check Application</h5>

System check application provides a glance of system status of basic peripherals such as:

- **USB**: USB device driver
- **Network IP (IPv4)**: Network IP address
- **HPS LEDs**: HPS LED state
- **FPGA LEDs**: FPGA LED state

Run the application by issuing the following command:

```bash
root@agilex7dksiagf014eb:~/intelFPGA# ./syschk
```

The application will look as follows, press 'q' to exit:

```bash
 ALTERA SYSTEM CHECK

lo : 127.0.0.1 usb1 : DWC OTG Controller
eth0 : 192.168.1.163
 serial@ffc02100 : disabled
fpga_led2 : OFF serial@ffc02000 : okay
hps_led2 : OFF
fpga_led0 : OFF
hps_led0 : OFF
fpga_led3 : OFF
fpga_led1 : OFF
hps_led1 : OFF
```

#### Register Interrupts

The following are exercised:

- User FPGA DIP switches
 - SW2.SW0
 - SW2.SW1
 - SW2.SW2
 - SW2.SW3
- User FPGA push buttons
 - 0: S1
 - 1: S2
 - 2: S3
 - 3: S4

In order to register an interrupt handler to a specific GPIO, you will first need to determine the GPIO number used.

1\. Open the Linux Device Tree [socfpga_agilex7_ghrd.dtsi](https://raw.githubusercontent.com/altera-fpga/meta-intel-fpga-refdes/walnascar/recipes-bsp/device-tree/files/socfpga_agilex7_ghrd.dtsi) file and look up the labels for the DIP switches and Push button GPIOs:

```bash
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
```

2\. Run the following to determine the GPIO numbers for the DIP switches

```bash
root@agilex7dksiagf014eb:~/intelFPGA# grep -r "gpio@f9001070" /sys/class/gpio/gpiochip*/label
/sys/class/gpio/gpiochip1928/label:/soc/gpio@f9001070
```

This means that the GPIOs 1928 .. 1931 are allocated to the DIP switches (there are 4 of them).

3\. Run the followinig to determine the GPIO numbers for the pushbuttons

```bash
root@agilex7dksiagf014eb:~/intelFPGA# grep -r "gpio@f9001060" /sys/class/gpio/gpiochip*/label
/sys/class/gpio/gpiochip1960/label:/soc/gpio@f9001060
```

This means that the GPIOs 1960 … 1963 are allocated to the push buttons (there are 4 of them).

4\. Register interrupt for one of the dipswiches, using the appropriate GPIO number, as determined in a previous step:

```bash
root@agilex7dksiagf014eb:~/intelFPGA# modprobe gpio_interrupt gpio_number=1928 intr_type=3
[ 893.594901] gpio_interrupt: loading out-of-tree module taints kernel.
[ 893.602212] Interrupt for GPIO:1928
[ 893.602212] registered
```

5\. Toggle the dipswitch a few times, you will see messages from the interrupt handler

```bash
[ 933.872016] Interrupt happened at gpio:1028
[ 936.630233] Interrupt happened at gpio:1928
[ 938.737038] Interrupt happened at gpio:1928
[ 939.951513] Interrupt happened at gpio:1928
```

6\. Remove the driver

```bash
root@agilex7dksiagf014eb:~/intelFPGA# rmmod gpio_interrupt
```

7\. Register the pushbutton interrupt, using the appropriate GPIO number as determine on a previous step

```bash
root@agilex7dksiagf014eb:~/intelFPGA# modprobe gpio_interrupt gpio_number=1960 intr_type=2
[ 1138.025297] Interrupt for GPIO:1960
[ 1138.025297] registered
```

8\. Push the pusbutton a few times, you will see interrupt handler messages

```bash
[ 1141.672192] Interrupt happened at gpio:1960
[ 1142.110673] Interrupt happened at gpio:1960
[ 1142.499468] Interrupt happened at gpio:1960
[ 1142.884199] Interrupt happened at gpio:1960
```

9\. Once done, remove the handler

```bash
root@agilex7dksiagf014eb:~/intelFPGA# rmmod gpio_interrupt
```

**Note**: If you are on the ssh console, you will need to run the program *dmesg* after pressing the button in order to see the messages:

```bash
root@agilex7dksiagf014eb:~/intelFPGA# dmesg
```

#### Connect to Web Server

The GSRD includes a web server running on the target board that can be used to exercise some of the board features:

- Turning LEDs ON and OFF
- Scrolling LEDs in a sequence
- Displaying the current status of the LEDs

The web page served by the web server also contains links to some relevant information on the Altera® Website.

Perform the following steps to connect to the web server running on the board:

1\. Boot Linux as described in [Booting Linux](#booting-linux).

2\. Determine the IP address of the board using 'ifconfig' as shown above. Note there will be network interfaces of them, either can be used.

3\. Open a web browser on the host PC and type *http://* on the address box, then type the IP of your board and hit Enter.

![](images/agilex-gsrd-webserver.png)

4\. Scroll the webpage down to the section named **Interacting with Agilex™ SoC Development Kit**.

![](images/agilex-gsrd-webserver-interact.png)

You will be able to perform the following actions:

- See which LEDs are ON and which are off in the **LED Status**. Note that if the LEDs are setup to be scrolling, the displayed scrolling speed will not match the actual scrolling speed on the board.
- Stop LEDs from scrolling, by clicking **START** and **STOP** buttons. The delay between LEDs turning ON and OFF is set in the **LED Lightshow** box.
- Turn individual LEDs ON and OFF with the **ON** and **OFF** buttons. Note that this action is only available when the LED scrolling/lightshow is stopped.
- Blink individual LEDs by typing a delay value in ms then clicking the corresponding **BLINK** button. Note that this action is only available when the LED scrolling/lightshow is stopped.

#### Connect With SSH

1\. The lower bottom of the web page presents instructions on how to connect to the board using an SSH connection.

![](images/agilex-gsrd-webserver-ssh.png)

2\. If the SSH client is not installed on your host computer, you can install it by running the following command on CentOS:

```bash
$ sudo yum install openssh-clients
```

or the following command on Ubuntu:

```bash
$ sudo apt-get install openssh-client
```

3\. Connect to the board, and run some commands, such as **pwd**, **ls** and **uname** to see Linux in action.

### Boot from QSPI

#### Write QSPI Image

1\. Configure MSEL to JTAG:

2\. Power cycle the board

3\. Write the image using the following commands:

```bash
quartus_pgm -c 1 -m jtag -o "pvi;flash_image.hps.jic"
```

#### Boot Linux

1\. Configure MSEL back to QSPI

2\. **Important**: Remove SD card (or write zero to first few MBs) to confirm Linux is booting without it.

3\. Power cycle. Board will boot up to Linux prompt, where you can login as 'root' without a password.

**Note**: First time Linux is booted, the UBIFS rootfs will be initialized, the step taking approximately 3 minutes, as shown in the log below:
```
[   12.272151] platform soc:leds: deferred probe pending
<-- ... 3 minute 'gap' here
[  216.905453] UBIFS (ubi0:4): free space fixup complete
[  217.035839] UBIFS (ubi0:4): UBIFS: mounted UBI device 0, volume 4, name "rootfs"
[  217.043228] UBIFS (ubi0:4): LEB size: 65408 bytes (63 KiB), min./max. I/O unit sizes: 8 bytes/256 bytes
[  217.052599] UBIFS (ubi0:4): FS size: 167117440 bytes (159 MiB, 2555 LEBs), max 6500 LEBs, journal size 8650240 bytes (8 MiB, 133 LEBs)
[  217.064650] UBIFS (ubi0:4): reserved for root: 0 bytes (0 KiB)
[  217.070469] UBIFS (ubi0:4): media format: w4/r0 (latest is w5/r0), UUID 4A5F6BFC-BA49-47C9-A17A-425E35F3A52F, small LPT model
[  217.271031] VFS: Mounted root (ubifs filesystem) on device 0:20
```

### Boot from NAND

#### Write NAND Binaries

1\. Copy files to your TFTP server folder:

```bash
cp -f $TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot.itb<your-tftp-server-folder>
cp -f $TOP_FOLDER/nand-bin/root.ubi <your-tftp-server-folder>
```

2\. Run U-Boot with the debugger, similar to how it is described at [Run U-Boot from Debugger](https://rocketboards.org/foswiki/Documentation/BuildingBootloader#Agilex_45_Run_U_45Boot_from_Debugger) just change the script to use the binaries directly from `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/` and use the new name for the sof: `agilex_soc_devkit_ghrd/output_files/ghrd_agfb014r24b2e2v_hps_debug.sof`.

3\. Stop at U-Boot prompt, and run the following instructions to download and write NAND binaries to flash:

```bash
setenv autoload no
dhcp
setenv serverip <your-tftp-server-ip>

tftp $loadaddr u-boot.itb
nand erase.part u-boot
nand write $loadaddr u-boot $filesize

tftp $loadaddr root.ubi
nand erase.part clean root
nand write.trimffs $loadaddr root $filesize
```

#### Write QSPI Image

1\. Power off board

2\. Set MSEL to JTAG

3\. Power on board

4\. Write jic image to QSPI:

```bash
cd $TOP_FOLDER
quartus_pgm -c 1 -m jtag -o "pvi;ghrd_agfb014r24b2e2v.hps.jic"
```

#### Boot Linux

1\. Make sure board is powered off.

2\. Set MSEL to QSPI

3\. Power up the board.

4\. Linux will boot, enter 'root' as user name to log in.

### Partial Reconfiguration

Partial reconfiguration (PR) allows you to reconfigure a portion of the FPGA dynamically, while the rest of the FPGA design continues to function.  This section presents how to run the PR scenarios included with the GSRD.

#### Reference Information

Refer to the following fore more details about Partial Reconfiguration

- User Guide
  - [Altera® Quartus Prime Pro Edition User Guide: Partial Reconfiguration](https://www.intel.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug-qpp-pr.pdf)
- Partial Reconfiguration for Altera® FPGA Devices YouTube videos:
  - [Part1: Introduction & Project Assignments](https://www.youtube.com/watch?v=NAdn39EKWA0)
  - [Part2: Design Guidelines & Host Requirements](https://www.youtube.com/watch?v=drb0cB_TZ3Y)
  - [Part3: PR Host IP & Implementations](https://www.youtube.com/watch?v=DS4_xeLNG1c)
  - [Part4: Output Files & Demonstration](https://www.youtube.com/watch?v=K-h5FfFrqes)

#### Hardware Design

The updated GHRD contains the following components which enable PR:

- A PR region was created in the FPGA fabric, with the following associated IP
  - PR Freeze Controller - to help control the PR
  - Avalon-MM PR Freeze Bridge - to help isolate the IP in the PR region during the PR process
- The base revision of the project has the following in the PR region:
  - SysID located at 0xF900_0800: with id=0xfacecafe
  - OCRAM located at 0xF900_0900
- An alternate revision of the project contains the following in the PR region:
  - SysID located at 0xF900_0900: with id=0xcafeface
  - OCRAM located at 0xF900_0800

The following diagram presents an overview of the PR region and associated IP and how it is connected to HPS:

![](images/pr-hwdesign.png)

Throughout this page, the content of the PR region for the base revision is called "persona0" while the content of the PR region for the other revision is called "persona1". The diagram below illustrates the differences between the two personas:

![](images/pr-personas.png)

#### PR Files

The files on the Linux rootfs used for running the PR scenarios are shown below:

| File | Description |
| :-- | :-- |
| /sbin/dtbt | Tool used for managing the overlays. Available at https://github.com/altera-fpga/dtbt |
| /boot/devicetree/agilex7_pr_fpga_static_region.dtbo | overlay for the static region, needs to be applied before persona overlays |
| /boot/devicetree/agilex7_pr_persona0.dtbo | overlay for persona0 |
| /boot/devicetree/agilex7_pr_persona0.dtbo | overlay for persona1 |
| /lib/firmware/persona0.rbf | bitstream used by persona0 overlay |
| /lib/firmware/persona1.rbf | bitstream used by persona1 overlay |

The DTS files for the overlays are available at https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/walnascar/recipes-bsp/device-tree/files/:

- agilex7_pr_fpga_static_region.dts
- agilex7_pr_persona0.dts
- agilex7_pr_persona1.dts

#### Run PR Scenarios

1\. Boot Linux

2\. Add the overlay for the static region:

```bash
root@agilex7dksiagf014eb:~# dtbt -a agilex7_pr_fpga_static_region.dtbo -p /boot/devicetree
Set dtbo search path to /boot/devicetree
[ 292.932872] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/ranges
Applying dtbo: agilex_pr_fpga_static_region.dtbo
[ 292.944184] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/external-fpga-config
[ 292.960109] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/clocks
[ 292.970529] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /soc/base_fpga_region/clock-names
[ 292.981470] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/clk_0
[ 292.991034] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/freeze_controller_0
[ 293.007735] of-fpga-region soc:base_fpga_region:fpga_pr_region0: FPGA Region probed
[ 293.028076] altera_freeze_br f9000450.freeze_controller: fpga bridge [freeze] registered
```

3\. Add the overlay for persona0:

```bash
root@agilex7dksiagf014eb:~# dtbt -a agilex7_pr_persona0.dtbo -p /boot/devicetree
Set dtbo search path to /boot/devicetree
[ 398.171799] fpga_manager fpga0: writing persona0.rbf to Stratix10 SOC FPGA Manager
Applying dtbo: agilex_pr_persona0.dtbo
[ 398.321356] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/pr_region_0_pr_clk_100
[ 398.332459] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/pr_region_0_pr_sysid_qsys_0
```

4\. Locate the sysid and display the associated id:

```bash
root@agilex7dksiagf014eb:~# find / -name sysid
/sys/devices/platform/soc/soc:base_fpga_region/soc:base_fpga_region:fpga_pr_region0/f9000800.sysid/sysid
root@agilex7dksiagf014eb:~# cat /sys/devices/platform/soc/soc:base_fpga_region/soc:base_fpga_region:fpga_pr_region0/f9000800.sysid/sysid/id | xargs printf "0x%08x\n"
0xcafeface
```

5\. List the applied overlays:

```bash
root@agilex7dksiagf014eb:~# dtbt -l
2 agilex_pr_persona0.dtbo applied /sys/kernel/config/device-tree/overlays/2-agilex_pr_persona0.dtbo
1 agilex_pr_fpga_static_region.dtbo applied /sys/kernel/config/device-tree/overlays/1-agilex_pr_fpga_static_region.dtbo
```

6\. Remove persona0 overlay:

```bash
root@agilex7dksiagf014eb:~# dtbt -r agilex7_pr_persona0.dtbo -p /boot/devicetree
Set dtbo search path to /boot/devicetree
Removing dtbo: 2-agilex_pr_persona0.dtbo
```

7\. Add the persona1 overlay:

```bash
root@agilex7dksiagf014eb:~# dtbt -a agilex7_pr_persona1.dtbo -p /boot/devicetree
Set dtbo search path to /boot/devicetree
[ 531.975623] fpga_manager fpga0: writing persona1.rbf to Stratix10 SOC FPGA Manager
Applying dtbo: agilex_pr_persona1.dtbo
[ 532.124433] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/pr_region_0_pr_clk_100
[ 532.135530] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/pr_region_0_pr_sysid_qsys_0
```

8\. Locate the sysid and display the associated id:

```bash
root@agilex7dksiagf014eb:~# find / -name sysid
/sys/devices/platform/soc/soc:base_fpga_region/soc:base_fpga_region:fpga_pr_region0/f9000900.sysid/sysid
root@agilex7dksiagf014eb:~# cat /sys/devices/platform/soc/soc:base_fpga_region/soc:base_fpga_region:fpga_pr_region0/f9000900.sysid/sysid/id | xargs printf "0x%08x\n"
0xfacecafe
```

9\. Remove persona1:

```bash
root@agilex7dksiagf014eb:~# dtbt -r agilex7_pr_persona1.dtbo -p /boot/devicetree
Set dtbo search path to /boot/devicetree
Removing dtbo: 2-agilex_pr_persona1.dtbo
```

10\. List the applied overlays:

```bash
root@agilex7dksiagf014eb:~# dtbt -l
1 agilex_pr_fpga_static_region.dtbo applied /sys/kernel/config/device-tree/overlays/1-agilex_pr_fpga_static_region.dtbo
```

## Rebuild the GSRD

### Boot from SD Card



#### Build Flow

The following diagram illustrates the full build flow for the GSRD based on source code from GitHub.

![](images/agilex-gsrd-build-flow.svg)

The current build flow creates a single boot image which is able to boot in different board configurations (either using OOBE or eMMC/NAND daughter card). For more information about how this single boot image is created, please refer to the following article: [https://rocketboards.org/foswiki/Documentation/SingleImageBoot](https://rocketboards.org/foswiki/Documentation/SingleImageBoot)

#### Set up Environment


Create a top folder for this example, as the rest of the commands assume this location:


```bash
sudo rm -rf agilex7f_gsrd
mkdir agilex7f_gsrd
cd agilex7f_gsrd
export TOP_FOLDER=$(pwd)
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





#### Build Hardware Design


Use the following commands to build the hardware design:


```bash
cd $TOP_FOLDER
rm -rf agilex7f-ed-gsrd
wget https://github.com/altera-fpga/agilex7f-ed-gsrd/archive/refs/tags/QPDS25.3_REL_GSRD_PR.zip
unzip QPDS25.3_REL_GSRD_PR.zip
rm QPDS25.3_REL_GSRD_PR.zip
mv agilex7f-ed-gsrd-QPDS25.3_REL_GSRD_PR agilex7f-ed-gsrd
cd agilex7f-ed-gsrd
make agf014eb-si-devkit-oobe-baseline-all
```


The following files are created:

- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_baseline.sof` - FPGA configuration file, without HPS FSBL
- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_baseline_hps_debug.sof` - FPGA configuration file, with HPS Debug FSBL


#### Build Core RBF


Create the Core RBF file to be used in the rootfs created by Yocto by using the HPS Debug SOF built by the GHRD makefile:


```bash
cd $TOP_FOLDER
rm -f *jic* *rbf*
quartus_pfg -c $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_baseline_hps_debug.sof \
 ghrd.jic \
 -o device=MT25QU02G \
 -o flash_loader=AGFB014R24B2E2V \
 -o mode=ASX4 \
 -o hps=1
rm ghrd.hps.jic
```


The following files will be created:

- $TOP_FOLDER/ghrd.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric

Note we are also creating an HPS JIC file, but we are discarding it, as it has the HPS Debug FSBL, while the final image needs to have the U-Boot SPL created by the Yocto recipes.





#### Set Up Yocto

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

2\. Clone the Yocto script and prepare the build:


```bash
cd $TOP_FOLDER
rm -rf gsrd-socfpga
git clone -b QPDS25.3_REL_GSRD_PR https://github.com/altera-fpga/gsrd-socfpga
cd gsrd-socfpga
. agilex7_dk_si_agf014eb-gsrd-build.sh
build_setup
```


**Note**: Run the following commands to set up again the yocto build environments, if you closed the current window (for example when rebooting the Linux host) and want to resume the next steps:

```bash
cd $TOP_FOLDER/gsrd-socfpga
. ./poky/oe-init-build-env agilex-gsrd-rootfs/
```

#### Customize Yocto

1\. Copy the rebuilt files to `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files` using the following names, as expected by the yocto recipes:

- agilex7_dk_si_agf014eb_gsrd_ghrd.core.rbf
- agilex7_dk_si_agf014eb_nand_ghrd.core.rbf: not applicable
- agilex7_dk_si_agf014eb_pr_ghrd.core.rbf: not applicable
- agilex7_dk_si_agf014eb_pr_persona0.rbf: not applicable
- agilex7_dk_si_agf014eb_pr_persona1.rbf: not applicable

In our case we just copy the core.ghrd file in the Yocto recipe location:


```bash
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agf014eb_gsrd_ghrd.core.rbf
ln -s $TOP_FOLDER/ghrd.core.rbf $CORE_RBF
```


2\. In the Yocto recipe `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb` modify the agilex_gsrd_code file location:

```bash
SRC_URI:agilex7_dk_si_agf014eb ?= "\
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_gsrd_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_nand_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_nand_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_pr_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_persona0.rbf;name=agilex7_dk_si_agf014eb_pr_persona0 \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_persona1.rbf;name=agilex7_dk_si_agf014eb_pr_persona1 \
 "
```

to look like this:

```bash
SRC_URI:agilex7_dk_si_agf014eb ?= "\
 file://agilex7_dk_si_agf014eb_gsrd_ghrd.core.rbf;sha256sum=xxxxxxxxx \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_nand_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_nand_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_pr_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_persona0.rbf;name=agilex7_dk_si_agf014eb_pr_persona0 \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_persona1.rbf;name=agilex7_dk_si_agf014eb_pr_persona1 \
 "
```

using the following commands:


```bash
OLD_URI="\${GHRD_REPO}\/agilex7_dk_si_agf014eb_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_gsrd_core"
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ")
NEW_URI="file:\/\/agilex7_dk_si_agf014eb_gsrd_ghrd.core.rbf;sha256sum=$CORE_SHA"
sed -i "s/$OLD_URI/$NEW_URI/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
```


3\. In the same Yocto recipe delete the old SHA256 checksum for the file:

```bash
SRC_URI[agilex7_dk_si_agf014eb_gsrd_core.sha256sum] = "5d633ee561d5cc8c22b51211a144654fdc0be47ee14b07ac134074cbff84eb8b"
```

by using the following commands:


```bash
sed -i "/agilex7_dk_si_agf014eb_gsrd_core\.sha256sum/d" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
```


4\. Optionally change the following files in `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/u-boot/files/`:

- [uboot.txt](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/walnascar/recipes-bsp/u-boot/files/uboot.txt) - distroboot script
- [uboot_script.its](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/walnascar/recipes-bsp/u-boot/files/uboot_script.its) - its file for creating FIT image from the above script

5\. Optionally change the following file in `$WORKSPACE/meta-intel-fpga-refdes/recipes-kernel/linux/linux-socfpga-lts`:

- fit_kernel_agilex7_dk_si_agf014eb.its

 \- its file for creating the kernel.itb image, containing by default:

 - Kernel
 - Device trees for SD, NAND and PR board configurations
 - Core RBF files for SD, NAND and PR board configurations
 - Board configurations for SD, NAND and PR cases

#### Build Yocto

Build Yocto:


```bash
bitbake_image
```


Gather files:


```bash
package
```


Once the build is completed successfully, you will see the following two folders are created:

- `agilex7_dk_si_agf014eb-gsrd-rootfs`: area used by OpenEmbedded build system for builds. Description of build directory structure - https://docs.yoctoproject.org/ref-manual/structure.html#the-build-directory-build
- `agilex7_dk_si_agf014eb-gsrd-images`: the build script copies here relevant files built by Yocto from the `agilex7_dk_si_agf014eb-gsrd-rootfs/tmp/deploy/images/agilex` folder, but also other relevant files.

The two most relevant files created in the `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images` folder are:

| File | Description |
| :-- | :-- |
| sdimage.tar.gz | SD Card Image |
| u-boot-agilex-socdk-gsrd-atf/u-boot-spl-dtb.hex | U-Boot SPL Hex file |


#### Create QSPI Image


The QSPI image will contain the FPGA configuration data and the HPS FSBL and it can be built using the following command:


```bash
cd $TOP_FOLDER
rm -f *jic* *rbf*
quartus_pfg -c $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_baseline_hps_debug.sof \
 ghrd.jic \
 -o hps_path=gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \
 -o device=MT25QU02G \
 -o flash_loader=AGFB014R24B2E2V \
 -o mode=ASX4 \
 -o hps=1
```


The following files will be created:

- $TOP_FOLDER/ghrd.hps.jic - Flash image for HPS First configuration bitstream, phase 1: HPS and DDR
- $TOP_FOLDER/ghrd.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric, discarded, as we already have it on the SD card


### Boot from QSPI


This section presents how to boot from QSPI.

Much of the same binaries as when booting from SD card can be used to boot from QSPI, because:

- The QSPI resides on the DevKit board, and not on the HPS daughtercard, so there are no board changes:
 - The same GHRD configuration can be used
 - The same U-Boot devce tree can be used
 - The same Linux device tree can be used
- U-Boot uses distroboot, which will try first booting from SD/MMC, then from QSPI, then from NAND, so the same U-Boot can be used.

As the QSPI has a much smaller size than the SD card (256MB vs 2GB) the rootfs is smaller, and less functionality is provided. The purpose of this section is just to show Linux booting.

**Note**: The HPS speed for accessing SDM QSPI is limited to ~8MB/s. It is up to you to decide whether this level of performance is sufficient for your application. If not, it is recommended you use an SD card or eMMC device to store the HPS components such as the rootfs. Note that the QSPI speed limitation does not apply when SDM accesses the QSPI, it is just for HPS accessing SDM QSPI.

#### QSPI Flash Layout

| MTD Partition | UBI Volume | Volume Name | Type | Image/Individual File | Group File | Size |
| :-- | :-- | :-- | :-- | :-- | :-- | -- |
| 0 (qspi_uboot) | N/A<br>N/A | N/A<br>N/A | RAW<br>RAW | bitstream (FPGA image, SDM firmware)<br>u-boot.itb | N/A<br>N/A | 64MB<br>2MB |
| 1 (qspi_root) | 0<br>1<br>2<br>3<br>4 | env<br>script<br>kernel<br>dtb<br>rootfs | UBI<br>UBI<br>UBI<br>UBI<br>UBIFS | u-boot.env<br>u-boot.scr<br>kernel.itb<br>kernel.dtb<br>rootfs.ubifs | <br><br>root.ubi | 256KB<br>128KB<br>24MB<br>256KB<br>160MB |


#### Create QSPI Image

1\. Create a folder to contain all the qspi binaries, and create symlinks to actual location for all files:


```bash
cd $TOP_FOLDER
rm -rf qspi-boot && mkdir qspi-boot && cd qspi-boot
ln -s $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_baseline.sof fpga.sof
ln -s $TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex spl.hex
ln -s $TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/boot.scr.uimg .
ln -s $TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/kernel.itb .
ln -s $TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/console-image-minimal-agilex7_nor.ubifs rootfs.ubifs
```


2\. Create U-Boot image:


```bash
cd $TOP_FOLDER/qspi-boot
cp $TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot.itb u-boot.bin
```


3\. Create hps.ubi file:


```bash
cd $TOP_FOLDER/qspi-boot
cat <<EOT >ubinize.cfg
[env]
mode=ubi
vol_id=0
vol_name=env
vol_size=256KiB
vol_type=dynamic

[script]
mode=ubi
image=boot.scr.uimg
vol_id=1
vol_name=script
vol_size=128KiB
vol_type=dynamic

[kernel]
mode=ubi
image=kernel.itb
vol_id=2
vol_name=kernel
vol_size=24MiB
vol_type=dynamic

[dtb]
mode=ubi
vol_id=3
vol_name=dtb
vol_size=256KiB
vol_type=dynamic

[rootfs]
mode=ubi
image=rootfs.ubifs
vol_id=4
vol_name=rootfs
vol_type=dynamic
vol_size=160MiB
vol_flag=autoresize
EOT
ubinize -o root.ubi -p 65536 -m 1 -s 1 ubinize.cfg
ln -s root.ubi hps.bin
```


4\. Create the QSPI image using the provided Quartus Programming File Generator (PFG) file:


```bash
cd $TOP_FOLDER/qspi-boot
wget https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-7/f-series/soc/gsrd/collateral/agilex7f_gsrd.pfg
quartus_pfg -c agilex7f_gsrd.pfg
```


#### Create PFG File

This section presents how to manually re-create the Programming File Generator file provided at [https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-7/f-series/soc/gsrd/collateral/agilex7f_gsrd.pfg](https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-7/f-series/soc/gsrd/collateral/agilex7f_gsrd.pfg)

1\. Start Quartus Programming File Generator GUI:

```bash
cd $TOP_FOLDER/qspi-boot
qpfgw &
```

2\. In PFG **Output Files** tab:

- Select **Device Family** as "Agillex"
- Select **Configuration Mode** as "Active Serial x4"
- Edit **Name** as "flash_image"
- Check **JTAG Indirect Configuration File (.jic)**
- Check **Memory Map File (.map)**

![](images/agilex-qspi-boot-pfg-output-files.png)

3\. In PFG **Input Files** tab:

- Click **Add Bitstream", then browse to "fpga.sof" link, and add click \*Open** to add it.
- Click **Bitstream_1>fpga.sof** then click **Properties** the click **HPS Bootloader**, browse to "spl.hex" then click **Open** to add it.
 Note: By the time the fpga.sof file is read the following error is displayed, this was addressed by adding the spl.hex file to the Bitstream: File fpga.sof is incomplete- HPS is present but bootloader information is missing.
- Click **Add Raw Data** then change the extension filter to **.bin** then browse to "u-boot.bin" and click **Open** to add it.
- Click on the "u-boot.bin" then click "*Prpperties*" then select **Bit swap** option to "On"
- Repeat the above 2 steps for the following files:
 - hps.bin

The **Input Files** tab will now look something like this:

![](images/agilex-qspi-boot-pfg-input-files.png)

4\. In the PFG **Configuration Device** tab:

- Click **Add Device**, select the Micron MT25QU02G device then click **Add**
- Click the **MT25QU02G** device, then click **Add Partition**, select the options as following then click **OK**:

![](images/agilex-qspi-boot-add-bitstream-partition.png)

- Click the **MT25QU02G** device, then click **Add Partition**, select the options as following then click **OK**:

![](images/agilex-qspi-boot-add-u-boot-partition.png) ting

- Repeat the above step for the rest of binary files, choosing the following offsets:
 - hps: 0x04200000
- Click **Flash Loader** > **Select** then browse to the device used on the devkit then click **OK**:

![](images/agilex-qspi-boot-pfg-flash-loader.png)

The **Configuration Device** tab will now look something like this:

![](images/agilex-qspi-boot-pfg-configuration-device.png)

5\. Go to **File** > **Save As** and save the configuration file as "flash_image_qspi.pfg".

6\. [Optional] Open the file "flash_image_qspi.pfg" with a text editor and change absolute paths to relative paths.

The file will look like this:

```xml
<pfg version="1">
    <settings custom_db_dir="./" mode="ASX4"/>
    <output_files>
        <output_file name="flash_image" hps="1" directory="./" type="PERIPH_JIC">
            <file_options/>
            <secondary_file type="MAP" name="flash_image_jic">
                <file_options/>
            </secondary_file>
            <flash_device_id>Flash_Device_1</flash_device_id>
        </output_file>
    </output_files>
    <bitstreams>
        <bitstream id="Bitstream_1">
            <path signing="OFF" finalize_encryption="0" hps_path="spl.hex">fpga.sof</path>
        </bitstream>
    </bitstreams>
    <raw_files>
        <raw_file bitswap="1" type="RBF" id="Raw_File_1">u-boot.bin</raw_file>
        <raw_file bitswap="1" type="RBF" id="Raw_File_2">hps.bin</raw_file>
    </raw_files>
    <flash_devices>
        <flash_device type="MT25QU02G" id="Flash_Device_1">
            <partition reserved="1" fixed_s_addr="1" s_addr="0x00000000" e_addr="0x001FFFFF" fixed_e_addr="1" id="BOOT_INFO" size="0"/>
            <partition reserved="0" fixed_s_addr="0" s_addr="auto" e_addr="auto" fixed_e_addr="0" id="P1" size="0"/>
            <partition reserved="0" fixed_s_addr="0" s_addr="0x04000000" e_addr="auto" fixed_e_addr="0" id="u-boot" size="0"/>
            <partition reserved="0" fixed_s_addr="0" s_addr="0x04200000" e_addr="auto" fixed_e_addr="0" id="hps" size="0"/>
        </flash_device>
        <flash_loader>AGFB014R24B</flash_loader>
    </flash_devices>
    <assignments>
        <assignment page="0" partition_id="P1">
            <bitstream_id>Bitstream_1</bitstream_id>
        </assignment>
        <assignment partition_id="u-boot">
            <raw_file_id>Raw_File_1</raw_file_id>
        </assignment>
        <assignment page="0" partition_id="hps">
            <raw_file_id>Raw_File_2</raw_file_id>
        </assignment>
    </assignments>
</pfg>
```





### Boot From NAND



This section presents how to boot from NAND, including how to build all binaries.

Build instructions are the same as for standard SD or QSPI boot. The U-Boot, ATF and Linux binaries are all the same. The only difference is that the GHRD is configured for the NAND HPS Daughtercard, then recompiled.

**Note**: As the NAND used on the devkit has a smaller size than the SD card (1GB vs 2GB) the rootfs is smaller, and less functionality is provided. The purpose of this section is just to show Linux booting.

#### NAND Flash Layout

| MTD Partition | UBI Volume | Volume Name | Type         | Image/File | Flash Offset | Size               | Size in Hex |         |
| :------------ | :--------- | :---------- | :----------- | :--------- | :----------- | :----------------- | :---------- | ------- |
| 0 (u-boot)    | N/A        | N/A         | RAW          | u-boot.itb | 0x00000000   | 2MB                | 0x00200000  |         |
| 1 (root)      | 0          | env         | UBI          | u-boot.env | root.ubi     | 0x00200000 onwards | 256KB       | 0x40000 |
| 1             | script     | UBI         | u-boot.scr   | 128KB      | 0x00020000   |                    |             |         |
| 2             | kernel     | UBI         | kernel.itb   | 64MB       | 0x04000000   |                    |             |         |
| 3             | dtb        | UBI         | kernel.dtb   | 256KB      | 0x00040000   |                    |             |         |
| 4             | rootfs     | UBIFS       | rootfs.ubifs | <957MB     | <0x3BD70000  |                    |             |         |

#### Set up Environment



Create a top folder for this example, as the rest of the commands assume this location:



```bash
sudo rm -rf agilex7f_gsrd.nand
mkdir agilex7f_gsrd.nand
cd agilex7f_gsrd.nand
export TOP_FOLDER=$(pwd)
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





#### Build Hardware Design



Use the following commands to build the hardware design:



```bash
cd $TOP_FOLDER
rm -rf agilex7f-ed-gsrd
wget https://github.com/altera-fpga/agilex7f-ed-gsrd/archive/refs/tags/QPDS25.3_REL_GSRD_PR.zip
unzip QPDS25.3_REL_GSRD_PR.zip
rm QPDS25.3_REL_GSRD_PR.zip
mv agilex7f-ed-gsrd-QPDS25.3_REL_GSRD_PR agilex7f-ed-gsrd
cd agilex7f-ed-gsrd
make agf014eb-si-devkit-nand-baseline-all
```



The following files are created:

- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_nand_baseline.sof` - FPGA configuration file, without HPS FSBL
- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_nand_baseline_hps_debug.sof` - FPGA configuration file, with HPS Debug FSBL



#### Build Core RBF



Create the Core RBF file to be used in the rootfs created by Yocto by using the HPS Debug SOF built by the GHRD makefile:



```bash
cd $TOP_FOLDER
rm -f *jic* *rbf*
quartus_pfg -c $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_nand_baseline_hps_debug.sof \
 ghrd.jic \
 -o device=MT25QU02G \
 -o flash_loader=AGFB014R24B2E2V \
 -o mode=ASX4 \
 -o hps=1
rm ghrd.hps.jic
```



The following files will be created:

- `$TOP_FOLDER/ghrd.core.rbf` - HPS First configuration bitstream, phase 2: FPGA fabric

Note we are also creating an HPS JIC file, but we are discarding it, as it has the HPS Debug FSBL, while the final image needs to have the U-Boot SPL created by the Yocto recipes.




#### Set Up Yocto

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

2\. Clone the Yocto script and prepare the build:



```bash
cd $TOP_FOLDER
rm -rf gsrd-socfpga
git clone -b QPDS25.3_REL_GSRD_PR https://github.com/altera-fpga/gsrd-socfpga
cd gsrd-socfpga
. agilex7_dk_si_agf014eb-gsrd-build.sh
build_setup
```



**Note**: Run the following commands to set up again the yocto build environments, if you closed the current window (for example when rebooting the Linux host) and want to resume the next steps:

```bash
cd $TOP_FOLDER/gsrd-socfpga
. ./poky/oe-init-build-env agilex-gsrd-rootfs/
```

#### Customize Yocto

1\. Copy the rebuilt files to `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files` using the following names, as expected by the yocto recipes:

- agilex7_dk_si_agf014eb_gsrd_ghrd.core.rbf: not applicable
- agilex7_dk_si_agf014eb_nand_ghrd.core.rbf
- agilex7_dk_si_agf014eb_pr_ghrd.core.rbf: not applicable
- agilex7_dk_si_agf014eb_pr_persona0.rbf: not applicable
- agilex7_dk_si_agf014eb_pr_persona1.rbf: not applicable

In our case we just copy the core.ghrd file in the Yocto recipe location:



```bash
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agf014eb_nand_ghrd.core.rbf
ln -s $TOP_FOLDER/ghrd.core.rbf $CORE_RBF
```



2\. In the Yocto recipe `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb` modify the agilex_gsrd_code file location:

```bash
SRC_URI:agilex7_dk_si_agf014eb ?= "\
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_gsrd_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_nand_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_nand_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_pr_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_persona0.rbf;name=agilex7_dk_si_agf014eb_pr_persona0 \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_persona1.rbf;name=agilex7_dk_si_agf014eb_pr_persona1 \
 "
```

to look like this:

```bash
SRC_URI:agilex7_dk_si_agf014eb ?= "\
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_gsrd_core \
 file://agilex7_dk_si_agf014eb_nand_ghrd.core.rbf;sha256sum=xxxxxxxxxxxxx \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_pr_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_persona0.rbf;name=agilex7_dk_si_agf014eb_pr_persona0 \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_persona1.rbf;name=agilex7_dk_si_agf014eb_pr_persona1 \
 "
```

using the following commands:



```bash
OLD_URI="\${GHRD_REPO}\/agilex7_dk_si_agf014eb_nand_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_nand_core"
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ")
NEW_URI="file:\/\/agilex7_dk_si_agf014eb_nand_ghrd.core.rbf;sha256sum=$CORE_SHA"
sed -i "s/$OLD_URI/$NEW_URI/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
```



3\. In the same Yocto recipe delete the old SHA256 checksum for the file:

```bash
SRC_URI[agilex7_dk_si_agf014eb_nand_core.sha256sum] = "f7a9a7f60f6c1c1c0197292573c844be625d9cd3e96c1c1105e1a6057aad699c"
```

by using the following command:



```bash
sed -i "/agilex7_dk_si_agf014eb_nand_core\.sha256sum/d" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
```



4\. Optionally change the following files in `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/u-boot/files/`:

- [uboot.txt](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/walnascar/recipes-bsp/u-boot/files/uboot.txt) - distroboot script
- [uboot_script.its](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/walnascar/recipes-bsp/u-boot/files/uboot_script.its) - its file for creating FIT image from the above script

5\. Optionally change the following file in `$WORKSPACE/meta-intel-fpga-refdes/recipes-kernel/linux/linux-socfpga-lts`:

- fit_kernel_agilex7_dk_si_agf014eb.its

 \- its file for creating the kernel.itb image, containing by default:

 - Kernel
 - Device trees for SD, NAND and PR board configurations
 - Core RBF files for SD, NAND and PR board configurations
 - Board configurations for SD, NAND and PR cases


#### Build Yocto

Build Yocto:



```bash
bitbake_image
```



Gather files:



```bash
package
```



Once the build is completed successfully, you will see the following two folders are created:

- `agilex7_dk_si_agf014eb-gsrd-rootfs`: area used by OpenEmbedded build system for builds. Description of build directory structure - https://docs.yoctoproject.org/ref-manual/structure.html#the-build-directory-build
- `agilex7_dk_si_agf014eb-gsrd-images`: the build script copies here relevant files built by Yocto from the `agilex7_dk_si_agf014eb-gsrd-rootfs/tmp/deploy/images/agilex` folder, but also other relevant files.

The two most relevant files created in the `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images` folder are:

| File                                            | Description              |
| :---------------------------------------------- | :----------------------- |
| gsrd-console-image-agilex7_nand.ubifs           | UBI root partition image |
| u-boot-agilex7-socdk-gsrd-atf/u-boot.itb         | U-Boot FIT image         |
| u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex | U-Boot SPL Hex file      |



#### Create QSPI Image



The QSPI image will contain the FPGA configuration data and the HPS FSBL and it can be built using the following command:



```bash
cd $TOP_FOLDER
rm -f *jic* *rbf*
quartus_pfg -c $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_nand_baseline.sof \
 ghrd.jic \
 -o hps_path=gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \
 -o device=MT25QU02G \
 -o flash_loader=AGFB014R24B2E2V \
 -o mode=ASX4 \
 -o hps=1
```



The following files will be created:

- `$TOP_FOLDER/ghrd.hps.jic` - Flash image for HPS First configuration bitstream, phase 1: HPS and DDR
- `$TOP_FOLDER/ghrd.core.rbf` - HPS First configuration bitstream, phase 2: FPGA fabric, discarded, as we already have it on the SD card



#### Build NAND Binaries



1\. Gather the files into a single folder, using symlinks:



```bash
cd $TOP_FOLDER
rm -rf nand-bin && mkdir nand-bin && cd nand-bin
ln -s $TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/boot.scr.uimg .
ln -s $TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/kernel.itb .
ln -s $TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/gsrd-console-image-agilex7_nand.ubifs rootfs.ubifs
ln -s $TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/socfpga_agilex7_socdk_nand.dtb .
```



2\. Install `mtd-tools` if not already installed. On Ubuntu the command is:

```bash
sudo apt-get install mtd-tools
```

3\. Create UBI configuration file for the root partition:



```bash
cat <<EOT >ubinize.cfg
[env]
mode=ubi
vol_id=0
vol_name=env
vol_size=256KiB
vol_type=dynamic

[script]
mode=ubi
image=boot.scr.uimg
vol_id=1
vol_name=script
vol_size=128KiB
vol_type=dynamic

[kernel]
mode=ubi
image=kernel.itb
vol_id=2
vol_name=kernel
vol_size=64MiB
vol_type=dynamic

[dtb]
mode=ubi
image=socfpga_agilex7_socdk_nand.dtb
vol_id=3
vol_name=dtb
vol_size=256KiB
vol_type=dynamic

[rootfs]
mode=ubi
image=rootfs.ubifs
vol_id=4
vol_name=rootfs
vol_type=dynamic
vol_size=400MiB
vol_flag=autoresize
EOT
```



4\. Create the `root.ubi` file:



```bash
ubinize -o root.ubi -p 128KiB -m 2048 -s 2048 ubinize.cfg
```



This is what the above parameters mean:

- -p: physical eraseblock size of the flash
- -m: minimum input/output unit size of the flash
- -s: sub-pages and sub-page size, ubinize will take into account and put the VID header to same NAND page as the EC header

The following file is created:

- $TOP_FOLDER/nand-bin/root.ubi





### Partial Reconfiguration



Partial reconfiguration (PR) allows you to reconfigure a portion of the FPGA dynamically, while the rest of the FPGA design continues to function.

This section shows how to build everything needed to demonstrate the PR scenarios. Note that most of the binaries are the same as for the other boot scenarios (SD card, QSPI, NAND) just the following files are changed:

- New GHRD variant, creating different configuration bitstreams
- Updated core.rbf, persona0.rbf, persona1.rbf compared to prebuilt default files used by the Yocto recipes

#### Set up Environment



Create a top folder for this example, as the rest of the commands assume this location:



```bash
sudo rm -rf agilex7f_gsrd.pr
mkdir agilex7f_gsrd.pr
cd agilex7f_gsrd.pr
export TOP_FOLDER=$(pwd)
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





#### Build Hardware Design



Use the following commands to build the hardware design:



```bash
cd $TOP_FOLDER
rm -rf agilex7f-ed-gsrd
wget https://github.com/altera-fpga/agilex7f-ed-gsrd/archive/refs/tags/QPDS25.3_REL_GSRD_PR.zip
unzip QPDS25.3_REL_GSRD_PR.zip
rm QPDS25.3_REL_GSRD_PR.zip
mv agilex7f-ed-gsrd-QPDS25.3_REL_GSRD_PR agilex7f-ed-gsrd
cd agilex7f-ed-gsrd
make agf014eb-si-devkit-oobe-pr-all
```



The following files are created:

- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_pr_hps_debug.sof` - FPGA configuration file, with HPS Debug FSBL
- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_pr.sof`- FPGA configuration file, without HPS FSBL
- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_pr_persona1.rbf` - persona 1 PR bitstream
- `$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_pr_persona0.rbf` - persona 0 PR bitstream



#### Build Core RBF



Create the Core RBF file to be used in the rootfs created by Yocto by using the HPS Debug SOF built by the GHRD makefile:



```bash
cd $TOP_FOLDER
rm -f *jic* *rbf*
quartus_pfg -c "$TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_pr_hps_debug.sof" \
 ghrd.jic \
 -o device=MT25QU02G \
 -o flash_loader=AGFB014R24B2E2V \
 -o mode=ASX4 \
 -o hps=1
rm ghrd.hps.jic
```



The following files will be created:

- $TOP_FOLDER/ghrd_agfb014r24b2e2v.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric

Note we are also creating an HPS JIC file, but we are discarding it, as it has the HPS Debug FSBL, while the final image needs to have the U-Boot SPL created by the Yocto recipes.





#### Set Up Yocto

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

2\. Clone the Yocto script and prepare the build:


```bash
cd $TOP_FOLDER
rm -rf gsrd-socfpga
git clone -b QPDS25.3_REL_GSRD_PR https://github.com/altera-fpga/gsrd-socfpga
cd gsrd-socfpga
. agilex7_dk_si_agf014eb-gsrd-build.sh
build_setup
```


**Note**: Run the following commands to set up again the yocto build environments, if you closed the current window (for example when rebooting the Linux host) and want to resume the next steps:

```bash
cd $TOP_FOLDER/gsrd-socfpga
. ./poky/oe-init-build-env agilex-gsrd-rootfs/
```

#### Customize Yocto

1\. Copy the rebuilt files to `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files` using the following names, as expected by the yocto recipes:

- agilex7_dk_si_agf014eb_gsrd_ghrd.core.rbf: not applicable
- agilex7_dk_si_agf014eb_nand_ghrd.core.rbf: not applicable
- agilex7_dk_si_agf014eb_pr_ghrd.core.rbf
- agilex7_dk_si_agf014eb_pr_persona0.rbf
- agilex7_dk_si_agf014eb_pr_persona1.rbf

In our case we just copy the core.ghrd file in the Yocto recipe location:



```bash
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agf014eb_pr_ghrd.core.rbf
PER0_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agf014eb_pr_persona0.rbf
PER1_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agf014eb_pr_persona1.rbf
ln -s $TOP_FOLDER/ghrd.core.rbf $CORE_RBF
ln -s $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_pr_persona0.rbf $PER0_RBF
ln -s $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_pr_persona1.rbf $PER1_RBF
```



2\. In the Yocto recipe `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb` modify the agilex_gsrd_code file location:

```bash
SRC_URI:agilex7_dk_si_agf014eb ?= "\
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_gsrd_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_nand_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_nand_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_pr_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_persona0.rbf;name=agilex7_dk_si_agf014eb_pr_persona0 \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_pr_persona1.rbf;name=agilex7_dk_si_agf014eb_pr_persona1 \
 "
```

to look like this:

```bash
SRC_URI:agilex7_dk_si_agf014eb ?= "\
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_gsrd_core \
 ${GHRD_REPO}/agilex7_dk_si_agf014eb_nand_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_nand_core \
 file://agilex7_dk_si_agf014eb_pr_ghrd.core.rbf;sha256sum=xxxxxxxxxxx \
 file://agilex7_dk_si_agf014eb_pr_persona0.rbf;sha256sum=xxxxxxxxxxx \
 file://agilex7_dk_si_agf014eb_pr_persona1.rbf;sha256sum=xxxxxxxxxxx
 "
```

using the following commands:



```bash
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ")
PER0_SHA=$(sha256sum $PER0_RBF | cut -f1 -d" ")
PER1_SHA=$(sha256sum $PER1_RBF | cut -f1 -d" ")
OLD_CORE_URI="\${GHRD_REPO}\/agilex7_dk_si_agf014eb_pr_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agf014eb_pr_core"
NEW_CORE_URI="file:\/\/agilex7_dk_si_agf014eb_pr_ghrd.core.rbf;sha256sum=$CORE_SHA"
OLD_PER0_URI="\${GHRD_REPO}\/agilex7_dk_si_agf014eb_pr_persona0.rbf;name=agilex7_dk_si_agf014eb_pr_persona0"
NEW_PER0_URI="file:\/\/agilex7_dk_si_agf014eb_pr_persona0.rbf;sha256sum=$PER0_SHA"
OLD_PER1_URI="\${GHRD_REPO}\/agilex7_dk_si_agf014eb_pr_persona1.rbf;name=agilex7_dk_si_agf014eb_pr_persona1"
NEW_PER1_URI="file:\/\/agilex7_dk_si_agf014eb_pr_persona1.rbf;sha256sum=$PER1_SHA"
RECIPE=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb
sed -i "s/$OLD_CORE_URI/$NEW_CORE_URI/g" $RECIPE
sed -i "s/$OLD_PER0_URI/$NEW_PER0_URI/g" $RECIPE
sed -i "s/$OLD_PER1_URI/$NEW_PER1_URI/g" $RECIPE
```



3\. In the same Yocto recipe delete the old SHA256 checksum for the files:

```bash
SRC_URI[name=agilex7_dk_si_agf014eb_pr_core.sha256sum] = "69245470a36274f1f002cb275748664902d9262f577cae4bba92813cb48fdeaf"
SRC_URI[agilex7_dk_si_agf014eb_pr_persona0.sha256sum] = "6556cc83a8e8a38fb1e52945d91bd651466e9553f8e60c04df5e71ee36dc45f2"
SRC_URI[agilex7_dk_si_agf014eb_pr_persona1.sha256sum] = "8a0cdcb38aead468a62eb0cba68af05a4e242bd79a617f49176647d766b70b28"
```

by using the following commands:



```bash
sed -i '/agilex7_dk_si_agf014eb_pr_core\.sha256sum/d' $RECIPE
sed -i '/agilex7_dk_si_agf014eb_pr_persona0\.sha256sum/d' $RECIPE
sed -i '/agilex7_dk_si_agf014eb_pr_persona1\.sha256sum/d' $RECIPE
```



4\. Optionally change the following files in `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/u-boot/files/`:

- [uboot.txt](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/walnascar/recipes-bsp/u-boot/files/uboot.txt) - distroboot script
- [uboot_script.its](https://github.com/altera-fpga/meta-intel-fpga-refdes/blob/walnascar/recipes-bsp/u-boot/files/uboot_script.its) - its file for creating FIT image from the above script

5\. Optionally change the following file in `$WORKSPACE/meta-intel-fpga-refdes/recipes-kernel/linux/linux-socfpga-lts`:

- fit_kernel_agilex7_dk_si_agf014eb.its

 \- its file for creating the kernel.itb image, containing by default:

 - Kernel
 - Device trees for SD, NAND and PR board configurations
 - Core RBF files for SD, NAND and PR board configurations
 - Board configurations for SD, NAND and PR cases

#### Build Yocto


Build Yocto:



```bash
bitbake_image
```



Gather files:



```bash
package
```



Once the build is completed successfully, you will see the following two folders are created:

- `agilex7_dk_si_agf014eb-gsrd-rootfs`: area used by OpenEmbedded build system for builds. Description of build directory structure - https://docs.yoctoproject.org/ref-manual/structure.html#the-build-directory-build
- `agilex7_dk_si_agf014eb-gsrd-images`: the build script copies here relevant files built by Yocto from the `agilex7_dk_si_agf014eb-gsrd-rootfs/tmp/deploy/images/agilex` folder, but also other relevant files.

The two most relevant files created in the `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images` folder are:

| File                                            | Description         |
| :---------------------------------------------- | :------------------ |
| sdimage.tar.gz                                  | SD Card Image       |
| u-boot-agilex-socdk-gsrd-atf/u-boot-spl-dtb.hex | U-Boot SPL Hex file |



#### Create QSPI Image



The QSPI image will contain the FPGA configuration data and the HPS FSBL and it can be built using the following command:



```bash
cd $TOP_FOLDER
rm -f *jic* *rbf*
quartus_pfg -c $TOP_FOLDER/agilex7f-ed-gsrd/install/designs/agf014eb_si_devkit_oobe_pr.sof \
 ghrd.jic \
 -o hps_path=gsrd-socfpga/agilex7_dk_si_agf014eb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \
 -o device=MT25QU02G \
 -o flash_loader=AGFB014R24B2E2V \
 -o mode=ASX4 \
 -o hps=1
```



The following files will be created:

- $TOP_FOLDER/ghrd.hps.jic - Flash image for HPS First configuration bitstream, phase 1: HPS and DDR
- $TOP_FOLDER/ghrd.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric, discarded, as we already have it on the SD card




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
   
2. Go to the folder in which the **kernel.itb** is being created under the GSRD.
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