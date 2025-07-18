# **Direct Memory Access Controller (DMAC) Driver for Hard Processor System**

Last updated: **July 18, 2025** 

**Upstream Status**: [Upstreamed](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c)

**Devices supported**: Agilex 5

## **Introduction**

The DMAC driver supports two DMACs with a maximum of four channels each. This driver transfers data between memory and peripherals and other memory locations in the system.

## **HPS Direct Memory Access Controller (DMAC)**

The DMAC is part of the Hard Processor System (HPS) of the FPGA.  The HPS provides two DMACs to handle the data transfer between memory-mapped peripherals and memories, off-loading this work from the MPU system complex. Some common features are listed below.

* Software programmable with dedicated register field
* Supports multiple transfer types
* Each DMAC channels supports four channels
* Each DMAC supports interrupt interface to the Generic Interrupt Controller (GIC)
* Supports up to 48 peripheral request interfaces

![A5_DMA_block_diagram](images/A5_DMA_block_diagram.png){: style="height:650px"}

For more information please refer to the following guide:
[Agilex 5 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/814346)

## **Driver Sources**

The source code for this driver can be found at

[https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c)

## **Driver Capabilities**

* DMA bus width configuration
* Transaction configuration
* Interrupt control and handling

## **Kernel Configurations**

CONFIG_DW_AXI_DMAC

![](images/dma_config_path.png)

## **Device Tree**

Example Device tree location to configure the dma:
[https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi)

![dma_device_tree](images/dma_device_tree_1.png)

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
