# FPGA AI Suite Example Designs

The table below contains a comprehensive list of example designs which have been developed to showcase the FPGA AI Suite that are available in the FPGA AI Suite Example Design repository:

| **Design Name** | Device Family | Repository Link |
| :-------:|:-----------------:|:----------:|
| Agilex 5 Hostless JTAG Example Design                                                 |Agilex 5|[Repo Link](https://github.com/altera-fpga/agilex-ed-ai-suite/tree/main/agilex5/modular_jtag)| 
| Agilex 7 PCIe-Attached Example Design (DE10)                                          |Agilex 7|[Repo Link](https://github.com/altera-fpga/agilex-ed-ai-suite/tree/main/agilex7/de10_pcie)|
| Agilex 7 PCIe-Attached Example Design with OFS (I-Series, 2x R-Tile and 1x F-Tile)    |Agilex 7|[Repo Link](https://github.com/altera-fpga/agilex-ed-ai-suite/tree/main/agilex7/iseries_ofs_pcie)|
| Agilex 7 PCIe-Attached Example Design with OFS (N6001)                                |Agilex 7|[Repo Link](https://github.com/altera-fpga/agilex-ed-ai-suite/tree/main/agilex7/n6001_ofs_pcie)| 

The [FPGA AI Suite Example Design](https://github.com/altera-fpga/agilex-ed-ai-suite) repo contains a set of configured example designs that demonstrate
different features of the [FPGA AI Suite](https://www.intel.com/content/www/us/en/products/details/fpga/development-tools/fpga-ai-suite.html).
The FPGA AI Suite is a collection of tools for efficiently running AI inference
on Altera FPGAs.  The examples in this repo cover the different development
boards, connectivity types, and FPGA families that the AI Suite supports.

This repository does not contain the totality of FPGA AI Suite Documentation; other topics of interest include building Yocto images for SoC designs, an explanation of the various components of the FPGA AI Suite, architectural overviews, a generalized Getting Started flow and more. This comprehensive document can be downloaded from the web at [FPGA AI Suite: Design Examples User Guide](https://cdrdv2-public.intel.com/848958/fpga-ai-suite-design-examples-user-guide-848957-848958.pdf). You can also browse the [FPGA AI Suite](https://www.intel.com/content/www/us/en/products/details/fpga/development-tools/fpga-ai-suite.html) web page for more information.

Each example will walk you through a standard workflow to demonstrate how to
use to the AI Suite to:

* Compile the AI Suite IP into an FPGA bitstream.
* Program an FPGA with the AI Suite IP bitstream.
* Prepare an AI model graph for inference.
* Run inference on an FPGA using a benchmark dataset.

You may obtain a copy of the FPGA AI Suite from the
[official downloads page](https://www.intel.com/content/www/us/en/products/details/fpga/development-tools/fpga-ai-suite/resource.html).

> [!IMPORTANT]
> All examples have a hard limit of 10'000 inference requests.  Please
> refer to the documentation on
> ["--licensed/--unlicensed" IP generation](https://www.intel.com/content/www/us/en/docs/programmable/768974/2025-1/ip-generation-utility-command-line-options.html)
> for details about this limitation.

Full details on how to install the FPGA AI Suite, including all software and
hardware requirements, are available in
[Chapter 4](https://www.intel.com/content/www/us/en/docs/programmable/768970/2025-1/installing-the-compiler-and-ip-generation.html)
of the [Getting Started Guide](https://www.intel.com/content/www/us/en/docs/programmable/768970/2025-1/getting-started-guide.html).
The individual READMEs for each example also contain any additional requirements
and setup instructions that are particular to that example.

## Example Designs

### Hostless

Hostless example designs demonstrate how to directly control the FPGA AI Suite
IP over JTAG.

| Family | Development Board |
| ------ | ----------------- |
| Agilex 5 | [Agilex 5E Modular Development Kit](https://github.com/altera-fpga/agilex-ed-ai-suite/tree/main/agilex5/modular_jtag) |

### PCIe-attach

PCIe-attach example designs demonstrate how a host computer can use the FPGA AI
Suite to offload AI workloads onto an FPGA via PCIe.

| Family | Development Board |
| ------ | ----------------- |
| Agilex 7 | [Terasic DE10-Agilex Development Board](https://github.com/altera-fpga/agilex-ed-ai-suite/tree/main/agilex7/de10_pcie) |
| Agilex 7 | [Agilex 7 FPGA I-Series Development Kit (2x R-Tile and 1x F-Tile)](https://github.com/altera-fpga/agilex-ed-ai-suite/tree/main/agilex7/iseries_ofs_pcie) |
| Agilex 7 | [Intel FPGA SmartNIC N6001-PL Platform (without an Ethernet controller)](https://github.com/altera-fpga/agilex-ed-ai-suite/tree/main/agilex7/n6001_ofs_pcie) |

## Documentation

* [Using the OpenVINO Open Model Zoo](../common/using-model-zoo.md)
