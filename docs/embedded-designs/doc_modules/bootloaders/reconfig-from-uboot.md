## Reconfiguring Core Fabric from U-Boot
The GSRD configures the FPGA core fabric only once by U-boot during the Linux launch using the **bootm** command. In the bootloaders build flow, the reconfiguration is done in the U-Boot Shell through the **fpga load** command.

**Important**: If the FPGA fabric is already configured and bridges are enabled, you must call the **bridge disable** command from U-Boot before issuing the **bootm** or **fpga load** commands to reconfigure the fabric. Only do this if you are using an **arm-trusted-firmware** version more recent than the following:

* v2.7.1 = [https://github.com/altera-fpga/arm-trusted-firmware/commit/0a5edaed853e0dc1e687706ccace8e844b2a8db7](https://github.com/altera-fpga/arm-trusted-firmware/commit/0a5edaed853e0dc1e687706ccace8e844b2a8db7)
* v2.8.0 = [https://github.com/altera-fpga/arm-trusted-firmware/commit/bf933536d4582d63d0e29434e807a641941f3937](https://github.com/altera-fpga/arm-trusted-firmware/commit/bf933536d4582d63d0e29434e807a641941f3937)


The example below shows the steps to perform FPGA configuration from the U-boot.

1\. First, write the sdcard.img into an SD card. (Rename the wic file to 'sdcard.img')<br>
2\. Copy the configuration bitstream, ghrd.core.rbf, into the same SD Card.<br>
3\. Insert the SD Card to the board, boot the board up, and enter the U-boot shell when prompted.<br>
4\. In U-boot shell, run the following commands in sequence to perform FPGA configuration:<br>

* fatload mmc 0:1 [address] [ghrd.core.rbf]<br>
* fpga load [device] [address] [file_size]<br>

5\. The message "FPGA reconfiguration OK!" will be printed out upon successful transaction.<br>


Here is an example for Agilex® 5 device, but the same steps apply for Stratix® 10, Agilex® 7, and Agilex® 3 SoC FPGA devices.

```bash
Hit any key to stop autoboot:  0 /// Hit any key at this point to enter the U-boot Shell ///

SOCFPGA_AGILEX #
SOCFPGA_AGILEX # fatload mmc 0:1 0x90000000 ghrd.core.rbf
2404352 bytes read in 116 ms (19.8 MiB/s)
SOCFPGA_AGILEX # fpga load 0 0x90000000 ${filesize}
…FPGA reconfiguration OK!
```
