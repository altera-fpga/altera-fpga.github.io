## Overview 
 
This page presents the Golden System Reference Design for the [Intel® Agilex™ I-Series Transceiver-SoC Development Kit (4x F-Tile)](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/si-agi027.html). The GSRD demonstrates the following: 
 
- FPGA side 
  - LEDs connected to GPIO soft IP modules 
  - DIP switches and push buttons connected to GPIO soft IP modules 
- HPS side 
  - Linux, booted by U-Boot and ATF 
  - Board web server 
  - Sample driver 
  - Reacting to FPGA DIP switches and push buttons 
  - Sample applications 
  - Hello world 
  - Controlling FPGA LEDs: blink, scroll, toggle 
  - System check application 
 
### Prerequisites 
 
The following are required in order to be able to fully exercise the GSRD:

- Intel&reg; Agilex&trade; I-Series Transceiver-SoC Development Kit (4x F-Tile).
  - SD/MMC HPS Daughtercard 
  - Mini USB cable for serial output 
  - USB Type B cable for on-board Intel FPGA Download Cable II 
  - Micro SD card (4GB or greater)  
- Host PC with:
  - Linux - Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too 
  - Serial terminal (for example Minicom on Linux and TeraTerm or PuTTY on Windows) 
  - Micro SD card slot or Micro SD card writer/reader 
  - Intel Quartus Prime Pro Edition 
  - Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 24.3.1 
- Local Ethernet network, with DHCP server (will be used to provide IP address to the board) 
 
