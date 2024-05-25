# **Generic DFL driver for Userspace I/O devices**

**Upstream Status**: [Upstreamed](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/uio/uio_dfl.c)

**Devices supported**: Agilex 7, Stratix 10

## **Introduction**

This DFL based driver provides direct access to DFL devices from userspace. A sample userspace application using this driver is available for download in a git repository: git clone https://github.com/OPAE/opae-sdk.git It can be found at: opae-sdk/libraries/libopaeuio/.

|Driver|Mapping|Source(s)|Required for DFL|
|---|---|---|---|
|uio_dfl.ko|Generic DFL driver for Userspace I/O devices|drivers/uio/uio_dfl.c|Y|

```mermaid
graph TD;
    A[uio]-->C[uio-dfl];
    B[dfl]-->C[uio-dfl];
```

## **Driver Sources**

The GitHub source code for this driver can be found at [https://github.com/OFS/linux-dfl/blob/master/drivers/uio/uio_dfl.c](https://github.com/OFS/linux-dfl/blob/master/drivers/uio/uio_dfl.c).

The Upstream source code for this driver can be found at [https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/uio/uio_dfl.c](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/uio/uio_dfl.c).

## **Driver Capabilities**

* Probe and match DFL UIO device(s)

## **Kernel Configurations**

UIO_DFL

![](./images/**Introduction**)

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

OpenCL and the OpenCL logo are trademarks of Apple Inc. used by permission of the Khronos Group™. 