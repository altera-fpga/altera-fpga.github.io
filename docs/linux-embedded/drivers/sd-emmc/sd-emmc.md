# **SD-EMMC Driver for Hard Processor System**

Last updated: **June 25, 2025** 

**Upstream Status**: [Upstreamed](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-cadence.c)

**Devices supported**: Agilex 5

## **Introduction**

The Secure Digital/Embedded Multimedia Card (SD/eMMC) driver supports the SD/eMMC controller in the Hard Processor System (HPS) which interfaces with external SD Flash cards, secure digital I/O (SDIO) devices, and eMMC storage devices.


For More information please refer to the [Intel Agilex 5 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/814346).

![sdmmc_diagram](images/A5_SD_eMMC_block_diagram.png)

## **Driver Sources**

The source code for this driver can be found at:

[https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-cadence.c](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-cadence.c)

## **Driver Capabilities**

* Manage SD/eMMC features such as configuration and reset and timeout clock frequency
* Supports SDMA and ADMA modes.
* Handles data transfer to/from the SD/eMMC.


## **Kernel Configurations**

CONFIG_MMC_SDHCI_CADENCE

![sdmmc_config_path](images/sdmmc_config_path.png){: style="height:450px;width:450px"}

## **Device Tree**

Example Device tree location to configure the SD/eMMC:

[https://github.com/altera-opensource/linux-socfpga/blob/socfpga_agilex5-ES_RC/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi](https://github.com/altera-opensource/linux-socfpga/blob/socfpga_agilex5-ES_RC/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi)

![sdmmc_device_tree](images/sdmmc_device_tree.png)

## **Known Issues**

None known

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