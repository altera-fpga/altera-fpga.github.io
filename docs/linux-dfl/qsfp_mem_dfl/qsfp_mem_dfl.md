# **Memory Based QSFP Support Driver for Host Attach**

**Upstream Status**: Not Upstreamed

**Devices supported**: Stratix 10, Arria 10 GX

## **Introduction**

This legacy driver builds on top of the QSFP Module and Ethernet IP drivers and enables them in a DFL design. This DFL-based driver will shadow the QSFP module's memory pages in memory. It leverages the core driver code from `qsfp-mem-core.ko`.

|Driver|Mapping|Source(s)|Required for DFL|
|---|---|---|---|
|qsfp-mem-dfl.ko|Memory Based QSFP Support for DFL|drivers/net/phy/qsfp-mem-dfl.c|N|
|qsfp-mem-platform.ko|Memory based QSFP support|drivers/net/phy/qsfp-mem-platform.c|N|
|qsfp-mem-core.ko|Memory based QSFP support|drivers/net/phy/qsfp-mem-core.c|N|

```mermaid
graph TD;
    A[regmap-mmio]-->B[qsfp-mem-core];
    B[qsfp-mem-core]-->C[qsfp-mem-platform];
    B[qsfp-mem-core]-->D[qsfp-mem-dfl];
```

## **Driver Sources**

The GitHub source code for this driver can be found at [https://github.com/OFS/linux-dfl/tree/fpga-ofs-dev-6.1-lts/drivers/net/phy](https://github.com/OFS/linux-dfl/tree/fpga-ofs-dev-6.1-lts/drivers/net/phy).

## **Driver Capabilities**

* Probe and match the corresponding DFL Device
* Init a QSFP Device
* Send data over I2C

## **Kernel Configurations**

QSFP_MEM_CORE

![](./images/qsfp_mem_core_menuconfig.PNG)

QSFP_MEM

![](./images/qsfp_mem_platform_menuconfig.PNG)

QSFP_MEM_DFL

![](./images/qsfp_mem_dfl_menuconfig.PNG)

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