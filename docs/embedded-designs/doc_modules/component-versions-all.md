Altera&reg; Quartus<sup>&reg;</sup> Prime Pro Edition Version 26.3 and the following software component versions integrate the 26.3 release. 

**Note:** Regarding the Hardware Design components in the following table, only the device-specific one is used in this page.

| Component                             | Location                                                     | Branch                       | Commit ID/Tag       |
| :------------------------------------ | :----------------------------------------------------------- | :--------------------------- | :------------------ |
| Agilex 27 Design  | [https://github.com/altera-fpga/agilex27-ed-hps-baseline](https://github.com/altera-fpga/agilex27-ed-hps-baseline)|           main           | QPDS26.3_REL_BASELINE_PR |
| Agilex 3 Hardware Design | [https://github.com/altera-fpga/agilex3c-ed-gsrd](https://github.com/altera-fpga/agilex3c-ed-gsrd)    | main  | QPDS26.3_REL_BASELINE_PR |
| Agilex 5 Hardware Design - Include HPS Baseline System Example Design 2.0 baseline design + meta_custom | [https://github.com/altera-fpga/agilex5-ed-hps-baseline](https://github.com/altera-fpga/agilex5-ed-hps-baseline) | main | QPDS26.3_REL_BASELINE_PR |
| Agilex 7 Hardware Design          | [https://github.com/altera-fpga/agilex7-ed-hps-baseline](https://github.com/altera-fpga/agilex7-ed-hps-baseline) | main | QPDS26.3_REL_BASELINE_PR |
| Stratix 10 Hardware Design         | [https://github.com/altera-fpga/stratix10-ed-hps-baseline](https://github.com/altera-fpga/stratix10-ed-hps-baseline) | main | QPDS26.3_REL_BASELINE_PR |
| Arria 10 Hardware Design          | [https://github.com/altera-fpga/arria10-ed-hps-baseline](https://github.com/altera-fpga/arria10-ed-hps-baseline)  | main | QPDS26.3_REL_BASELINE_PR |
| Linux                                 | [https://github.com/altera-fpga/linux-socfpga](https://github.com/altera-fpga/linux-socfpga) | socfpga-6.18.37-lts | QPDS26.3_REL_BASELINE_PR |
| Arm Trusted Firmware                  | [https://github.com/altera-fpga/arm-trusted-firmware](https://github.com/altera-fpga/arm-trusted-firmware) | socfpga_v2.15.0   | QPDS26.3_REL_BASELINE_PR |
| U-Boot                                | [https://github.com/altera-fpga/u-boot-socfpga](https://github.com/altera-fpga/u-boot-socfpga) | socfpga_v2026.07 | QPDS26.3_REL_BASELINE_PR |
| Yocto Project                         | [https://git.yoctoproject.org/poky](https://git.yoctoproject.org/poky) | wrynose | latest              |
| Yocto Project: meta-altera-fpga (for HPS Baseline System Example Design 2.0) | [https://github.com/altera-fpga/meta-altera-fpga](https://github.com/altera-fpga/meta-altera-fpga) | wrynose | QPDS26.3_REL_BASELINE_PR |
| Yocto Project: meta-intel-fpga (for HPS Legacy System Example Design) | [https://git.yoctoproject.org/meta-intel-fpga](https://git.yoctoproject.org/meta-intel-fpga) | wrynose | latest |
| Yocto Project: meta-intel-fpga-refdes (for HPS Legacy System Example Design) | [https://github.com/altera-fpga/meta-intel-fpga-refdes](https://github.com/altera-fpga/meta-intel-fpga-refdes) | wrynose | QPDS26.3_REL_BASELINE_PR |
| HPS Legacy System Example Design | [https://github.com/altera-fpga/gsrd-socfpga](https://github.com/altera-fpga/gsrd-socfpga) | wrynose | QPDS26.3_REL_BASELINE_PR |
| KAS | [https://github.com/siemens/kas/](https://github.com/siemens/kas/) | master | 5.4 |

**Note:** The combination of the component versions indicated in the table above has been validated through the use cases described in this page and it is strongly recommended to use these versions together. If you decided to use any component with different version than the indicated, there is not warranty that this will work.

**Note:** Starting from 26.3 Quartus release, the build of the Quartus projects in the System Example Designs are based only on Visual Designer Studio (VDS).<br>
Please review the following KDB if you face Quartus design build problems when the RTL was generated with VDS:<br>
[Why do Quartus® Prime Pro 26.3 and earlier fail to build a Agilex® 5/Agilex® 3/Agilex® 7 FPGA M-Series VDS based design whose RTL has been generated with VDS?](https://community.altera.com/kb/knowledge-base/why-do-quartus%C2%AE-prime-pro-26-3-and-earlier-fail-to-build-a-agilex%C2%AE-5agilex%C2%AE-3agi/357511).