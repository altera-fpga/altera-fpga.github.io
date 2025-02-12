# **QSPI Driver for Hard Processor System (HPS)**

Last updated: **February 12, 2025** 

**Upstream Status**: Not Upstreamed

**Devices supported**: Agilex 5

## **Introduction**

The Quad Serial Peripheral Interface (QSPI) driver manages the QSPI controller in the HPS.  The QSPI has the capability to access serial NOR Flash connected to the Secure Device Manager (SDM) QSPI. The QSPI controller supports standard SPI Flash devices as well as high-performance dual and quad SPI Flash devices. The QSPI controller module features are:

* SPIx1, SPIx2, or SPIx4 (QSPI) serial NOR flash devices
* Supported clock frequencies up to 166 MHz
* Direct access and indirect access modes
* Single I/O, dual I/O, or quad I/O instructions
* Up to four chip selects
* Configurable clock polarity and phase
* Programmable write-protected regions
* Programmable delays between transactions

To find out more about the QSPI controller within the HPS please refer to the [Intel Agilex 5 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/814346). 

## **Driver Capabilities**

* Initialize and configuration of the QSPI controller.
* Handles data transfer and address.

## **Driver Sources**

The source code for this driver can be found at [https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.1.55-lts/drivers/spi/spi-cadence-quadspi.c](https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.1.55-lts/drivers/spi/spi-cadence-quadspi.c).

## **Kernel Configurations**

CONFIG_SPI_CADENCE_QUADSPI

![qspi_config_path](images/qspi_config_path.png)

## **Device Tree**

Example Device tree location:

[https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.1.55-lts/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi](https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.1.55-lts/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi)

![qspi_device_tree](images/qspi_device_tree.png)

## **Known Issues**

None kKnown

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