# **Control Plane Driver for Stratix 10 HSSI**

**Upstream Status**: Not Upstreamed

**Devices supported**: Stratix 10

## **Introduction**

This driver provides control plane support for a Stratix 10 High Speed Serial Interface. The Stratix 10 High Speed Serial Interface provides a data path between the FPGA and the external QSFP interfaces. This data path does not involve packets transferred between host memory and the fpga. As such a very limited set of networking functionality is provided.

|Driver|Mapping|Source(s)|Required for DFL|
|---|---|---|---|
|s10hssi.ko|Control Plane Driver for Stratix 10 HSSI|drivers/net/ethernet/s10hssi.c|N|

## **Driver Sources**

The GitHub source code for this driver can be found at [https://github.com/OFS/linux-dfl/blob/fpga-ofs-dev-6.1-lts/drivers/net/ethernet/intel/s10hssi.c](https://github.com/OFS/linux-dfl/blob/fpga-ofs-dev-6.1-lts/drivers/net/ethernet/intel/s10hssi.c).

## **Driver Capabilities**

* Read and write XCVR status and statistics
* Set MAC address
* Enable loopback

## **Kernel Configurations**

S10HSSI

![](./images/s10hssi_menuconfig.PNG)

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