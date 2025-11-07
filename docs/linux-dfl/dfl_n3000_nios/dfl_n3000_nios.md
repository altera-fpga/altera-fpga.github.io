# **FPGA DFL NIOS Driver for Altera PAC N3000**

**Upstream Status**: [Upstreamed](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/dfl-n3000-nios.c)

**Devices supported**: Arria 10 GX

## **Introduction**

This is the driver for the N3000 Nios private feature on Altera PAC (Programmable Acceleration Card) N3000. It communicates with the embedded Nios processor to configure the retimers on the card. It also instantiates the SPI master (spi-altera) for the card's BMC (Board Management Controller). It matches and probes based on the Nios private feature node on a DFL from an Altera N3000 device. This driver also depends on the generic DFL driver.

|Driver|Mapping|Source(s)|Required for DFL|
|---|---|---|---|
|dfl-n3000-nios.ko|FPGA DFL NIOS Driver for Altera PAC N3000|drivers/fpga/dfl-n3000-nios.c|N|

## **Driver Sources**

The GitHub source code for this driver can be found at [https://github.com/OFS/linux-dfl/blob/master/drivers/fpga/dfl-n3000-nios.c#L4](https://github.com/OFS/linux-dfl/blob/master/drivers/fpga/dfl-n3000-nios.c#L4).

The Upstream source code for this driver can be found at [https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/dfl-n3000-nios.c](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/dfl-n3000-nios.c).

## **Driver Capabilities**

* Instantiate the SPI interface for an N3000
* Communicate with N3000 retimers

## **Kernel Configurations**

FPGA_DFL_NIOS_INTEL_PAC_N3000

![](./images/dfl_n3000_nios_menuconfig.PNG)

## **Known Issues**

None known

## **Example Designs**

N/A

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