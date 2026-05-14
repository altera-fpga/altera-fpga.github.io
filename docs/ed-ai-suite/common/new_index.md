# 1. FPGA AI Suite Design Examples User Guide

The FPGA AI Suite Design Examples User Guide(S) describe the design and implementation for accelerating AI inference using the FPGA AI Suite, Intel® Distribution of OpenVINO™ toolkit, and various development boards (depending on the design example).

## About the FPGA AI Suite Documentation Library

Documentation for the FPGA AI Suite is split across a few publications. Use the following table to find the publication that contains the FPGA AI Suite information that you are looking for:

### Table 1. FPGA AI Suite Documentation Library

| Title and Description | Link |
|----------------------|------|
| **Release Notes**<br>Provides late-breaking information about the FPGA AI Suite including new features, important bug fixes, and known issues. | [Link](https://www.intel.com/content/www/us/en/docs/programmable/772497/2025-3/version-release-notes.html) |
| **Getting Started Guide**<br>Get up and running with the FPGA AI Suite by learning how to initialize your compiler environment and reviewing the various design examples and tutorials provided with the FPGA AI Suite | [Link](https://www.intel.com/content/www/us/en/docs/programmable/768970/2025-1/getting-started-guide.html) |
| **AN 1008: Using the FPGA AI Suite Docker Image**<br>Describes how to install and run the FPGA AI Suite Docker image with a Docker client running on a Microsoft* Windows* system. The containerized FPGA AI Suite enables easy and quick access to the various tools in FPGA AI Suite. | [Link](https://www.intel.com/content/www/us/en/docs/programmable/820119/2025-1/using-the-docker-image-overview.html) |
| **IP Reference Manual**<br>Provides an overview of the FPGA AI Suite IP and the parameters you can set to customize it. This document also covers the FPGA AI Suite IP generation utility. | [Link](https://www.intel.com/content/www/us/en/docs/programmable/768974/2025-1/reference-manual.html) |
| **Compiler Reference Manual**<br>Describes the use modes of the graph compiler (`dla_compiler`). It also provides details about the compiler command options and the format of compilation inputs and outputs. | [Link](https://www.intel.com/content/www/us/en/docs/programmable/768972/2025-1/compiler-reference-manual.html) |
| **Design Examples User Guide**<br>Describes the design and implementation for accelerating AI inference using the FPGA AI Suite, Intel Distribution of OpenVINO toolkit, and various development boards (depending on the design example). | [Link](https://www.intel.com/content/www/us/en/docs/programmable/848957/2025-1/design-examples-user-guide.html) |

# 2. FPGA AI Suite Design Examples

The following is a comprehensive list of the available FPGA AI Suite Design Example User Guides.

## Table 2. FPGA AI Suite Design Examples Descriptions

| Design Example | Description |
|---------------|-------------|
| [PCIe-attach design example](todo) | Demonstrates how OpenVINO toolkit and the FPGA AI Suite support the look-aside deep learning acceleration model.<br><br>This design example targets the Terasic* DE10-Agilex Development Board (DE10-Agilex-B2E2). |
| [OFS PCIe-attach design example](todo) | Demonstrates the OpenVINO toolkit and the FPGA AI Suite that target Open FPGA Stack (OFS)-based boards.<br><br>This design example targets the following Open FPGA Stack (OFS)-based boards:<br>* Agilex™ 7 FPGA I-Series Development Kit ES2 (DK-DEV-AGI027RBES)<br>* Intel FPGA SmartNIC N6001-PL Platform (without Ethernet controller) |
| [Hostless DDR-Free design examples](todo) | Demonstrates hostless DDR-free operation of the FPGA AI Suite IP. Graph filters, bias, and FPGA AI Suite IP configurations are stored in internal memory on the FPGA device.<br><br>This design example targets the Agilex 7 FPGA I-Series Development Kit ES2 (DK-DEV-AGI027RBES). |
| [Hostless JTAG design example](todo) | Demonstrates the step-by-step sequence of configuring FPGA AI Suite IP and starting inference by writing into CSRs directly via JTAG.<br><br>This design example targets the Agilex 5 FPGA E-Series 065B Modular Development Kit (MK-A5E065BB32AES1). |
| [SoC design example](todo) | Demonstrates how OpenVINO toolkit and the FPGA AI Suite support the CPU-offload deep-learning acceleration model in an embedded system.<br><br>The design example targets the following development boards:<br>* Agilex 7 FPGA I-Series Transceiver-SoC Development Kit (DK-SIAGI027FC)<br>* Arria® 10 SX SoC FPGA Development Kit (DK-SOC-10AS066S) |

* For the **Design Example Identifier** column, these entries are the value to use with the FPGA AI Suite Design Example Utility (`dla_build_example_design.py`) command to build the design example

## Table 3. FPGA AI Suite Design Examples Properties Overview

| Example | Design Type | Target FPGA Device | Host | Memory | Stream* | Design Example Identifier | Supported Development Kit |
|---------|-------------|-------------------|------|--------|---------|---------------------------|---------------------------|
| PCIe-Attached | Agilex 7 | External host processor | DDR | M2M | agx7_de10_pcie | [Terasic DE10-Agilex Development Board (DE10-Agilex-B2E2)](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=142&No=1252&PartNo=2#contents) |
| PCIe-Attached|Agilex 7 |External host processor |DDR |M2M | agx7_iseries_ofs_pcie | [Agilex 7 FPGA I-Series Development Kit ES2 (DK-DEV-AGI027RBES)](https://www.altera.com/products/devkit/a1jui0000049utmmam/agilex-7-fpga-i-series-development-kit-2x-r-tile-and-1x-f-tile) |
| PCIe-Attached|Agilex 7 |External host processor |DDR |M2M | agx7_n6001_ofs_pcie | [Intel FPGA SmartNIC N6001-PL Platform (without Ethernet controller)](https://www.intel.com/content/www/us/en/content-details/779620/a-smartnic-for-accelerating-communications-and-networking-workloads.html) |
| Hostless DDR-Free | Agilex 7 | Hostless | DDR-Free | Direct | agx7_iseries_ddrfree | [Agilex 7 FPGA I-Series Development Kit ES2 (DK-DEV-AGI027RBES)](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/agi027.html) |
| Hostless JTAG Attached | Agilex 5 |Hostless | DDR | M2M | agx5e_modular_jtag | [Agilex 5 FPGA E-Series 065B Modular Development Kit (MK-A5E065BB32AES1)](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a5e065b-modular.html) |
| SoC | Agilex 7 | On-device HPS | DDR | M2M and S2M | agx7_soc_m2m<br>agx7_soc_s2m | [Agilex 7 FPGA I-Series Transceiver-SoC Development Kit (DK-SIAGI027FC)](https://www.altera.com/products/devkit/a1jui0000049utnmam/agilex-7-fpga-i-series-transceiver-soc-development-kit-4x-f-tile) |
|SoC | Arria 10 |On-device HPS |DDR |M2M and S2M | a10_soc_m2m<br>a10_soc_s2m | [Arria 10 SX SoC FPGA Development Kit (DK-SOC-10AS066S)](https://www.altera.com/products/devkit/a1jui0000049utgmam/arria-10-sx-soc-development-kit) |
|SoC | Agilex 5 |On-device HPS |DDR |M2M and S2M | agx5_soc_m2m<br>agx5_soc_s2m | [Agilex 5 FPGA E-Series 065B Modular Development Kit (MK-A5E065BB32AES1)](https://www.altera.com/products/devkit/a1jui0000049utbmam/agilex-5-fpga-and-soc-e-series-development-kit-modular) |

**\***For the Stream column, the entries are defined as follows:

**M2M** FPGA AI Suite runtime software running on the external host transfers the image (or data) to the FPGA DDR memory.

**S2M** Streaming input data is copied to FPGA on-device memory. The FPGA AI Suite runtime runs on the FPGA device (HPS or RTL state machine). The runtime is used only to coordinate the data transfer from FPGA DDR memory into the FPGA AI Suite IP.

**Direct** Data is streamed directly in and out of the FPGA on-chip memory.

## 2.1. About the PCIe-Attach Design Example

The FPGA AI Suite PCIe-attach design example (sometimes referred to as the *PCIe-based design example*) demonstrates how the Intel Distribution of OpenVINO toolkit and the FPGA AI Suite support the look-aside deep learning acceleration model.

The PCIe-attach design example is implemented with the following components:

* FPGA AI Suite IP
* Intel Distribution of OpenVINO toolkit
* Terasic DE10-Agilex Development Board
* Sample hardware and software systems that illustrate the use of these components

This design example includes prebuilt FPGA bitstreams that correspond to preoptimized architecture files. However, the design example build scripts let you choose from a variety of architecture files and build (or rebuild) your own bitstreams, provided that you have a license permitting bitstream generation.

This design is provided with the FPGA AI Suite as an example showing how to incorporate the IP into a design. This design is not intended for unaltered use in production scenarios. Any potential production application that uses portions of this example design must review them for both robustness and security.

The following sections in this document describe the steps to build and execute the design:

* [Building the FPGA AI Suite Runtime](todo)
* [Running the Design Example Demonstration Applications](todo)

The following sections in this document describe design decisions and architectural details about the design:

* [Design Example Components](todo)

Use this document to help you understand how to create a PCIe example design with the targeted FPGA AI Suite architecture and number of instances and compiling the design for use with the Intel FPGA Basic Building Blocks (BBBs) system.

## 2.2. About the Open FPGA Stack (OFS) for PCIe-Attach Design Examples

The FPGA AI Suite Open FPGA Stack (OFS) for PCIe-attach design examples demonstrate the design and implementation for accelerating AI inference using the FPGA AI Suite, Intel Distribution of OpenVINO toolkit, and boards that support Agilex 7 PCIe Attach OFS:

* Agilex 7 FPGA I-Series Development Kit ES2 (DK-DEV-AGI027RBES)
* Intel FPGA SmartNIC N6001-PL Platform (without Ethernet controller)

**Tip:** N6001-PL SmartNIC boards are available through ODM partners. For more information, including ordering information, refer to the [SmartNIC N6000-PL product brief](https://cdrdv2-public.intel.com/779620/fpga-smartnic-n6000-pl-platform-product-brief.pdf).

Use this document to help you understand how to create the OFS for PCIe-attach design example with the targeted FPGA AI Suite architecture and number of instances and compiling the design for use with the Intel FPGA Basic Building Blocks (BBBs) system.

The following sections in this document describe the steps to build and execute the design:

* [Getting Started with Open FPGA Stack (OFS) for PCIe-Attach Design Examples](todo)

The following sections in this document describe design decisions and architectural details about the design:

* [Design Example Components](todo)

## 2.3. About the Hostless DDR-Free Design Example

The FPGA AI Suite provides a design example to demonstrate hostless and DDR-free operation of the FPGA AI Suite IP. Graph filters, bias, and FPGA AI Suite IP configurations are stored in on-chip memory on the FPGA device instead of DDR memory on the board.

The DDR-free design example demonstrates how FPGA AI Suite supports the following features:

* DDR-free operation
* Hostless operation (that is, running on the devices without the FPGA AI Suite runtime)
* Streaming of input features
* Streaming of inference results

The DDR-Free design example is implemented with the following components:

* FPGA AI Suite IP
* Agilex 7 FPGA I-Series Development Kit ES2 (DK-DEV-AGI027RBES)
* Sample hardware and software systems that illustrate the use of these components

For more details about DDR-free operation, refer to [DDR-Free Operation](https://www.intel.com/content/www/us/en/docs/programmable/768974/2025-1/ddr-free-operation.html) in the [FPGA AI Suite IP Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/768974/2025-1/reference-manual.html).

The design example build scripts in [Building the FPGA AI Suite Runtime]() let you choose from a variety of architecture files and build your own bitstreams, provided that you have a license permitting bitstream generation.

This design is provided with the FPGA AI Suite as an example showing how to incorporate the FPGA AI Suite IP into a DDR-Free design. This design is not intended for unaltered use in production scenarios. Any potential production application that uses portions of this design example must be reviewed for both robustness and security.

The following sections in this document describe the steps to build and execute the design:

* [Getting Started with the FPGA AI Suite DDR-Free Design Example](todo)
* [Running the Hostless DDR-Free Design Example](todo)

The following sections in this document describe design decisions and architectural details about the design:

* [Design Example System Architecture](todo)
* [Quartus Prime System Console](todo)
* [JTAG to Avalon MM Host Register Map](todo)
* [Updating MIF Files](todo)

## 2.4. About the Hostless JTAG Design Example

The hostless JTAG design example example demonstrates how to instantiate one instance of the FPGA AI Suite IP on an Agilex 5 E-Series device or Agilex 3 C-Series device.

It places configurations and data on external DDR memory and allows an external host to interact with the memory and FPGA AI Suite IP via JTAG.

This design example targets the Agilex 5 FPGA E-Series 065B Modular Development Kit (MK-A5E065BB32AES1) or Agilex 3 FPGA C-Series Development Kit (A3CY135BM16AE6S).

The following sections in this document describe the steps to build and execute the design:

* [Getting Started with HL-JTAG](todo)

The following sections in this document describe design decisions and architectural details about the design:

* [Design Example Componentsfor HL-JTAG](todo)

## 2.5. About the SoC Design Example

The FPGA AI Suite SoC design example shows how the Intel Distribution of OpenVINO toolkit and the FPGA AI Suite support the CPU-offload deep learning acceleration model in an embedded system

The SoC design examples are implemented with the following components:

* FPGA AI Suite IP
* Intel Distribution of OpenVINO toolkit
* The community-supported OpenVINO ARM plugin
* Sample hardware and software systems that illustrate the use of these components
* Arm*-Linux build scripts built using Yocto frameworks for the hard processor systems (HPSs) on the following FPGA SoC devices:
  - Agilex 5 E-Series SoC
  - Agilex 7 I-Series SoC
  - Arria 10 SX SoC

For an easier initial experience, these design examples include prebuilt FPGA bitstreams and a Linux-compiled system image that correspond to pre-optimized FPGA AI Suite architecture files.

You can copy this disk-image to an SD card and insert the card into a supported FPGA development kit. Additionally, you can use the design example scripts to choose from a variety of architecture files and build (or rebuild) your own bitstreams, subject to IP licensing limitations.

The following sections in this document describe the steps to build and execute the design:

* [FPGA AI Suite SoC Design Example Quick Start Tutorial](todo)
* [FPGA AI Suite SoC Design Example Run Process](todo)

The following sections in this document describe design decisions and architectural details about the design:

* [FPGA AI Suite SoC Design Example Build Process](todo)
* [FPGA AI Suite SoC Design Example Quartus Prime System Architecture](todo)
* [FPGA AI Suite SoC Design Example Software Components](todo)
* [Streaming-to-Memory (S2M) Streaming Demonstration](todo)

Use this document to help you understand how to create a SoC example design with the targeted FPGA AI Suite architecture.

### SoC Design Example Execution Models

The SoC design example has two execution models:

* **Memory-to-memory (M2M) execution model**, which provides a dla_benchmark interface to the inference engine, similar to the PCIe-based design examples.

For design details, refer to the [SoC Memory-to-Memory (M2M) Variant Design](todo).

* **Streaming-to-memory (S2M) execution model** that demonstrates a streaming data source

For simplicity in this design example, the streaming data source is the SoC ARM CPU itself, which streams to a layout transform on the FPGA, but this design illustrates one of the suggested system architectures for any streaming source.

For design details, refer to the [SOC Streaming-to-Memory (S2M) Variant Design](todo).

The design example is typically compiled for the S2M execution model, which supports both the M2M and S2M modes. A reduced functionality bitstream is also included as a compilation option, which supports only the M2M execution model.

The SoC design example has been optimized for simplicity, to create a flexible foundation that you can use to build more complex SoC designs.