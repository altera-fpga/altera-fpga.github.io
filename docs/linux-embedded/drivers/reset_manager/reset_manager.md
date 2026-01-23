# **Reset Manager Driver for Hard Processor System**

Last updated: **January 23, 2026** 

**Upstream Status**: Not Upstreamed

**Devices supported**: Agilex™ 3, Agilex™ 5, Agilex™ 7

## **Introduction**

The reset manager generates module reset signals based on reset requests from various sources in the HPS, and performs software writing to the module-reset control registers.

The HPS contains multiple reset domains. Each reset domain can be reset
independently. A reset can be initiated externally, internally, or through software.  For more information about the reset manager, please refer to:

* Agilex™ 3: [Altera® Agilex™ 3 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/848530).
* Agilex™ 5: [Altera® Agilex™ 5 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/814346).
* Agilex™ 7: [Altera® Agilex™ 7 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/683567).

![reset_manager_diagram](images/A5_RSTMGR_block_diagram.png){: style="height:450px;width:450px"}

## **Driver Sources**

The source code for this driver can be found at:

[https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.12.43-lts/drivers/reset/reset-simple.c](https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.12.43-lts/drivers/reset/reset-simple.c)

## **Driver Capabilities**

* Manage the system level reset.
* Support Assert and De-assert of the reset signal.
* Monitor the status of the reset signal.

For reset manager capabilities in different devices, please refer to [Differences Among Altera® SoC Device Families](https://www.intel.com/content/www/us/en/docs/programmable/683648/current/hps-reset-manager-differences.html)

## **Kernel Configurations**

CONFIG_RESET_SIMPLE

![reset_manager_config_path](images/reset_manager_config_path.png)

## **Device Tree**

Example Device tree location for reset signal parameter for Agilex™ 5 device:

[https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.12.43-lts/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi](https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.12.43-lts/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi)

```bash
  rst: rstmgr@10d11000 {
			compatible = "altr,stratix10-rst-mgr", "altr,rst-mgr";
			reg = <0x10d11000 0x1000>;
			#reset-cells = <1>;
  };
```

Also dt-bindings can be found at:

[https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.12.43-lts/include/dt-bindings/reset/altr%2Crst-mgr-s10.h](https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.12.43-lts/include/dt-bindings/reset/altr%2Crst-mgr-s10.h)

## **Test Procedures**

You can apply a cold or warm reset from U-Boot and Linux shell commands as follow:

* **U-Boot**: The reset is applied using the **reset** command from the U-Boot shell. The type of reset is specified either with a environment variable or through a parameter in the **reset** command. This varies depending on the U-Boot branch and the SoC device. The default is **cold** reset if the environment variable is not assigned nor a parameter is passed to the reset command.
* **Linux:** The reset is applied using the **reboot** command from the Linux shell. The type of reset depends on the value assigned to the **reboot** kernel command line parameter passed to Linux. The default is **cold** reset if the parameter is not defined in the kernel command line.

The following table summarizes the procedure to apply a software (from U-Boot or Linux) Warm or Cold reset and the different variations of this. 

| Device | Cold Reset | Warm Reset |
| :-- | :-- | :-- |
| Agilex™ 5 <br>Agilex™ 3 | **======= U-Boot =======**<br>Before **2025.07** branch:<br>**reset** env variable undefined<br>U-Boot shell:<br/># **reset**<br>**2025.07** branch or later(**reset** env variable NOT used):<br>U-Boot shell:<br/># **reset**<br><br>**======= Linux =======**<br>Kernel Command line: **reboot** parameter undefined.<br>Linux shell: $ **reboot** | **======= U-Boot =======**<br/>Before **2025.07** branch:<br/>**reset** env variable set to warm<br/>U-Boot shell:<br/># **setenv reset warm**<br># **reset**<br/>**2025.07** branch or later(**reset** env variable NOT used):<br/>U-Boot shell:<br/># **reset -w**<br/><br/>**======= Linux: =======**<br/>Kernel Command line: **reboot=warm** <br/>Linux shell: $ **reboot** |
| Agilex™ 7 | **======= U-Boot =======**<br/>Before **2025.10** branch:<br/>**reset** env variable undefined<br/>U-Boot shell:<br/># **reset**<br/>**2025.10** branch or later(**reset** env variable NOT used):<br/>U-Boot shell:<br/># **reset**<br/><br/>**======= Linux: =======**<br/>Kernel Command line: **reboot** parameter undefined.<br/>Linux shell: $ **reboot** | **======= U-Boot =======**<br/>Before **2025.10** branch:<br/>**reset** env variable set to warm<br/>U-Boot shell:<br/># **setenv reset warm**<br/># **reset**<br/>**2025.10** branch or later(**reset** env variable NOT used):<br/>U-Boot shell:<br/># **reset -w**<br/><br/>**======= Linux: =======**<br/>Kernel Command line: **reboot=warm** <br/>Linux shell: $ **reboot** |


The following table shows the software flow when the SW (U-Boot or Linux) requests a Warm or Cold reset.


| Device | Cold Reset | Warm Reset |
| :-- | :-- | :-- |
| Agilex™ 5 <br>Agilex™ 3 | 1) SW performs a SMC call to ATF.<br>2) SMC handler in ATF sends a reset request to SDM using SDM mailbox.| 1) SW performs a SMC call to ATF.<br>2) SMC handler in ATF sends a reset request to SDM using SDM mailbox. |
| Agilex™ 7 | 1) SW performs a SMC call to ATF.<br>2) SMC handler in ATF sends a reset request to SDM using SDM mailbox. | 1) SW performs a SMC call to ATF.<br>2) SMC handler applies the reset through the Reset Manager. |

## **Known Issues**

None Known

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