# **Ethernet 1588 PTP Time of Day Clock IP Driver for Hard Processor System**

Last updated: **July 07, 2025** 

**Upstream Status**: Not Upstreamed

**Devices supported**: Agilex 7

## **Introduction**

The driver for the Ethernet 1588 PTP Time of Day Clock FPGA IP is used in the 1588 PTP Design examples provided by Altera. The Time of Day Clock FPGA IP is exposed as a PTP Hardware Clock (PHC) device to the Linux PTP stack to synchronize the system clock to its ToD information using `phc2sys` utility in the Linux PTP stack.

## **Time of Day Clock FPGA IP**

The Time-of-day (TOD) Clock streams 96-bit and 64-bit time-of-day to one or more time stamping units in an IEEE 1588v2 solution. For information regarding this soft IP core, please refer to the [Ethernet Design Example Components User Guide](https://www.intel.com/content/www/us/en/docs/programmable/683044/latest/time-of-day-clock.html).

![ptp_tod_high_level_block_diagram](images/ptp_tod_high_level_block_diagram.png)

## **Driver Sources**

The source code for this driver can be found at [https://github.com/altera-opensource/linux-socfpga/blob/socfpga-5.15.90-lts-ftile-1588ptp/drivers/net/ethernet/altera/intel_fpga_tod.c](https://github.com/altera-opensource/linux-socfpga/blob/socfpga-5.15.90-lts-ftile-1588ptp/drivers/net/ethernet/altera/intel_fpga_tod.c).

## **Driver Capabilities**

* Registers PTP clock driver to kernel
* Calculates the ToD of clock offset adjustments

## **Kernel Configurations**

CONFIG_INTEL_FPGA_TOD

![ptp_tod_config_path](images/ptp_tod_config_path.png)

## **Device Tree**

Example Device tree location to configure the TOD:

[https://github.com/altera-opensource/linux-socfpga/blob/socfpga-5.15.90-lts-ftile-1588ptp/arch/arm64/boot/dts/intel/fm87_ftile_25g_2port_ptp.dtsi](https://github.com/altera-opensource/linux-socfpga/blob/socfpga-5.15.90-lts-ftile-1588ptp/arch/arm64/boot/dts/intel/fm87_ftile_25g_2port_ptp.dtsi)

![ptp_tod_device_tree](images/ptp_tod_device_tree.png)

## **Known Issues**

None known

## **Example Designs**

This driver is used in the [Agilex 7 SoC F-Tile Design Example for 25GbE and 10GbE with IEEE1588PTP](https://www.rocketboards.org/foswiki/Projects/Agilex7SoCFTileDesignExampleWithIEEE1588PTP25GE).

![f_tile_ptp_general_architecture](images/f_tile_ptp_general_architecture.png)


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