You can identify your board by reviewing the the table in [Intel Agilex™ I-Series Transceiver-SoC Development Kit User Guide](https://www.intel.com/content/www/us/en/docs/programmable/721605/current/overview.html): 
 
| Development Kit Version | Ordering Code | Device Part Number | Serial Number Identifier | Suppported by GSRD |
| :-- | :-- | :-- | :-- | :-- | 
| Intel Agilex™ 7 FPGA I-Series Transceiver-SoC Development Kit (Production 1 4x F-Tile) | DK-SI-AGI027FA (Power Solution 2) | AGIB027R31B1E1V | 2000001 | Yes 
| Intel Agilex™ 7 FPGA I-Series Transceiver-SoC Development Kit (Production 2) | DK-SI-AGI027FC (Power Solution 2) | AGIB027R31B1E1VB | 3000001 | Yes |
| Intel Agilex™ 7 FPGA I-Series Transceiver-SoC Development Kit (ES1 4x F-Tile) | DK-SI-AGI027FB (Power Solution 1) | AGIB027R31B1E1VAA | 0001001 | Yes |
| Intel Agilex™ 7 FPGA I-Series Transceiver-SoC Development Kit (ES) | DK-SI-AGI027FES (Power Solution 1) | AGIB027R31B1E2VR0 | 0000001 | No | 
   
The U-Boot and Linux compilation, Yocto compilation and creating the SD card image require a Linux host PC. The rest of the operations can be performed on either a Windows or Linux host PC. 
 
### Release Notes 
 
The Intel FPGA HPS Embedded Software release notes can be accessed from the following link: [https://github.com/altera-opensource/gsrd-socfpga/releases/tag/QPDS24.3.1_REL_GSRD_PR](https://github.com/altera-opensource/gsrd-socfpga/releases/tag/QPDS24.3.1_REL_GSRD_PR)
 
### Binaries

| Board | Binaries |
| :-- | :-- | 
| AGI027FB | [https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fb_gsrd/](https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fb_gsrd/) |
| AGI027FA | [https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fa_gsrd/](https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fa_gsrd/) |
| AGI027FC | [https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fc_gsrd/](https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fc_gsrd/) |
 
The source code is included on the SD card in the Linux rootfs path `/home/root`: 
 
| File | Description | 
| :-- | :-- | 
| linux-socfpga-v6.6.51-lts-src.tar.gz | Source code for Linux kernel | 
| u-boot-socfpga-v2024.07-src.tar.gz | Source code for U-Boot | 
| arm-trusted-firmware-v2.11.1-src.tar.gz | Source code for Arm Trusted Firmware | 
 
Before downloading the hardware design please read the agreement in the link [https://www.intel.com/content/www/us/en/programmable/downloads/software/license/lic-prog_lic.html ](https://www.intel.com/content/www/us/en/programmable/downloads/software/license/lic-prog_lic.html).
 
### Component Versions

Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 24.3.1 and the following software component versions are used to build the GSRD: 

| Component | Location | Branch | Commit ID/Tag |
| :-- | :-- | :-- | :-- |
| GHRD | [https://github.com/altera-opensource/ghrd-socfpga](https://github.com/altera-opensource/ghrd-socfpga) | master | QPDS24.3.1_REL_GSRD_PR |
| Linux | [https://github.com/altera-opensource/linux-socfpga](https://github.com/altera-opensource/linux-socfpga) | socfpga-6.6.51-lts | QPDS24.3.1_REL_GSRD_PR |
| Arm Trusted Firmware | [https://github.com/arm-trusted-firmware](https://github.com/arm-trusted-firmware) | socfpga_v2.11.1 | QPDS24.3.1_REL_GSRD_PR |
| U-Boot | [https://github.com/altera-opensource/u-boot-socfpga](https://github.com/altera-opensource/u-boot-socfpga) | socfpga_v2024.07 | QPDS24.3.1_REL_GSRD_PR |
| Yocto Project | [https://git.yoctoproject.org/poky](https://git.yoctoproject.org/poky) | styhead | latest | 
| Yocto Project: meta-intel-fpga | [https://git.yoctoproject.org/meta-intel-fpga](https://git.yoctoproject.org/meta-intel-fpga) | styhead | latest |
| Yocto Project: meta-intel-fpga-refdes | [https://github.com/altera-opensource/meta-intel-fpga-refdes](https://github.com/altera-opensource/meta-intel-fpga-refdes) | styhead | QPDS24.3.1_REL_GSRD_PR |

 
## Running the GSRD 
 
**Note:** The instructions provided here are using the prebuilt binaries, but the same procedure applies for the rebuilt binaries. 
 
### Boot Linux 
 
#### Configure Board 
 
![](images/fm87-devkit.jpg) 
 
Set up the board default settings, as listed by the the [Intel Agilex™ I-Series Transceiver-SoC Development Kit User Guide](https://www.intel.com/content/www/us/en/docs/programmable/721605/current/overview.html), "Default Settings" section: 
 
| Switch | Default Position | 
| :-- | :-- | 
| S19 [1:4] | OFF/OFF/ON/ON | 
| S20 [1:4] | ON/ON/ON/ON | 
| S9 [1:4] | ON/OFF/OFF/X | 
| S10 [1:4] | ON/ON/ON/ON | 
| S15 [1:4] | ON/ON/ON/OFF | 
| S1 [1:4] | OFF/OFF/OFF/OFF | 
| S6 [1:4] | OFF/OFF/OFF/OFF | 
| S22 [1:4] | ON/ON/ON/ON | 
| S23 [1:4] | ON/ ON / ON / ON | 
| S4 [1:4] | ON/ ON / ON / ON | 
 
#### Write SD Card 
 
This section explains how to create the SD card necessary to boot Linux, using the SD card image available with the pre-built Linux binaries package. Once the SD card has been created, insert the card into the SD slot of the Micro SD daughter card. 
 
<h5> Write SD Card on Linux </h5>
 
1\. Download the SD card image and extract it: 
 
For DK-SI-AGI027FB board: 
 
```bash 
wget https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fb_gsrd/sdimage.tar.gz 
tar xf sdimage.tar.gz 
``` 
 
For DK-SI-AGI027FA board: 
 
```bash 
wget https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fa_gsrd/sdimage.tar.gz 
tar xf sdimage.tar.gz 
``` 

For DK-SI-AGI027FC board: 
 
```bash 
wget https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fc_gsrd/sdimage.tar.gz 
tar xf sdimage.tar.gz 
``` 
 
The extracted file is named `gsrd-console-image-agilex.wic`. 
 
2\. Determine the device associated with the SD card on the host by running the following command before and after inserting the card. 
 
```bash 
$ cat /proc/partitions 
``` 
 
Let's assume it is /dev/sdx. 
 
3\. Use *dd* utility to write the SD image to the SD card. 
 
```bash 
$ sudo dd if=gsrd-console-image-agilex.wic of=/dev/sdx bs=1M 
``` 
 
Note we are using *sudo* to be able to write to the card. 
 
4\. Use *sync* utility to flush the changes to the SD card. 
 
```bash 
$ sudo sync 
``` 
 
<h5> Write SD Card on Windows </h5>
 
1\. Download the SD card and extract it: 
 
- For DK-SI-AGI027FB board: [https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fb_gsrd/sdimage.tar.gz](https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fb_gsrd/sdimage.tar.gz )
- For DK-SI-AGI027FA board: [https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fa_gsrd/sdimage.tar.gz](https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fa_gsrd/sdimage.tar.gz)
- For DK-SI-AGI027FC board: [https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fc_gsrd/sdimage.tar.gz](https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fc_gsrd/sdimage.tar.gz)
 
The extracted file is named `gsrd-console-image-agilex.wic`. 
 
2\. Rename the wic file as `sdcard.img` 
 
3\. Use Win32DiskImager to write the image to the SD card. The tool can be downloaded from [https://sourceforge.net/projects/win32diskimager/files/latest/download](https://sourceforge.net/projects/win32diskimager/files/latest/download)
 
![](images/win32diskimager.png)
 
#### Configure Serial Connection 
 
The OOBE Daughter Card has a built-in FTDI USB to Serial converter chip that allows the host computer to see the board as a virtual serial port. Ubuntu and other modern Linux distributions have built-in drivers for the FTDI USB to Serial converter chip, so no driver installation is necessary on those platforms. On Windows, you need to install thhe FTDI drivers from  [https://ftdichip.com/drivers/](https://ftdichip.com/drivers/) 
 
The serial communication parameters are: 
 
- Baud-rate: 115,200 
- Parity: none 
- Flow control: none 
- Stop bits: 1 
 
On Windows, utilities such as TeraTerm and PuTTY can be used to connect to the board. They are easily configured from the tool menus. 
 
On Linux, the minicom utility can be used. Here is how to configure it: 
 
1\. The virtual serial port is usually named /dev/ttyUSB0. In order to determine the device name associated with the virtual serial port on your host PC, please perform the following: 
 
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
 
#### Write JIC Image to QSPI
 
The QSPI JIC image contains the FPGA configuration bitstream, and the U-Boot SPL. 
 
1\. Download and extract the image file: 
 
For DK-SI-AGI027FB board: 
 
```bash 
wget https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fb_gsrd/ghrd_agib027r31b1e1vaa.jic.tar.gz 
tar xf ghrd_agib027r31b1e1vaa.jic.tar.gz 
``` 
 
For DK-SI-AGI027FA board: 
 
```bash 
wget https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fa_gsrd/ghrd_agib027r31b1e1v.jic.tar.gz 
tar xf ghrd_agib027r31b1e1v.jic.tar.gz 
``` 

For DK-SI-AGI027FC board: 
 
```bash 
wget https://releases.rocketboards.org/2025.01/gsrd/agilex7_dk_si_agi027fc_gsrd/ghrd_agib027r31b1e1vb.jic.tar.gz 
tar xf ghrd_agib027r31b1e1vb.jic.tar.gz 
``` 
 
2\. Configure MSEL to JTAG: 

| Switch | Setting |
| :-- | :-- | 
| S9 [1:4] | ON/ON/ON/X | 
 
3\. Power cycle the board 
 
4\. Connect the Type B USB cable from the development kit to the host for JTAG access. Write the image using the following commands: 
 
For DK-SI-AGI027FB board: 
 
```bash 
quartus_pgm -c 1 -m jtag -o "pvi;ghrd_agib027r31b1e1vaa.jic" 
``` 
 
For DK-SI-AGI027FA board: 
 
```bash 
quartus_pgm -c 1 -m jtag -o "pvi;ghrd_agib027r31b1e1v.jic" 
``` 

For DK-SI-AGI027FC board: 
 
```bash 
quartus_pgm -c 1 -m jtag -o "pvi;ghrd_agib027r31b1e1vb.jic" 
```
 
5\. Configure MSEL back to QSPI: 

| Switch | Setting |
| :-- | :-- | 
| S9 [1:4] | ON/OFF/OFF/X | 
 
#### Boot Linux 
 
1\. Make sure to have the SD card inserted in the board slot. 
 
2\. Start serial terminal (when using Minicom it will connect using the selected settings, for others connect manually). 
 
3\. Power up the board 
 
4\. The device will be configured from QSPI, HPS will be loaded with the U-Boot SPL, which will then load ATF and U-Boot proper, then Linux will be booted. Login using 'root' and no password. 
 
5\. Run 'ifconfig' command to determine the IP of the board: 
 
```bash 
root@agilexfm87:~# ifconfig 
eth0: flags=4163 mtu 1500 
 inet 192.168.1.172 netmask 255.255.255.0 broadcast 192.168.1.255 
 inet6 fe80::54c0:6cff:fe8e:fbac prefixlen 64 scopeid 0x20 
 ether 56:c0:6c:8e:fb:ac txqueuelen 1000 (Ethernet) 
 RX packets 100 bytes 7640 (7.4 KiB) 
 RX errors 0 dropped 0 overruns 0 frame 0 
 TX packets 52 bytes 7830 (7.6 KiB) 
 TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0 
 device interrupt 21 base 0x2000 
 
lo: flags=73 mtu 65536 
 inet 127.0.0.1 netmask 255.0.0.0 
 inet6 ::1 prefixlen 128 scopeid 0x10 
 loop txqueuelen 1000 (Local Loopback) 
 RX packets 100 bytes 8468 (8.2 KiB) 
 RX errors 0 dropped 0 overruns 0 frame 0 
 TX packets 100 bytes 8468 (8.2 KiB) 
 TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0 
``` 
 
### Running Sample Applications 
 
The GSRD includes a number of sample Linux applications that help demonstrate some of the features of the platform: 
 
- Display Hello World message 
- Control LEDs 
- Detect interrupts from push buttons and DIP switches 
 
The sample applications can be used as a starting point for users to write their own applications that interact with software IP through Linux drivers. 
 
#### Prerequisites 
 
1\. Boot Linux on the target board as described in [Boot Linux](#boot-linux). You will not need to use the serial terminal if you plan on using ssh connection. 
 
2\. Connect to the board using one of the following options: 
 
- Connect using serial console, as described in [Boot Linux](#boot-linux) 
- Connect using SSH
 
3\. In serial console, or ssh client console, change current folder to be */home/root/intelFPGA*. This is where the application binaries are stored. 
 
```bash 
root@agilexfm87:~# cd /home/root/intelFPGA/ 
``` 
 
#### Display Hello World Message 
 
Run the following command to display the Hello World message on the console: 
 
```bash 
root@agilexfm87:~/intelFPGA# ./hello 
Hello SoC FPGA!%ENDCOLOR 
``` 
 
#### Exercise Soft PIO Driver for LED Control 
 
The following green LEDs are exercised: 
 
- USER LED0 
- USER LED1 
- USER LED2 
- USER LED4 
 
Note: USER LED3 is always on, red colored, and cannot be controlled from software. 
 
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
 
#### Register Interrupts and Call Interrupt Service Routine 
 
The following are exercised: 
 
- User FPGA DIP switches 
 - USER_SW0 
 - USER_SW1 
 - USER_SW2 
 - USER_SW3 
- User FPGA push buttons 
 - USER_PB0 
 - USER_PB1 
 
In order to register an interrupt handler to a specific GPIO, you will first need to determine the GPIO number used. 
 
1\. Open the Linux Device Tree [socfpga_agilex7_ghrd.dtsi](https://raw.githubusercontent.com/altera-opensource/meta-intel-fpga-refdes/nanbield/recipes-bsp/device-tree/files/socfpga_agilex7_ghrd.dtsi) file and look up the labels for the DIP switches and Push button GPIOs: 
 
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
root@agilexfm87:~/intelFPGA# grep -r "gpio@f9001070" /sys/class/gpio/gpiochip*/label 
/sys/class/gpio/gpiochip1928/label:/soc/gpio@f9001070 
``` 
 
This means that the GPIOs 1928 .. 1931 are allocated to the DIP switches (there are 4 of them). 
 
3\. Run the followinig to determine the GPIO numbers for the pushbuttons 
 
```bash 
root@agilexfm87:~/intelFPGA# grep -r "gpio@f9001060" /sys/class/gpio/gpiochip*/label 
/sys/class/gpio/gpiochip1960/label:/soc/gpio@f9001060 
``` 
 
This means that the GPIOs 1960, 1961 are allocated to the push buttons (there are 2 of them). 
 
4\. Register interrupt for one of the dipswiches, using the appropriate GPIO number, as determined in a previous step: 
 
```bash 
root@agilexfm87:~/intelFPGA# modprobe gpio_interrupt gpio_number=1928 intr_type=3 
[ 893.594901] gpio_interrupt: loading out-of-tree module taints kernel. 
[ 893.602212] Interrupt for GPIO:1928 
[ 893.602212] registered 
``` 
 
5\. Toggle the USER_SW0/SW1.1 dipswitch a few times, you will see messages from the interrupt handler 
 
```bash 
[ 933.872016] Interrupt happened at gpio:1928 
[ 936.630233] Interrupt happened at gpio:1928 
[ 938.737038] Interrupt happened at gpio:1928 
[ 939.951513] Interrupt happened at gpio:1928 
``` 
 
6\. Remove the driver 
 
```bash 
root@agilexfm87:~/intelFPGA# rmmod gpio_interrupt 
``` 
 
7\. Register the pushbutton interrupt, using the appropriate GPIO number as determine on a previous step 
 
```bash 
root@agilexfm87:~/intelFPGA# modprobe gpio_interrupt gpio_number=1960 intr_type=2 
[ 1138.025297] Interrupt for GPIO:1960 
[ 1138.025297] registered 
``` 
 
8\. Push the pusbutton USER_PB0/S2 a few times, you will see interrupt handler messages 
 
```bash 
[ 1141.672192] Interrupt happened at gpio:1960 
[ 1142.110673] Interrupt happened at gpio:1960 
[ 1142.499468] Interrupt happened at gpio:1960 
[ 1142.884199] Interrupt happened at gpio:1960 
``` 
 
9\. Once done, remove the handler 
 
```bash 
root@agilexfm87:~/intelFPGA# rmmod gpio_interrupt 
``` 
 
**Note**: If you are on the ssh console, you will need to run the program *dmesg* after pressing the button in order to see the messages: 
 
```bash 
root@stratix10:~/intelFPGA# dmesg 
``` 
 
#### System Check Application 
 
System check application provides a glance of system status of basic peripherals such as: 
 
- **USB**: USB device driver 
- **Network IP (IPv4)**: Network IP address 
- **HPS LEDs**: HPS LED state 
- **FPGA LEDs**: FPGA LED state 
 
Run the application by issuing the following command: 
 
```bash 
root@agilexfm87:~/intelFPGA# ./syschk 
``` 
 
The window will look as shown below - press 'q' to exit: 
 
```bash 
 ALTERA SYSTEM CHECK 
 
lo : 127.0.0.1 usb1 : DWC OTG Controller 
eth0 : 192.168.1.172 
 serial@ffc02100 : disabled 
fpga_led2 : ON serial@ffc02000 : okay 
hps_led2 : OFF 
fpga_led0 : OFF 
hps_led0 : OFF 
fpga_led3 : OFF 
fpga_led1 : OFF 
hps_led1 : OFF 
``` 
 
### Connect to Board Web Server and SSH Client 
 
#### Connect to Web Server 
 
1\. Boot Linux as described in [Boot Linux](#boot-linux). 
 
2\. Determine the IP address of the board using 'ifconfig' as shown above. Note there will be network interfaces of them, either can be used. 
 
3\. Open a web browser on the host PC and type *http://* on the address box, then type the IP of your board and hit Enter. 
 
![](images/fm87-web.jpg) 
 
4\. In the section named **Interacting with Agilex™ SoC Development Kit** you can perform the following actions: 
 
- See which LEDs are ON and which are off in the **LED Status**. Note that if the LEDs are setup to be scrolling, the displayed scrolling speed will not match the actual scrolling speed on the board. 
- Stop LEDs from scrolling, by clicking **START** and **STOP** buttons. The delay between LEDs turning ON and OFF is set in the **LED Lightshow** box. 
- Turn individual LEDs ON and OFF with the **ON** and **OFF** buttons. Note that this action is only available when the LED scrolling/lightshow is stopped. 
- Blink individual LEDs by typing a delay value in ms then clicking the corresponding **BLINK** button. Note that this action is only available when the LED scrolling/lightshow is stopped. 
 
#### Connect Using SSH 
 
1\. The lower bottom of the web page presents instructions on how to connect to the board using an SSH connection. 
 
![](images/fm87-ssh.jpg) 
 
2\. If the SSH client is not installed on your host computer, you can install it by running the following command on CentOS: 
 
```bash 
$ sudo yum install openssh-clients 
``` 
 
or the following command on Ubuntu: 
 
```bash 
$ sudo apt-get install openssh-client 
``` 
 
3\. Connect to the board, and run some commands, such as **pwd**, **ls** and **uname** to see Linux in action: 
 
![](images/fm87-ssh-logged.jpg) 
 
## Build GSRD for DK-SI-AGI027FB


### Build Flow 
 
The following diagram illustrates the full build flow for the GSRD based on source code from GitHub. 
 
![](images/fm87-build-flow.svg) 
 
### Set up Environment 

 
Create a top folder for this example, as the rest of the commands assume this location: 
 

```bash 
sudo rm -rf gsrd.dk_si_agi027fb 
mkdir gsrd.dk_si_agi027fb 
cd gsrd.dk_si_agi027fb 
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
export QUARTUS_ROOTDIR=~/intelFPGA_pro/24.3.1/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```




 
### Build Hardware Design 

 
Use the following commands to build the hardware design: 
 

```bash 
cd $TOP_FOLDER 
rm -rf ghrd-socfpga agilex_soc_devkit_ghrd 
git clone -b QPDS24.3.1_REL_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga 
mv ghrd-socfpga/agilex_soc_devkit_ghrd . 
rm -rf ghrd-socfpga 
cd agilex_soc_devkit_ghrd 
make BOARD_TYPE=devkit_fm87 QUARTUS_DEVICE=AGIB027R31B1E1VAA ENABLE_HPS_EMIF_ECC=1 FPGA_SGPIO_EN=1 HPS_F2S_IRQ_EN=1 generate_from_tcl all
cd .. 
``` 

 
The following files are created: 
 
- $TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vaa_hps_debug.sof - FPGA configuration file, without HPS FSBL 
- $TOP_FOLDER/agilex_soc_devkit_ghrd/software/hps_debug/hps_debug.ihex - HPS Debug FSBL 
- $TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vaa_hps_debug.sof - FPGA configuration file, with HPS Debug FSBL 
 

### Build Core RBF 

 
Create the Core RBF file to be used in the rootfs created by Yocto by using the HPS Debug SOF built by the GHRD makefile: 
 

```bash 
cd $TOP_FOLDER 
rm -f *jic* *rbf* 
quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vaa_hps_debug.sof \
 ghrd_agib027r31b1e1vaa.jic \
 -o device=MT25QU02G \
 -o flash_loader=AGIB027R31B1E1VAA \
 -o mode=ASX4 \
 -o hps=1
rm ghrd_agib027r31b1e1vaa.hps.jic 
``` 

 
The following files will be created: 
 
- $TOP_FOLDER/ghrd_agib027r31b1e1vaa.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric 
 
Note we are also creating an HPS JIC file, but we are discarding it, as it has the HPS Debug FSBL, while the final image needs to have the U-Boot SPL created by the Yocto recipes. 
 




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
 
2\. Clone the Yocto script and prepare the build: 
 

```bash 
cd $TOP_FOLDER 
rm -rf gsrd-socfpga
git clone -b QPDS24.3.1_REL_GSRD_PR https://github.com/altera-opensource/gsrd-socfpga
cd gsrd-socfpga
. agilex7_dk_si_agi027fb-gsrd-build.sh 
build_setup 
``` 

 
**Note**: Run the following commands to set up again the yocto build environments, if you closed the current window (for example when rebooting the Linux host) and want to resume the next steps: 
 
```bash 
cd $TOP_FOLDER/gsrd-socfpga
. ./poky/oe-init-build-env agilex7_dk_si_agi027fb-gsrd-rootfs/ 
``` 
### Customize Yocto Build 
 
1\. Copy the rebuilt files to `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files` using the following names, as expected by the yocto recipes: 
 
- agilex7_dk_si_agi027fb_gsrd_ghrd.core.rbf - core rbf file for configuring the fabric 
 
In our case we just copy the core.ghrd file in the Yocto recipe location: 
 

```bash 
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agi027fb_gsrd_ghrd.core.rbf 
ln -s $TOP_FOLDER/ghrd_agib027r31b1e1vaa.core.rbf $CORE_RBF 
``` 

 
2\. In the Yocto recipe `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb` modify the agilex_gsrd_code file location: 
 
```bash 
SRC_URI:agilex7_dk_si_agi027fb ?= "\
 ${GHRD_REPO}/agilex7_dk_si_agi027fb_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agi027fb_gsrd_core \
 " 
``` 
 
to look like this: 
 
```bash 
SRC_URI:agilex7_dk_si_agi027fb ?= "\
 file://agilex7_dk_si_agi027fb_gsrd_ghrd.core.rbf \
 " 
``` 
 
using the following commands: 
 

```bash 
OLD_URI="\${GHRD_REPO}\/agilex7_dk_si_agi027fb_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agi027fb_gsrd_core" 
NEW_URI="file:\/\/agilex7_dk_si_agi027fb_gsrd_ghrd.core.rbf" 
sed -i "s/$OLD_URI/$NEW_URI/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
``` 

 
3\. In the same Yocto recipe update the SHA256 checksum for the file: 
 
```bash 
SRC_URI[agilex7_dk_si_agi027fb_gsrd_core.sha256sum] = "225869090fe181cb3968eeaee8422fc409c11115a9f3b366a31e3219b9615267" 
``` 
 
by using the following commands: 
 

```bash 
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ") 
OLD_SHA="SRC_URI\[agilex7_dk_si_agi027fb_gsrd_core\.sha256sum\] = .*" 
NEW_SHA="SRC_URI[agilex7_dk_si_agi027fb_gsrd_core.sha256sum] = \"$CORE_SHA\"" 
sed -i "s/$OLD_SHA/$NEW_SHA/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
``` 

 
4\. Optionally change the following files in `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/u-boot/files/`: 
 
- [uboot.txt](https://github.com/altera-opensource/meta-intel-fpga-refdes/blob/nanbield/recipes-bsp/u-boot/files/uboot.txt) - distroboot script 
- [uboot_script.its](https://github.com/altera-opensource/meta-intel-fpga-refdes/blob/nanbield/recipes-bsp/u-boot/files/uboot_script.its) - its file for creating FIT image from the above script 
 
5\. Optionally change the following file in `$WORKSPACE/meta-intel-fpga-refdes/recipes-kernel/linux/linux-socfpga-lts`: 
 
- [fit_kernel_agilex7_dk_si_agf014eb.its](https://github.com/altera-opensource/meta-intel-fpga-refdes/blob/nanbield/recipes-kernel/linux/linux-socfpga-lts/fit_kernel_agilex7_dk_si_agf014eb.its) - its file for creating the kernel.itb image 
 
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
 
- `agilex7_dk_si_agi027fb-gsrd-rootfs`: area used by OpenEmbedded build system for builds. Description of build directory structure - https://docs.yoctoproject.org/ref-manual/structure.html#the-build-directory-build 
- `agilex7_dk_si_agi027fb-gsrd-images`: the build script copies here relevant files built by Yocto from the `agilex7_dk_si_agi027fb-gsrd-rootfs/tmp/deploy/images/agilex` folder, but also other relevant files. 
 
The two most relevant files created in the `$TOP_FOLDER/gsrd-socfpga/agilex7_dk_si_agi027fb-gsrd-images` folder are: 
 
| File | Description | 
| :-- | :-- | 
| sdimage.tar.gz | SD Card Image, to be written on SD card | 
| u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex | U-Boot SPL Hex file, to be used for generating the bootable SOF file | 
 

### Build QSPI Image 

 
The QSPI image will contain the FPGA configuration data and the HPS FSBL and it can be built using the following command: 
 

```bash 
cd $TOP_FOLDER 
rm -f *jic* *rbf* 
quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vaa.sof \
 ghrd_agib027r31b1e1vaa.jic \
 -o hps_path=gsrd-socfpga/agilex7_dk_si_agi027fb-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \
 -o device=MT25QU02G \
 -o flash_loader=AGIB027R31B1E1VAA \
 -o mode=ASX4 \
 -o hps=1
``` 

 
The following files will be created: 
 
- $TOP_FOLDER/ghrd_agib027r31b1e1vaa.hps.jic - Flash image for HPS First configuration bitstream, phase 1: HPS and DDR 
- $TOP_FOLDER/ghrd_agib027r31b1e1vaa.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric, discarded, as we already have it on the SD card 
 



## Build GSRD for DK-SI-AGI027FA


 
### Build Flow 
 
The following diagram illustrates the full build flow for the GSRD based on source code from GitHub. 
 
![](images/fm87-build-flow.svg) 
 
### Setting up Environment 

 
Create a top folder for this example, as the rest of the commands assume this location: 
 

```bash 
sudo rm -rf gsrd.dk_si_agi027fa 
mkdir gsrd.dk_si_agi027fa 
cd gsrd.dk_si_agi027fa 
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
export QUARTUS_ROOTDIR=~/intelFPGA_pro/24.3.1/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```




 
### Build Hardware Design 

 
Use the following commands to build the hardware design: 
 

```bash 
cd $TOP_FOLDER 
rm -rf ghrd-socfpga agilex_soc_devkit_ghrd 
git clone -b QPDS24.3.1_REL_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga 
mv ghrd-socfpga/agilex_soc_devkit_ghrd agilex_soc_devkit_ghrd 
rm -rf ghrd-socfpga 
cd agilex_soc_devkit_ghrd 
make BOARD_TYPE=devkit_fm87 BOARD_PWRMGT=linear QUARTUS_DEVICE=AGIB027R31B1E1V ENABLE_HPS_EMIF_ECC=1 FPGA_SGPIO_EN=1 HPS_F2S_IRQ_EN=1 generate_from_tcl all
cd .. 
``` 

 
The following files are created: 
 
- $TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1v.sof - FPGA configuration file, without HPS FSBL 
- $TOP_FOLDER/agilex_soc_devkit_ghrd/software/hps_debug/hps_debug.ihex - HPS Debug FSBL 
- $TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1v_hps_debug.sof - FPGA configuration file, with HPS Debug FSBL 
 

### Build Core RBF 

 
Create the Core RBF file to be used in the rootfs created by Yocto by using the HPS Debug SOF built by the GHRD makefile: 
 

```bash 
cd $TOP_FOLDER 
rm -f *jic* *rbf* 
quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1v_hps_debug.sof \
 ghrd_agib027r31b1e1v.jic \
 -o device=MT25QU02G \
 -o flash_loader=AGIB027R31B1E1V \
 -o mode=ASX4 \
 -o hps=1
rm ghrd_agib027r31b1e1v.hps.jic
``` 

 
The following files will be created: 
 
- `$TOP_FOLDER/ghrd_agib027r31b1e1v.core.rbf` - HPS First configuration bitstream, phase 2: FPGA fabric 
 
Note we are also creating an HPS JIC file, but we are discarding it, as it has the HPS Debug FSBL, while the final image needs to have the U-Boot SPL created by the Yocto recipes. 
 




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

2\. Clone the Yocto script and prepare the build: 
 

```bash 
cd $TOP_FOLDER 
rm -rf gsrd-socfpga
git clone -b QPDS24.3.1_REL_GSRD_PR https://github.com/altera-opensource/gsrd-socfpga
cd gsrd-socfpga
. agilex7_dk_si_agi027fa-gsrd-build.sh 
build_setup 
``` 

 
**Note**: Run the following commands to set up again the yocto build environments, if you closed the current window (for example when rebooting the Linux host) and want to resume the next steps: 
 
```bash 
cd $TOP_FOLDER/gsrd-socfpga
. ./poky/oe-init-build-env agilex7_dk_si_agi027fa-gsrd-rootfs/ 
``` 
 
### Customize Yocto
 
1\. Copy the rebuilt files to `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files` using the following names, as expected by the yocto recipes: 
 
- `agilex7_dk_si_agi027fa_gsrd_ghrd.core.rbf` - core rbf file for configuring the fabric 
 
In our case we just copy the core.ghrd file in the Yocto recipe location: 
 

```bash 
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agi027fa_gsrd_ghrd.core.rbf 
ln -s $TOP_FOLDER/ghrd_agib027r31b1e1v.core.rbf $CORE_RBF 
``` 

 
2\. In the Yocto recipe `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb` modify the agilex_gsrd_code file location: 
 
```bash 
SRC_URI:agilex7_dk_si_agi027fa ?= "\
 ${GHRD_REPO}/agilex7_dk_si_agi027fa_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agi027fa_gsrd_core \
 " 
``` 
 
to look like this: 
 
```bash 
SRC_URI:agilex7_dk_si_agi027fa ?= "\
 file://agilex7_dk_si_agi027fa_gsrd_ghrd.core.rbf \
 " 
``` 
 
using the following commands: 
 

```bash 
OLD_URI="\${GHRD_REPO}\/agilex7_dk_si_agi027fa_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agi027fa_gsrd_core" 
NEW_URI="file:\/\/agilex7_dk_si_agi027fa_gsrd_ghrd.core.rbf" 
sed -i "s/$OLD_URI/$NEW_URI/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
``` 

 
3\. In the same Yocto recipe update the SHA256 checksum for the file: 
 
```bash 
SRC_URI[agilex7_dk_si_agi027fa_gsrd_core.sha256sum] = "225869090fe181cb3968eeaee8422fc409c11115a9f3b366a31e3219b9615267" 
``` 
 
by using the following commands: 
 

```bash 
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ") 
OLD_SHA="SRC_URI\[agilex7_dk_si_agi027fa_gsrd_core\.sha256sum\] = .*" 
NEW_SHA="SRC_URI[agilex7_dk_si_agi027fa_gsrd_core.sha256sum] = \"$CORE_SHA\"" 
sed -i "s/$OLD_SHA/$NEW_SHA/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
``` 

 
4\. Optionally change the following files in `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/u-boot/files/`: 
 
- [uboot.txt](https://github.com/altera-opensource/meta-intel-fpga-refdes/blob/nanbield/recipes-bsp/u-boot/files/uboot.txt) - distroboot script 
- [uboot_script.its](https://github.com/altera-opensource/meta-intel-fpga-refdes/blob/nanbield/recipes-bsp/u-boot/files/uboot_script.its) - its file for creating FIT image from the above script 
 
5\. Optionally change the following file in `$WORKSPACE/meta-intel-fpga-refdes/recipes-kernel/linux/linux-socfpga-lts`: 
 
- [fit_kernel_agilex7_dk_si_agi027fa.its](https://github.com/altera-opensource/meta-intel-fpga-refdes/blob/nanbield/recipes-kernel/linux/linux-socfpga-lts/fit_kernel_agilex7_dk_si_agi027fa.its) - its file for creating the kernel.itb image 
 
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
 
- `agilex7_dk_si_agi027fa-gsrd-rootfs`: area used by OpenEmbedded build system for builds. Description of build directory structure - https://docs.yoctoproject.org/ref-manual/structure.html#the-build-directory-build 
- `agilex7_dk_si_agi027fa-gsrd-images`: the build script copies here relevant files built by Yocto from the `agilex7_dk_si_agi027fa-gsrd-rootfs/tmp/deploy/images/agilex` folder, but also other relevant files. 
 
The two most relevant files created in the `$TOP_FOLDER/gsrd-socfpga/agilex-gsrd-images` folder are: 
 
| File | Description | 
| :-- | :-- | 
| sdimage.tar.gz | SD Card Image, to be written on SD card | 
| u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex | U-Boot SPL Hex file, to be used for generating the bootable SOF file | 
 

### Build QSPI Image 

 
The QSPI image will contain the FPGA configuration data and the HPS FSBL and it can be built using the following command: 
 

```bash 
cd $TOP_FOLDER 
rm -f *jic* *rbf* 
quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1v.sof \
 ghrd_agib027r31b1e1v.jic \
 -o hps_path=gsrd-socfpga/agilex7_dk_si_agi027fa-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \
 -o device=MT25QU02G \
 -o flash_loader=AGIB027R31B1E1V \
 -o mode=ASX4 \
 -o hps=1 
``` 

 
The following files will be created: 
 
- `$TOP_FOLDER/ghrd_agib027r31b1e1v.hps.jic` - Flash image for HPS First configuration bitstream, phase 1: HPS and DDR 
- `$TOP_FOLDER/ghrd_agib027r31b1e1v.core.rbf` - HPS First configuration bitstream, phase 2: FPGA fabric, discarded, as we already have it on the SD card 
 



## Build GSRD for DK-SI-AGI027FC


 
### Build Flow 
 
The following diagram illustrates the full build flow for the GSRD based on source code from GitHub. 
 
![](images/fm87-build-flow.svg) 
 
### Set up Environment 

 
Create a top folder for this example, as the rest of the commands assume this location: 
 

```bash 
sudo rm -rf gsrd.dk_si_agi027fc 
mkdir gsrd.dk_si_agi027fc 
cd gsrd.dk_si_agi027fc 
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
export QUARTUS_ROOTDIR=~/intelFPGA_pro/24.3.1/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```




 
### Build Hardware Design 

 
Use the following commands to build the hardware design: 
 

```bash 
cd $TOP_FOLDER 
rm -rf ghrd-socfpga agilex_soc_devkit_ghrd 
git clone -b QPDS24.3.1_REL_GSRD_PR https://github.com/altera-opensource/ghrd-socfpga 
mv ghrd-socfpga/agilex_soc_devkit_ghrd agilex_soc_devkit_ghrd 
rm -rf ghrd-socfpga 
cd agilex_soc_devkit_ghrd 
make BOARD_TYPE=devkit_fm87 BOARD_PWRMGT=linear ENABLE_HPS_EMIF_ECC=1 FPGA_SGPIO_EN=1 HPS_F2S_IRQ_EN=1 generate_from_tcl all
cd .. 
``` 

 
The following files are created: 
 
- `$TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vb.sof` - FPGA configuration file, without HPS FSBL 
- `$TOP_FOLDER/agilex_soc_devkit_ghrd/software/hps_debug/hps_debug.ihex` - HPS Debug FSBL 
- `$TOP_FOLDER/agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vb_hps_debug.sof` - FPGA configuration file, with HPS Debug FSBL 
 

### Build Core RBF 

 
Create the Core RBF file to be used in the rootfs created by Yocto by using the HPS Debug SOF built by the GHRD makefile: 
 

```bash 
cd $TOP_FOLDER 
rm -f *jic* *rbf* 
quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vb_hps_debug.sof \
 ghrd_agib027r31b1e1vb.jic \
 -o device=MT25QU02G \
 -o flash_loader=AGIB027R31B1E1VB \
 -o mode=ASX4 \
 -o hps=1
rm ghrd_agib027r31b1e1vb.hps.jic
``` 

 
The following files will be created: 
 
- $TOP_FOLDER/ghrd_agib027r31b1e1vb.core.rbf - HPS First configuration bitstream, phase 2: FPGA fabric 
 
Note we are also creating an HPS JIC file, but we are discarding it, as it has the HPS Debug FSBL, while the final image needs to have the U-Boot SPL created by the Yocto recipes. 
 




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
 
2\. Clone the Yocto script and prepare the build: 
 

```bash 
cd $TOP_FOLDER 
rm -rf gsrd-socfpga
git clone -b QPDS24.3.1_REL_GSRD_PR https://github.com/altera-opensource/gsrd-socfpga
cd gsrd-socfpga
. agilex7_dk_si_agi027fc-gsrd-build.sh 
build_setup 
``` 

 
**Note**: Run the following commands to set up again the yocto build environments, if you closed the current window (for example when rebooting the Linux host) and want to resume the next steps: 
 
```bash 
cd $TOP_FOLDER/gsrd-socfpga
. ./poky/oe-init-build-env agilex7_dk_si_agi027fc-gsrd-rootfs/ 
``` 
 
### Customize Yocto
 
1\. Copy the rebuilt files to `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files` using the following names, as expected by the yocto recipes: 
 
- `agilex7_dk_si_agi027fc_gsrd_ghrd.core.rbf` - core rbf file for configuring the fabric 
 
In our case we just copy the core.ghrd file in the Yocto recipe location: 
 

```bash 
CORE_RBF=$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/files/agilex7_dk_si_agi027fc_gsrd_ghrd.core.rbf 
ln -s $TOP_FOLDER/ghrd_agib027r31b1e1vb.core.rbf $CORE_RBF 
``` 

 
2\. In the Yocto recipe `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb` modify the agilex_gsrd_code file location: 
 
```bash 
SRC_URI:agilex7_dk_si_agi027fc ?= "\
 ${GHRD_REPO}/agilex7_dk_si_agi027fc_gsrd_${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agi027fc_gsrd_core \
 " 
``` 
 
to look like this: 
 
```bash 
SRC_URI:agilex7_dk_si_agi027fc ?= "\
 file://agilex7_dk_si_agi027fc_gsrd_ghrd.core.rbf \
 " 
``` 
 
using the following commands: 
 

```bash 
OLD_URI="\${GHRD_REPO}\/agilex7_dk_si_agi027fc_gsrd_\${ARM64_GHRD_CORE_RBF};name=agilex7_dk_si_agi027fc_gsrd_core" 
NEW_URI="file:\/\/agilex7_dk_si_agi027fc_gsrd_ghrd.core.rbf" 
sed -i "s/$OLD_URI/$NEW_URI/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
``` 

 
3\. In the same Yocto recipe update the SHA256 checksum for the file: 
 
```bash 
SRC_URI[agilex7_dk_si_agi027fc_gsrd_core.sha256sum] = "225869090fe181cb3968eeaee8422fc409c11115a9f3b366a31e3219b9615267" 
``` 
 
by using the following commands: 
 

```bash 
CORE_SHA=$(sha256sum $CORE_RBF | cut -f1 -d" ") 
OLD_SHA="SRC_URI\[agilex7_dk_si_agi027fc_gsrd_core\.sha256sum\] = .*" 
NEW_SHA="SRC_URI[agilex7_dk_si_agi027fc_gsrd_core.sha256sum] = \"$CORE_SHA\"" 
sed -i "s/$OLD_SHA/$NEW_SHA/g" $WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/ghrd/hw-ref-design.bb 
``` 

 
4\. Optionally change the following files in `$WORKSPACE/meta-intel-fpga-refdes/recipes-bsp/u-boot/files/`: 
 
- [uboot.txt](https://github.com/altera-opensource/meta-intel-fpga-refdes/blob/scarthgap/recipes-bsp/u-boot/files/uboot.txt) - distroboot script 
- [uboot_script.its](https://github.com/altera-opensource/meta-intel-fpga-refdes/blob/scarthgap/recipes-bsp/u-boot/files/uboot_script.its) - its file for creating FIT image from the above script 
 
5\. Optionally change the following file in `$WORKSPACE/meta-intel-fpga-refdes/recipes-kernel/linux/linux-socfpga-lts`: 
 
- [fit_kernel_agilex7_dk_si_agi027fc.its](https://github.com/altera-opensource/meta-intel-fpga-refdes/blob/scarthgap/recipes-kernel/linux/linux-socfpga-lts/fit_kernel_agilex7_dk_si_agi027fc.its) - its file for creating the kernel.itb image 
 
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
 
- `agilex7_dk_si_agi027fc-gsrd-rootfs`: area used by OpenEmbedded build system for builds. Description of build directory structure - https://docs.yoctoproject.org/ref-manual/structure.html#the-build-directory-build 
- `agilex7_dk_si_agi027fc-gsrd-images`: the build script copies here relevant files built by Yocto from the `agilex7_dk_si_agi027fc-gsrd-rootfs/tmp/deploy/images/agilex` folder, but also other relevant files. 
 
The two most relevant files created in the `$TOP_FOLDER/gsrd-socfpga/agilex-gsrd-images` folder are: 
 
| File | Description | 
| :-- | :-- | 
| sdimage.tar.gz | SD Card Image, to be written on SD card | 
| u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex | U-Boot SPL Hex file, to be used for generating the bootable SOF file | 
 

### Build QSPI Image 

 
The QSPI image will contain the FPGA configuration data and the HPS FSBL and it can be built using the following command: 
 

```bash 
cd $TOP_FOLDER 
rm -f *jic* *rbf* 
quartus_pfg -c agilex_soc_devkit_ghrd/output_files/ghrd_agib027r31b1e1vb.sof \
 ghrd_agib027r31b1e1vb.jic \
 -o hps_path=gsrd-socfpga/agilex7_dk_si_agi027fc-gsrd-images/u-boot-agilex7-socdk-gsrd-atf/u-boot-spl-dtb.hex \
 -o device=MT25QU02G \
 -o flash_loader=AGIB027R31B1E1VB \
 -o mode=ASX4 \
 -o hps=1
``` 

 
The following files will be created: 
 
- `$TOP_FOLDER/ghrd_agib027r31b1e1vb.hps.jic` - Flash image for HPS First configuration bitstream, phase 1: HPS and DDR 
- `$TOP_FOLDER/ghrd_agib027r31b1e1vb.core.rbf` - HPS First configuration bitstream, phase 2: FPGA fabric, discarded, as we already have it on the SD card




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