# ${{ env_local.PROJECT_TITLE }}

The design is compatible with
[Altera® Quartus® Prime Pro Edition version ${{env_local.COMMON_MIPI_QUARTUS_VER}} Linux].

## Overview

The ${{env_local.PROJECT_TITLE}} demonstrates an implementation of using industry-standard Mobile Industry Processor Interface (MIPI) D-PHY and MIPI CS1-2 interface on Agilex™ 5 FPGAs to integrate to a Holoscan processing flow.

The MIPI interface supports up to ${{env_local.MAX_MIPI_RATE}}Gbps per lane and up to 8x lanes per MIPI
interface, enabling seamless data reception from multiple 4K image sensors to
the FPGA fabric for further processing. Each MIPI CSI-2 IP instance converts
pixel data to AXI4-Streaming outputs, enabling connectivity to other IP cores
within Altera's Video and Vision Processing (VVP) Suite.

The FPGA design comprises a MIPI D-PHY and MIPI CSI-2 interface connected to an ${{env_local.COMMOM_NVIDIA}} Holoscan Sensor Bridge IP and Altera's ${env_local.MAC_IP_NAME}.

The software comprises a number of demonstration applications running within [${{env_local.COMMOM_NVIDIA}} Holoscan Sensor Bridge SDK](${{env_local.COMMON_MIPI_ALTERA_HSB_REPO}}).

<br/>

![Block diagram showing the HSB MIPI to ${{env_local.ETHERNET_RATE}} system architecture with MIPI camera input connecting through D-PHY and CSI-2 interfaces to FPGA fabric, then through Holoscan Sensor Bridge IP and ${{env_local.MAC_IP_NAME}} to network output](${{env_local.PROJECT_BLOCK_DIAGRAM}}){:style="display:block; margin-left:auto; margin-right:auto; width: 80%"}
<center markdown="1">

**High-Level Block Diagram of the Holoscan Sensor Bridge System Example Design**
</center>

## Example design build and run instructions can be found [here](${{env_local.COMMON_MIPI_ALTERA_HSB_REPO}/${{env_local.PROJECT_REPO}})

* [Example design instructions](${{env_local.COMMON_MIPI_ALTERA_HSB_REPO}/${{env_local.PROJECT_REPO}})


## Useful User Manuals and Reference Materials
* [${{env_local.DEVKIT_NAME}}].