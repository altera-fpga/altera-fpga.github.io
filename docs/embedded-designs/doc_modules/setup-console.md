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