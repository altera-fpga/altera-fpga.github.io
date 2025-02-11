# **USB 3.1 Driver for Hard Processor System**

Last updated: **February 11, 2025** 

**Upstream Status**: Not Upstreamed

**Devices supported**: Agilex 5

## **Introduction**

The HPS provides a single instance of a USB 3.1 Gen 1 controller that supports both device and host functions for high-speed applications. The general use cases of USB 3.1 are for the HPS system to support all USB devices such as:

* Portable electronic devices
* High-bandwidth applications like audio and video.
* Debug trace applications

For More information please refer to the following link:

[Agilex 5 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/814346)

![usb3_1_diagram](images/usb3_1_diagram.png){: style="height:450px;width:450px"}

### USB 3.1 Glue Driver

`drivers/usb/dwc3/dwc3-of-simple.c` is a USB glue driver for the `dw3-agilex-edge.c` component depicted in the diagram below. This glue driver is used to control dynamic mode switching.

![usb3_1_driver](images/usb3_1_driver.png)

## **Driver Sources**

The source code for this driver can be found at:

[https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.1.55-lts/drivers/usb/dwc3/dwc3-of-simple.c](https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.1.55-lts/drivers/usb/dwc3/dwc3-of-simple.c)

## **Driver Capabilities**

* It provides a reference to the Clock which is required by the rest of the interfaces.

## **Kernel Configurations**

CONFIG_USB_DWC3

![usb_3_config_path](images/usb_3_config_path.png)

## **Device Tree**

Example Device tree location to configure the usb3_1:

[https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.1.55-lts/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi](https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.1.55-lts/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi)

![usb3_1_device_tree_1](images/usb3_1_device_tree_1.png)

## **Known Issues**

* Currently dynamic mode switching is not supported
* Real-time detection of USB-C slave devices not supported

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
