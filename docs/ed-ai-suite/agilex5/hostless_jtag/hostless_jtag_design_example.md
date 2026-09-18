

# 1.0 FPGA AI Suite JTAG System Example Design

The FPGA AI Suite Design Example User Guides describe the design and implementation for accelerating AI inference using the FPGA AI Suite, Intel® Distribution of OpenVINO™ toolkit, and various development boards (depending on the design example). They share a common introduction between each document, which serves as an introduction to the material. Section 4.0 begins the ED specific material.

## About the FPGA AI Suite Documentation Library

Documentation for the FPGA AI Suite is split across a few publications. Use the following table to find the publication that contains the FPGA AI Suite information that you are looking for:

### Table 1. FPGA AI Suite Documentation Library

| Title and Description | Link |
|----------------------|------|
| **Release Notes**<br>Provides late-breaking information about the FPGA AI Suite including new features, important bug fixes, and known issues. | [Link](https://docs.altera.com/r/docs/772497/2026.1.1/fpga-ai-suite-version-2026.1.1-release-notes/fpga-ai-suite-version-2026.1.1-release-notes) |
| **FPGA AI Suite Handbook**<br>Get up and running with the FPGA AI Suite by learning how to initialize your compiler environment and reviewing the various design examples and tutorials provided with the FPGA AI Suite <br>Describes the use modes of the graph compiler (`dla_compiler`). It also provides details about the compiler command options and the format of compilation inputs and outputs. | [Link](https://docs.altera.com/r/docs/863373/2026.1.1/fpga-ai-suite-handbook/fpga-ai-suite-handbook) |

# 2.0 FPGA AI Suite Design Examples

The following is a comprehensive list of the available FPGA AI Suite Design Example User Guides.

## Table 2. FPGA AI Suite Design Examples Descriptions

| Design Example | Description |
|---------------|-------------|
| [PCIe-attach design example](https://altera-fpga.github.io/rel-26.1/ed-ai-suite/agilex7/pcie/pcie_getting_started_extended/) | Demonstrates how OpenVINO toolkit and the FPGA AI Suite support the look-aside deep learning acceleration model.<br><br>This design example targets the Terasic* DE10-Agilex™ Development Board (DE10-Agilex-B2E2). |
| [OFS PCIe-attach design example](https://altera-fpga.github.io/rel-26.1/ed-ai-suite/agilex7/ofs/ofs_pcie_getting_started) | Demonstrates the OpenVINO toolkit and the FPGA AI Suite that target Open FPGA Stack (OFS)-based boards.<br><br>This design example targets the following Open FPGA Stack (OFS)-based boards:<br>* Agilex™ 7 FPGA I-Series Development Kit ES2 (DK-DEV-AGI027RBES)<br>* Silicom FPGA SmartNIC N6001-PL Platform (without Ethernet controller) |
| [Hostless DDR-Free design examples](https://altera-fpga.github.io/rel-26.1/ed-ai-suite/agilex7/hostless_ddr_free_ed/hostless_ddr_free_design_example) | Demonstrates hostless DDR-free operation of the FPGA AI Suite IP. Graph filters, bias, and FPGA AI Suite IP configurations are stored in internal memory on the FPGA device.<br><br>This design example targets the Agilex™ 7 FPGA I-Series Development Kit ES2 (DK-DEV-AGI027RBES). |
| [Hostless JTAG design example](https://altera-fpga.github.io/rel-26.1/ed-ai-suite/agilex5/hostless_jtag/hostless_jtag_design_example) | Demonstrates the step-by-step sequence of configuring FPGA AI Suite IP and starting inference by writing into CSRs directly via JTAG.<br><br>This design example targets the Agilex™ 5 FPGA E-Series 065B Modular Development Kit (MK-A5E065BB32AES1). |
| [SoC design example](https://altera-fpga.github.io/rel-26.1/ed-ai-suite/agilex5/soc/fpga_ai_suite_soc_design_example) | Demonstrates how OpenVINO toolkit and the FPGA AI Suite support the CPU-offload deep-learning acceleration model in an embedded system.<br><br>The design example targets the following development boards:<br>* Agilex™ 3 FPGA and SoC C-Series Development Kit (DK-A3W135BM16AEA)<br>* Agilex™ 5 FPGA E-Series 065B Modular Development Kit (MK-A5E065BB32AES1)<br>* Agilex™ 7 FPGA I-Series Transceiver-SoC Development Kit (DK-SIAGI027FC)<br>* Arria® 10 SX SoC FPGA Development Kit (DK-SOC-10AS066S) |

## Table 3. FPGA AI Suite Design Examples Properties Overview

| Example | Design Type | Target FPGA Device | Host | Memory | Stream* | Design Example Identifier** | Supported Development Kit |
|---------|-------------|-------------------|------|--------|---------|---------------------------|---------------------------|
| PCIe-Attached | Agilex™ 7 | External host processor | DDR | M2M | agx7_de10_pcie | [Terasic DE10-Agilex™ Development Board (DE10-Agilex™-B2E2)](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=142&No=1252) |
| PCIe-Attached| Agilex™ 7 |External host processor |DDR |M2M | agx7_iseries_ofs_pcie | [Agilex™ 7 FPGA I-Series Development Kit ES2 (DK-DEV-AGI027RBES)](https://www.altera.com/products/devkit/a1jui0000049utmmam/agilex-7-fpga-i-series-development-kit-2x-r-tile-and-1x-f-tile) |
| PCIe-Attached|Agilex™ 7 |External host processor |DDR |M2M | agx7_n6001_ofs_pcie | [Silicom FPGA SmartNIC N6001-PL Platform (without Ethernet controller)](https://www.altera.com/asap/offering/po-2750/silicom-fpga-smartnic-n60106011-n6001-pln6000-pl-arrow-creek) |
| Hostless DDR-Free | Agilex™ 7 | Hostless | DDR-Free | Direct | agx7_iseries_ddrfree | [Agilex™ 7 FPGA I-Series Development Kit ES2 (DK-DEV-AGI027RBES)](https://www.altera.com/products/devkit/po-3012/agilex-7-fpga-i-series-development-kit-2x-r-tile-and-1x-f-tile) |
| Hostless JTAG Attached | Agilex™ 5 |Hostless | DDR | M2M | agx5e_modular_jtag | [Agilex™ 5 FPGA E-Series 065B Modular Development Kit (MK-A5E065BB32AES1)](https://www.altera.com/products/devkit/po-3274/agilex-5-fpga-and-soc-e-series-065b-modular-development-kit) |
|SoC | Agilex™ 3 |On-device HPS |DDR |M2M | agx3_soc_m2m<br> | [Agilex™ 3 FPGA and SoC C-Series Development Kit (DK-A3W135BM16AEA)](https://www.altera.com/products/devkit/po-3000/agilex-3-fpga-and-soc-c-series-development-kit) |
|SoC | Agilex™ 5 |On-device HPS |DDR |M2M and S2M | agx5_soc_m2m<br>agx5_soc_s2m | [Agilex™ 5 FPGA E-Series 065B Modular Development Kit (MK-A5E065BB32AES1)](https://www.altera.com/products/devkit/po-3274/agilex-5-fpga-and-soc-e-series-065b-modular-development-kit) |
| SoC | Agilex™ 7 | On-device HPS | DDR | M2M and S2M | agx7_soc_m2m<br>agx7_soc_s2m | [Agilex™ 7 FPGA I-Series Transceiver-SoC Development Kit (DK-SIAGI027FC)](https://www.altera.com/products/devkit/po-3013/agilex-7-fpga-i-series-transceiver-soc-development-kit-4x-f-tile) |
|SoC | Arria® 10 |On-device HPS |DDR |M2M and S2M | a10_soc_m2m<br>a10_soc_s2m | [Arria® 10 SX SoC FPGA Development Kit (DK-SOC-10AS066S)](https://www.altera.com/products/devkit/po-3006/arria-10-sx-soc-development-kit) |

\*For the **Design Example Identifier** column, these entries are the value to use with the FPGA AI Suite Design Example Utility (`dla_build_example_design.py`) command to build the design example

\*\*For the Stream column, the entries are defined as follows:

**M2M** FPGA AI Suite runtime software running on the external host transfers the image (or data) to the FPGA DDR memory.

**S2M** Streaming input data is copied to FPGA on-device memory. The FPGA AI Suite runtime runs on the FPGA device (HPS or RTL state machine). The runtime is used only to coordinate the data transfer from FPGA DDR memory into the FPGA AI Suite IP.

**Direct** Data is streamed directly in and out of the FPGA on-chip memory.

# 3.0 Shared Design Example Components

## 3.1. FPGA AI Suite Design Example Utility

The main entry point into the example design build system is the FPGA AI Suite design example utility (`dla_build_example_design.py`). This utility coordinates different aspects of building a design example, from the initial project configuration to extracting area metrics after a compile completes. With this utility, you can create bitstreams from custom AI Suite IP architecture files and with a configurable number of instances.

*Note: There is no '.py' extension on `dla_build_example_design` when using the FPGA AI Suite on Windows.*

To use the FPGA AI Suite design example build utility, ensure that your local development environment has been setup according to the steps in ["Installing FPGA AI Suite Compile and IP Generation Tools" in FPGA AI Suite Handbook](https://docs.altera.com/r/docs/863373/2026.1.1/fpga-ai-suite-handbook/installing-the-fpga-ai-suite-compiler-and-ip-generation-tools).

### 3.1.1. The `dla_build_example_design.py` Command

The FPGA AI Suite design example utility (`dla_build_example_design.py`) configures and compiles the bitstreams for the FPGA AI Suite design examples. The command has the following basic syntax:

```
dla_build_example_design.py [--logfile logfile] [--debug] [action]
```

where [action] is one of the following actions:

#### Table 4. Design Example Utility Actions

| Action | Description |
|--------|-------------|
| `list` | List the available example designs. |
| `build` | Build an example design. |
| `qor` | Generate QoR reports. |
| `quartus-compile` | Run a Quartus® Prime compile. |
| `scripts` | Managed the build support scripts. |

Some of the command actions have different additional required and optional parameters. Use the command `help` to see a list of available options for the command and its actions.

By default, the `dla_build_example_design.py` command always instructs the `dla_create_ip` command to create licensed IP. If no license can be found, inference-limited, unlicensed RTL is generated. The build log indicates if the IP is licensed or unlicensed. For more information about licensed and unlicensed IP, refer to ["The --unlicensed/--licensed Options" in FPGA AI Suite IP Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/863373/2025-3/ip-generation-utility-outputs.html).

#### Getting `dla_build_example_design.py` Command Help

For general help with the command and to see the list of available actions, run the following command:

```
dla_build_example_design.py --help
```

For help with a command actions and to the list of available options and arguments required for an action, run the following command:

```
dla_build_example_design.py action --help
```

#### Command Logging and Debugging

By default, the FPGA AI Suite design example utility logs its output to a set location in the (default) `build_platform` directory. Override this location by specifying the `--logfile` *logfile* option.

For extra debugging output, specify the `--debug` option.

Both the logging and debugging options must be specified before the command action.

### 3.1.2. Listing Available FPGA AI Suite Design Examples

To list the available FPGA AI Suite design examples, run the following command:

```
dla_build_example_design.py list
```

This command shows the design example identifiers (used with the build action of the design example utility) along with a short description of the design example and its target Quartus Prime version.

A list of the design examples and their identifiers is also available in [FPGA AI Suite Design Examples Properties Overview](#table-3-fpga-ai-suite-design-examples-properties-overview).

### 3.1.3. Building FPGA AI Suite Design Examples

To build FPGA AI Suite design examples, specify the build option of the design example utility.

In the most simple case of building a design example for an existing architecture, you can build a design example with the following command:

```
dla_build_example_design.py build \
<design_example_identifier> \
<architecture file>
```

For example, use the following command to build the Agilex™ 7 PCIe-based design example that targets the **DE10-Agilex-B2E2** board using the AGX7_Generic architecture:

```
dla_build_example_design.py build \
agx7_de10_pcie \
$COREDLA_ROOT/example_architectures/AGX7_Generic.arch
```

The default build directory is `build_platform`. The utility creates the folder if it does not exist. To specify a different build directory, specify the `--output-dir <directory>` option:

```
dla_build_example_design.py build \
--output-dir <directory> \
<design_example_identifier> \
<architecture file>
```

Be default, the utility also prevents the build directory from being overwritten. You can override this behavior with the `--force` option.

After the build is complete, the build directory has the following files and folders:

* **coredla_ip/**
This folder contains the RTL for the configured FPGA AI Suite IP.

* **hw/**
This folder contains the Quartus Prime or Open FPGA Stack (OFS) project files. It also includes its own self-contained copy of the contents of the `coredla_ip/` folder

* **.build.json**
This contents of this file (sometimes referred to as the "build context" file) allow the build to be split into multiple steps.

* **Reports**
The build directory will contain any log files generated by the build utility (such as `build.log`) and the QoR summary that is generated by a successful compilation.

* **Bitstreams**
This build directory will contain the bitstreams to program the target FPGA device as follows:
  - For OFS-based designs, `.gbs` files.
  - For other designs, `.sof` and `.rbf` files.

#### 3.1.3.1. Staging FPGA AI Suite Design Example Builds

The FPGA AI Suite design example utility supports staged builds via the `--skip-compile` option. When you specify this option, the utility creates the build folder and prepares the Quartus Prime or Open FPGA Stack (OFS) project but does not run compilation.

With a staged design example build flow, you must run the utility a few times to generate the same outputs as the regular build flow. For a complete build with a staged build flow, you would run the following commands:

```
dla_build_example_design.py build --skip-compile \
<design_example_identifier> \
<architecture file>
dla_build_example_design.py quartus-compile build_platform
# Optional: Generate QoR summary
dla_build_example_design.py qor build_platform
```

Information about the build configuration, namely what was passed into the `dla_build_example_design.py` build command, is stored inside of the build context (`.build.json`) file.

You can run the `dla_build_example_design.py quartus-compile` and `dla_build_example_design.py qor` commands multiple times. An example of when running these commands multiple times can be useful is when you have to recompile the bitstream after removing an unnecessary component from the design example.

You can also directly call the design compilation script. An FPGA AI Suite design example uses one of the following scripts, depending on whether the design example can built in a WSL 2 environment:

* **generate_sof.tcl**
Design examples with this design compilation script can be built in a WSL 2 environment.

* **build_project.sh**
Design examples with this design compilation script cannot be built in a WSL 2 environment.

If a design example uses a `generate_sof.tcl` script, then you can invoke the design compilation script either after opening the design example project in Quartus Prime or by running the following command:

```
quartus_sh -t generate_sof.tcl
```

If a design example uses the `build_project.sh` build script, the script must be executed in a Bash-compatible shell. For example:

```
bash build_project.sh
```

For both design example compilation scripts, the current working directory must be the `hw/` directory.

#### 3.1.3.2. WSL 2 FPGA AI Suite Design Example Builds

Staged builds allow the build utility to support hybrid Windows/Linux compilation in a WSL 2 environment on a Windows system. In a WSL 2 environment, FPGA AI Suite is installed in the WSL 2 Linux guest operating system while Quartus Prime is installed in the Windows host operating system.

**Restriction:** Only a subset of the FPGA AI Suite design examples can be build in a WSL 2 environment. For a list of design examples that support WSL 2, run the following command:

```
dla_build_example_design.py list --supports-wsl2
```

When you run the `dla_build_example_design.py` build command, the WSL 2 flow is enabled with the `--wsl` option. This option tells the utility to resolve the path to the build directory as a Windows file path instead of a Linux file path. The utility displays messages that provide you with more details about how to use the staged build commands to complete the compilation in your WSL 2 environment.

**Important:** If you specify a build directory in a WSL 2 environment with the `--output-dir` options, that build directory must be a relative path. This requirement is due to a limitation in how the WSL 2 environment maps paths between the Linux guest and Windows.

## 3.2. Example Architecture Bitstream Files

The FPGA AI Suite provides example Architecture Files and bitstreams for the design examples. The files are located in the FPGA AI Suite installation directory.

## 3.3. Design Example Software Components

The design examples contain a sample software stack for the runtime flow.

For a typical design example, the following components comprise the runtime stack:

* OpenVINO Toolkit (Inference Engine, Heterogeneous Plugin)
* FPGA AI Suite runtime plugin
* Vendor-provided FPGA board driver or OPAE driver (depending on the design example)

The design example contains the source files and Makefiles to build the FPGA AI Suite runtime plugin. The OpenVINO component (and OPAE components, where used) is external and must be manually preinstalled.

A separate flow compiles the AI network graph using the FPGA AI Suite compiler, as shown in [Figure 1 Software Stacks for FPGA AI Suite Inference](#figure-1-software-stacks-for-fpga-ai-suite-inference) that follows as the Compilation Software Stack.

The compilation flow output is a single binary file called `CompiledNetwork.bin` that contains the compiled network partitions for FPGA and CPU devices along with the network weights. The network is compiled for a specific FPGA AI Suite architecture and batch size. This binary is created on-disk only when using the Ahead-Of-Time flow; when the JIT flow is used, the compiled object stays in-memory only.

An Architecture File describes the FPGA AI Suite IP architecture to the compiler. You must specify the same Architecture File to the FPGA AI Suite compiler and to the FPGA AI Suite design example utility (`dla_build_example_design.py`).

The runtime flow accepts the `CompiledNetwork.bin` file as the input network along with the image data files.

### Figure 1. Software Stacks for FPGA AI Suite Inference

![alt text](../../doc_modules/images/image.png)

The runtime stack cannot program the FPGA with a bitstream. To build a bitstream and program the FPGA devices:

1. Compile the design example.
2. Program the device with the bitstream.

Instructions for these steps are provided in the sections for each design example.

To run inference through the OpenVINO Toolkit on the FPGA, set the OpenVINO device configuration flag (used by the heterogeneous Plugin) to `FPGA` or `HETERO:FPGA,CPU`.

### 3.3.1. OpenVINO FPGA Runtime Overview

The purpose of the runtime front end is as follows:

* Provide input to the FPGA AI Suite IP
* Consume output from the FPGA AI Suite IP
* Control the FPGA AI Suite IP

Typically, this front-end layer provides the following items:

* The `.arch` file that was used to configure the FPGA AI Suite on the FPGA.
* The ML model (possibly precompiled into an Ahead-of-Time `.bin` file by the FPGA AI Suite compiler (`dla_compiler`)).
* A target device that is passed to OpenVINO

The target device may instruct OpenVINO to use the HETERO plugin, which allows a graph to be partitioned onto multiple devices.

One of the directories provided in the installation of the FPGA AI Suite is the `runtime/` directory. In this directory, the FPGA AI Suite provides the source code to build a selection of OpenVINO applications. The `runtime/` directory also includes the `dla_benchmark` command line utility that you can use to generate inference requests and benchmark the inference speed.

The following applications use the OpenVINO API. They support the OpenVINO HETERO plugin, which allows portions of the graph to fall-back onto the CPU for unsupported graph layers.

* `dla_benchmark` (adapted from OpenVINO benchmark_app)
* `classification_sample_async`
* `object_detection_demo_yolov3_async`
* `segmentation_demo`

Each of these applications serve as a runtime executable for the FPGA AI Suite. You might want to write your own OpenVINO-based front ends to wrap the FPGA plugin. For information about writing your own OpenVINO-based front ends, refer to the [OpenVINO documentation](https://docs.openvino.ai/2025/index.html).

Some of the responsibilities of the OpenVINO FPGA plugin are as follows:

* **Inference Execution**
  - Mapping inference requests to an IP instance and internal buffers
  - Executing inference requests via the IP, managing synchronization and all data transfer between host and device.

* **Input / Output Data Transform**
  - Converting the memory layout of input/output data
  - Converting the numeric precision of input/output data

### 3.3.2. OpenVINO FPGA Runtime Plugin

The FPGA runtime plugin uses the OpenVINO Inference Engine Plugin API.

The OpenVINO Plugin architecture is described in the [OpenVINO Developer Guide for Inference Engine Plugin Library](https://docs.openvino.ai/2025/documentation/openvino-extensibility/openvino-plugin-library.html).

The source files are located under `runtime/plugin`. The three main components of the runtime plugin are the Plugin class, the Executable Network class, and the Inference Request class. The primary responsibilities for each class are as follows:

**Plugin class**

* Initializes the runtime plugin with an FPGA AI Suite architecture file which you set as an OpenVINO configuration key (refer to [PCIE - Running the Ported OpenVINO Demonstration Applications](https://altera-fpga.github.io/rel-26.1/ed-ai-suite/agilex7/pcie/pcie_getting_started_extended)).

* Contains `QueryNetwork` function that analyzes network layers and returns a list of layers that the specified architecture supports. This function allows network execution to be distributed between FPGA and other devices and is enabled with the HETERO mode.

* Creates an executable network instance in one of the following ways:
  - **Just-in-time (JIT) flow:** Compiles a network such that the compiled network is compatible with the hardware corresponding to the FPGA AI Suite architecture file, and then loads the compiled network onto the FPGA device.
  - **Ahead-of-time (AOT) flow:** Imports a precompiled network (exported by FPGA AI Suite compiler) and loads it onto the FPGA device.

**Executable Network Class**

* Represents an FPGA AI Suite compiled network

* Loads the compiled model and config data for the network onto the FPGA device that has already been programmed with an FPGA AI Suite bitstream. For two instances of FPGA AI Suite, the Executable Network class loads the network onto both instances, allowing them to perform parallel batch inference.

* Stores input/output processing information.

* Creates infer request instances for pipelining multiple batch execution.

**Infer Request class**

* Runs a single batch inference serially.

* Executes five stages in one inference job – input layout transformation on CPU, input transfer to DDR, FPGA AI Suite FPGA execution, output transfer from DDR, output layout transformation on CPU.

* In asynchronous mode, executes the stages on multiple threads that are shared across all inference request instances so that multiple batch jobs are pipelined, and the FPGA is always active.

### 3.3.3. FPGA AI Suite Runtime

The FPGA AI Suite runtime implements lower-level classes and functions that interact with the memory-mapped device (MMD). The MMD is responsible for communicating requests to the driver, and the driver connects to the BSP, and ultimately to the FPGA AI Suite IP instance or instances.

The runtime source files are located under `runtime/coredla_device`. The three most important classes in the runtime are the Device class, the GraphJob class, and the BatchJob class.

**Device class**

* Acquires a handle to the MMD for performing operations by calling `aocl_mmd_open`.

* Initializes a DDR memory allocator with the size of 1 DDR bank for each FPGA AI Suite IP instance on the device.

* Implements and registers a callback function on the MMD DMA (host to FPGA) thread to launch FPGA AI Suite IP for batch=1 after the batch input data is transferred from host to DDR.

* Implements and registers a callback function (interrupt service routine) on the MMD kernel interrupt thread to service interrupts from hardware after one batch job completes.

* Provides the `CreateGraphJob` function to create a GraphJob object for each FPGA AI Suite IP instance on the device.

* Provides the `WaitForDla`(*instance id*) function to wait for a batch inference job to complete on a given instance. Returns instantly if the number of batch jobs finished (that is, the number of jobs processed by interrupt service routine) is greater than number of batch jobs waited for this instance. Otherwise, the function waits until interrupt service routine notifies. Before returning, this function increments the number of batch jobs that have been waited for this instance.

**GraphJob class**

* Represents a compiled network that is loaded onto one instance of the FPGA AI Suite IP on an FPGA device.

* Allocates buffers in DDR memory to transfer configuration, filter, and bias data.

* Creates BatchJob objects for a given number of pipelines and allocates input and output buffers for each pipeline in DDR.

**BatchJob class**

* Represents a single batch inference job.

* Stores the DDR addresses for batch input and output data.

* Provides `LoadInputFeatureToDdr` function to transfer input data to DDR and start inference for this batch asynchronously.

* Provides `ReadOutputFeatureFromDdr` function to transfer output data from DDR. Must be called after inference for this batch is completed.

### 3.3.4. FPGA AI Suite Custom Platform

#### **Figure 2. Overview of FPGA AI Suite MMD Runtime**

![alt text](../../doc_modules/images/image-1.png)

The interface to the user-space portion of the BSP drivers is centralized in the MmdWrapper class, which can be found in the file `$COREDLA_ROOT/runtime/coredla_device/inc/mmd_wrapper.h`. This file is a wrapper around the MMD API.

The FPGA AI Suite runtime uses this wrapper so that the runtime can be reused on all platforms. When porting the runtime to a new board, you must ensure that each of the member functions in MmdWrapper calls into a board-specific implementation function. You must also modify the runtime build process and adjacent code.

Any implementation of a runtime for the FPGA AI Suite must support the following features via the MMD Wrapper:

* Open the device
* Register an interrupt service routine
* Read/write 32-bit register values in the IP control-and-status register (CSR)
* Transfer bulk data between the host and device

### 3.3.5. Memory-Mapped Device (MMD) Driver

The FPGA AI Suite runtime MMD software uses a driver to access and interact with the FPGA device. To integrate the FPGA AI Suite IP into your design on your platform, the MMD layer must interface with the hardware using the appropriate drivers (such as OPAE, UIO, or a custom driver). For example, the PCIe-based design example uses the drivers provided by the OpenCL board support package (BSP) for the Terasic DE10-Agilex Development Board.

If your board vendor provides a BSP, you can use the MMD Wrapper to interface the BSP with the FPGA AI Suite IP. Review the following sections for examples of adapting a vendor-provided BSP to use with the FPGA AI Suite IP:

* [Terasic DE10-Agilex Development Board BSP Example](#337-board-support-package-bsp-overview)
* [Agilex™ 7 PCIe-Attach OFS-based BSP Example](#3372-agilex-7-pcie-attach-ofs-based-bsp-example)

You can create a custom BSP for your board, but that process can be complex and can require more work.

The FPGA AI Suite runtime MMD software uses a driver to access and interact with the FPGA device. This driver is supplied as part of the board vendor BSP or, for OFS-based boards, the OPAE driver.

The source files for the MMD driver are provided in `runtime/coredla_device/mmd`. The source files contain classes for managing and accessing the FPGA device by using driver-supplied functions for reading/writing to CSR, reading/writing to DDR, and handling kernel interrupts.

#### Obtaining BSP Drivers

Contact your FPGA board vendor for information about the BSP for your FPGA board.

#### Obtaining the OPAE Drivers

Contact your FPGA board vendor for information about the OPAE driver for your FPGA board.

For the FPGA AI Suite OFS for PCIe attach design example, the OPAE driver is installed when you follow the steps in [Getting Started with Open FPGA Stack (OFS) for PCIe-Attach Design Examples](https://altera-fpga.github.io/rel-26.1/ed-ai-suite/agilex7/ofs/ofs_pcie_getting_started.md).

### 3.3.6. FPGA AI Suite Runtime MMD API

This section describes board-level functions that are defined in the `mmd_wrapper.cpp` file. Your implementation of the functions in the `mmd_wrapper.cpp` file for your specific board may differ. For examples of these functions, refer to the provided MMD implementations under `$COREDLA_ROOT/runtime/coredla_device/mmd/`.

The `mmd_wrapper.cpp` file contains the following MMD functions that are adapted from the Open FPGA Stack (OFS) accelerator support package (ASP) functions of the same name. For more information about these functions, refer to the [OFS AFS Memory Mapped Device Layer documentation](https://ofs.github.io/ofs-2025.1-1/hw/common/reference_manual/oneapi_asp/oneapi_asp_ref_mnl/#41-memory-mapped-devicemmd-layer).

* [aocl_mmd_get_offline_info](https://ofs.github.io/ofs-2025.1-1/hw/common/reference_manual/oneapi_asp/oneapi_asp_ref_mnl/#411-aocl_mmd_get_offline_info)
* [aocl_mmd_open](https://ofs.github.io/ofs-2025.1-1/hw/common/reference_manual/oneapi_asp/oneapi_asp_ref_mnl/#413-aocl_mmd_open)
* [aocl_mmd_close](https://ofs.github.io/ofs-2025.1-1/hw/common/reference_manual/oneapi_asp/oneapi_asp_ref_mnl/#414-aocl_mmd_close)
* [aocl_mmd_set_interrupt_handler](https://ofs.github.io/ofs-2025.1-1/hw/common/reference_manual/oneapi_asp/oneapi_asp_ref_mnl/#415-aocl_mmd_set_interrupt_handler)

Although several of the functions in the FPGA AI Suite MMD API share names and intended behavior with OpenCL MMD API functions, you do not need to use an OpenCL BSP. The naming convention is maintained for historical reasons only.

The `mmd_wrapper.cpp` file contains the following functions provided only with the FPGA AI Suite:

* [dla_mmd_get_max_num_instances](#the-dla_mmd_get_max_num_instances-function)
* [dla_mmd_get_ddr_size_per_instance](#the-dla_mmd_get_ddr_size_per_instance-function)
* [dla_mmd_get_coredla_clock_freq](#the-dla_mmd_get_coredla_clock_freq-function)
* [dla_mmd_get_ddr_clock_freq](#the-dla_mmd_get_ddr_clock_freq-function)
* [dla_mmd_csr_read](#the-dla_mmd_csr_read-function)
* [dla_mmd_csr_write](#the-dla_mmd_csr_write-function)
* [dla_mmd_ddr_read](#the-dla_mmd_ddr_read-function)
* [dla_mmd_ddr_write](#the-dla_mmd_ddr_write-function)
* [dla_is_stream_controller_valid](#the-dla_is_stream_controller_valid-function)
* [dla_mmd_stream_controller_read](#the-dla_mmd_stream_controller_read-function)
* [dla_mmd_stream_controller_write](#the-dla_mmd_stream_controller_write-function)

#### The dla_mmd_get_max_num_instances Function

Returns the maximum number of FPGA AI Suite IP instances that can be instantiated on the platform. In the FPGA AI Suite PCIe-based design examples, this number of IP instances that can be instantiated is the same as the number of external memory interfaces (for example, DDR memories).

**Syntax**
```
int dla_mmd_get_max_num_instances()
```

#### The dla_mmd_get_ddr_size_per_instance Function

Returns the maximum amount of external memory available to each FPGA AI Suite IP instance.

**Syntax**
```
uint64_t dla_mmd_get_ddr_size_per_instance()
```

#### The dla_mmd_get_coredla_clock_freq Function

Given the device handle, return the FPGA AI Suite IP PLL clock frequency in MHz. Return a negative value if there is an error.

In the PCIe-based design example, this value is determined by allowing a set amount of wall clock time to elapse between reads of counters onboard the IP.

**Syntax**
```
double dla_mmd_get_coredla_clock_freq(int handle)
```

#### The dla_mmd_get_ddr_clock_freq Function

Returns the DDR clock frequency, in Mhz. Check the documentation from your board vendor to determine this value.

**Syntax**
```
double dla_mmd_get_ddr_clock_freq()
```

#### The dla_mmd_csr_read Function

Performs a control status register (CSR) read for a given instance of the FPGA AI Suite IP at a given address. The result is stored in the data directory.

**Syntax**
```
int dla_mmd_csr_read(int handle, int instance, uint64_t addr, uint32_t *data)
```

#### The dla_mmd_csr_write Function

Performs a control status register (CSR) write for a given instance of the FPGA AI Suite IP at a given address.

**Syntax**
```
int dla_mmd_csr_write(int handle, int instance, uint64_t addr, const uint32_t *data)
```

#### The dla_mmd_ddr_read Function

Performs an external memory read for a given instance of the FPGA AI Suite IP at a given address. The result is stored in the data directory.

**Syntax**
```
int dla_mmd_ddr_read(int handle, int instance, uint64_t addr, uint64_t length, void *data)
```

#### The dla_mmd_ddr_write Function

Performs an external memory write for a given instance of the FPGA AI Suite IP at a given address.

**Syntax**
```
int dla_mmd_ddr_write(int handle, int instance, uint64_t addr, uint64_t length, const void *data)
```

#### The dla_is_stream_controller_valid Function

Optional. Required if `STREAM_CONTROLLER_ACCESS` is defined.

Queries the streaming controller device to see if it is valid.

**Syntax**
```
bool dla_is_stream_controller_valid(int handle, int instance)
```

For more information about the stream controller module, refer to [[SOC] Stream Controller Communication Protocol](todo).

#### The dla_mmd_stream_controller_read Function

Optional. Required if `STREAM_CONTROLLER_ACCESS` is defined.

Reads an incoming message from the streaming controller.

**Syntax**
```
int dla_mmd_stream_controller_read(int handle, int instance, uint64_t addr, uint64_t length, void* data)
```

For more information about the streaming controller device, refer to [[SOC] Stream Controller Communication Protocol](todo).

#### The dla_mmd_stream_controller_write Function

Optional. Required if `STREAM_CONTROLLER_ACCESS` is defined.

Writes an outgoing message from the streaming controller.

**Syntax**
```
int dla_mmd_stream_controller_write(int handle, int instance, uint64_t addr, uint64_t length, const void* data)
```

For more information about the streaming controller device, refer to [[SOC] Stream Controller Communication Protocol](todo).

### 3.3.7. Board Support Package (BSP) Overview

Every FPGA platform consists of the FPGA fabric and the hard IP that surrounds it. For example, an FPGA platform might provide an external memory interface as hard IP to provide access to external DDR memory. Soft logic that is synthesized on the FPGA fabric needs to be able to communicate with the hard IP blocks, and the implementation details are typically platform-specific.

A board support package (BSP) typically consists of two parts:

* **A software component** that runs in the host operating system.

This component includes the MMD and operating system driver for the board.

* **A hardware component** that is programming into the FPGA fabric.

This component consists of soft logic that enables the use of the FPGA peripheral hard IP blocks around the FPGA fabric. This component acts as the bridge between the FPGA AI Suite IP block in the FPGA fabric and the hard IP blocks.

Depending on your board and board vendor, you can have the following options for obtaining a BSP:

* If your board supports the Open FPGA Stack (OFS), you can use (and adapt, if necessary) an OFS reference design or FPGA interface manager (FIM).

For some boards, there are precompiled FIM reference designs available.

* Obtain a BSP directly from your board vendor. You board vendor might have multiple BSPs available for you board.

* Create your own BSP.

For a BSP to be compatible with FPGA AI Suite, the BSP must provide the following capabilities:

* Enable the FPGA AI Suite IP and the host to interface with the external memory interface IP.

* Enable the FPGA AI Suite IP to interface with the runtime (for example, PCIe IP for the PCIe-based design example, or the HPS-to-FPGA AXI bridge for the SoC design example).

* Enable the FPGA AI Suite IP to send interrupts to the runtime. If your BSP does not support this capability, you must use polling to determine when an inference is complete.

* Enable the host to access the FPGA AI Suite IP CSR.

The BSPs available for the boards supported by the FPGA AI Suite design example support these capabilities.

**Related Information**

[Open FPGA Stack (OFS) documentation.](https://ofs.github.io/ofs-2025.1-1/)

#### 3.3.7.1. Terasic DE10-Agilex™ Development Board BSP Example

For the Agilex™ 7 PCIe-based design example on the Terasic DE10-Agilex Development Board, the BSP provided by Terasic is adapted to work with the FPGA AI Suite IP. The Terasic-provided BSP is OpenCL™-based.

The following diagram shows the high-level interactions between the FPGA interface IPs on the platform, and the a custom OpenCL kernel. The different colors in the diagram indicate different clock domains.

##### Figure 3. Terasic BSP with OpenCL Kernel

![alt text](../../doc_modules/images/image-2.png)

The PCIe hard IP can read/write to the DDR4 external memory interface (EMIF) via the DMA and the Arbitrator. Additional logic is provided to handle interrupts from the custom IP and propagate them back to the host through the PCIe interface.

The following diagram hows how the Terasic DE10-Agilex Development Board BSP can be adapted to support the FPGA AI Suite IP.

##### Figure 4. Terasic BSP With FPGA AI Suite IP

![alt text](../../doc_modules/images/image-3.png)

Platform Designer automatically adds clock-domain crossings between Avalon memory-mapped interfaces and AXI4 interfaces, making the integration with the BSP easier.

For a custom platform, consider following a similar approach of modifying the BSP provided by the vendor to integrate in the FPGA AI Suite IP.

#### 3.3.7.2. Agilex™ 7 PCIe-Attach OFS-based BSP Example

For OFS-based devices, the BSP consists of a platform-specific FPGA interface manager (FIM) and a platform-agnostic accelerator functional unit (AFU).

The FPGA AI Suite OFS for PCIe attach design example supports Agilex™ 7 PCIe Attach OFS.

You can obtain the source files needed to build a Agilex™ 7 PCIe Attach FIM or obtain prebuillt FIMs for some boards from [OFS Agilex™ 7 PCIe Attach FPGA Development Directory in GitHub](https://github.com/OFS/ofs-agx7-pcie-attach).

The AFU wraps the FPGA AI Suite IP and must meet the following general requirements:

* The AFU must include an instance of the FPGA AI Suite IP.

* The AFU must support host access (for example, via DMA) to external memory that is shared with the FPGA AI Suite IP.

* The AFU must propagate interrupts from the FPGA AI Suite IP to the host.

* The AFU Must support host access to the FPGA AI Suite IP CSR memory.

If you are creating your own FPGA AI Suite AFU, consider starting with an AFU example design that implements some of the required functionality. Some examples designs and what they are offer are as follows:

* For an example of enabling direct memory access so the host can access DDR memory, review the direct memory access (DMA) AFU example on GitHub

* For an example of interrupt handling, review the oneAPI Accelerator Support Package (ASP) on GitHub.

* For an example MMD implementation, review the oneAPI Accelerator Support Package (ASP) on GitHub.

**Related Information**

* [Direct memory access (DMA) AFU example on GitHub](https://github.com/OFS/examples-afu/tree/main/tutorial/afu_types/01_pim_ifc/dma)
* [oneAPI accelerator support package (ASP) on GitHub](https://github.com/OFS/oneapi-asp)
* [Agilex™ 7 PCIe Attach OFS documentation](https://ofs.github.io/ofs-2025.1-1/hw/doc_modules/contents_agx7_pcie_attach/)
* [Agilex™ 7 PCIe Attach OFS Workload Development Guide](https://ofs.github.io/ofs-2025.1-1/hw/common/user_guides/afu_dev/ug_dev_afu_ofs_agx7_pcie_attach/ug_dev_afu_ofs_agx7_pcie_attach/)

# 4.0 Getting Started

The hostless JTAG design example example demonstrates how to instantiate one instance of the FPGA AI Suite IP on an Agilex 5 E-Series device or Agilex 3 C-Series device.

It places configurations and data on external DDR memory and allows an external host to interact with the memory and FPGA AI Suite IP via JTAG.

This design example targets the **Agilex 5 FPGA E-Series 065B Modular Development Kit** (MK-A5E065BB32AES1) or **Agilex 3 FPGA C-Series Development Kit** (A3CY135BM16AE6S).

This section describes the steps to build the necessary components and commands to launch inference with the `dla_benchmark` application.

## 4.1 Prerequisites

### 4.1.1 Software Requirements

You should install the FPGA AI Suite and OpenVINO according to the steps in the [FPGA AI Suite Handbook](https://docs.altera.com/r/docs/863373/2026.1.1/fpga-ai-suite-handbook/fpga-ai-suite-handbook).

To generate the bitstream files for this design example, you require the following components from Quartus Prime Pro Edition Version 25.3 or later:
* Quartus Prime software
* Agilex 5 E-Series device support or Agilex 3 C-Series device support depending on your chosen target

For host-FPGA device communication, and to configure either the Agilex 5 FPGA E-Series or Agilex 3 FPGA C-Series, you require the following components from Quartus Prime Pro Edition Version 26.1 or later:
* Quartus Prime Programmer
* Quartus Prime System Console

### 4.1.2 Hardware Requirements

The JTAG design example can be deployed on one of the following:

* Agilex 5 FPGA E-Series 065B Modular Development Kit (MK-A5E065BB32AES1)
* Agilex 3 FPGA C-Series Development Kit (A3CY135BM16AE6S)

Enable JTAG programming for the development kit as follows:

* Agilex 5 E-Series: Enable JTAG programming on the development kit board by setting the board switches SW4[1:2] to [OFF, OFF].
* Agilex 3 C-Series: Enable JTAG programming on the Agilex 3 development kit board by setting switches SW[1:4] to [OFF,OFF,OFF,OFF]

1. On the host computer, ensure that the necessary USB port rules and permissions are enabled by creating a `/etc/udev/rules.d/51-altera-usbblaster.rules` file with the following content:

    ```
    SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6001", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6002", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6003", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6810", MODE="0666"
    ```

2. Change the port permission of the JTAG-USB connection to `0666`.
    
    Use the `lsusb` command to determine the bus and device numbers for adjusting permissions.
    
    For example, the command `lsusb` outputs the following bus and device path for devices on the development kit,
    
    ```
    Bus 002 Device 006: ID 09fb:6010 Altera
    Bus 002 Device 007: ID 0403:6010 Future Technology Devices International, Ltd FT2232C/D/H Dual UART/FIFO IC
    ```
    
    With this information, adjust the permissions with the following commands:
    
    ```bash
    sudo chmod 0666 /dev/bus/usb/002/006
    sudo chmod 0666 /dev/bus/usb/002/007
    ```

## 4.2 Building the FPGA AI Suite Runtime

Before you can run inference on the design example, build the FPGA AI Suite runtime using the provided `build_runtime.sh` script as follows:

1. Ensure that you have a working directory created as outlined in ["Creating a Working Directory" in FPGA AI Suite Getting Started Guide](https://docs.altera.com/r/docs/863373/2026.1.1/fpga-ai-suite-handbook/creating-a-working-directory).

2. Run the following commands:
   ```bash
   cd $COREDLA_WORK
   source $COREDLA_ROOT/bin/dla_init_local_directory.sh
   cd runtime
   ./build_runtime.sh -target_system_console
   ```

A successful build of the runtime creates the following objects:

* `<runtime-directory>/build_Release/libcoreDlaRuntimePlugin.so`
  A runtime library that has the APIs for the host to access the FPGA AI Suite IP's registers and memories in the design example.

* `<runtime-directory>/build_Release/system_console_script.tcl`
  A script that the runtime invokes via the Quartus Prime System Console to set up the JTAG services to access the memories and CSR registers in the design example.

* `<runtime-directory>/build_Release/dla_benchmark/dla_benchmark`
  The `dla_benchmark` application.

If you run into the following error, check if `/sbin` appears near the start of the list of paths in your PATH environment variable:

```
Imported target "Boost::filesystem" includes non-existent path "/include"
```

Your PATH environment variable does not need to include `/sbin` for the JTAG design example.

## 4.3 Building an FPGA Bitstream for the JTAG Design Examples

To generate an FPGA bitstream for the JTAG Design Example, run the following commands:


### For the Agilex 5 FPGA E-Series 065B Modular Development Kit (MK-A5E065BB32AES1):
```bash
cd $COREDLA_WORK

$COREDLA_ROOT/bin/dla_build_example_design.py build \
--output-dir build_agx5_jtag_ed \
--num-instances 1 \
--seed 1 \
agx5e_modular_jtag \
$COREDLA_ROOT/example_architectures/AGX5_Generic.arch
```
This command creates the bitstream file called `AGX5_Generic.sof` that can be found in the `$COREDLA_WORK/build_agx5_jtag_ed/` folder.

### For the Agilex 3 FPGA C-Series Development Kit (A3CY135BM16AE6S):

```bash
cd $COREDLA_WORK

$COREDLA_ROOT/bin/dla_build_example_design.py build \
--output-dir build_agx3_jtag_ed \
--num-instances 1 \
--seed 1 \
agx3c_jtag \
$COREDLA_ROOT/example_architectures/AGX3_Small_NoSoftmax.arch
```
This command creates the bitstream file called `AGX3_Small_NoSoftmax.sof` that can be found in the `$COREDLA_WORK/build_agx3_jtag_ed/` folder.

For more information about the `dla_build_example_design.py` command, refer to The [`dla_build_example_design.py`](#311-the-dla_build_example_designpy-command).

## 4.4 Programming the FPGA Device

Before you program the FPGA device, ensure that the USB-JTAG connection and port permissions are set up as described in [Hardware Requirements](#412-hardware-requirements).

Program the FPGA device with Quartus Prime Programmer and FPGA bitstream that you generated in [Building an FPGA Bitstream for the JTAG Design Examples](#43-building-an-fpga-bitstream-for-the-jtag-design-example) with the following commands:

```bash
cd $COREDLA_WORK/build_agx5_jtag_ed
quartus_pgm -c 1 -m jtag -o "p;AGX5_Generic.sof"
```

## 4.5. Preparing Graphs for Inference with FPGA AI Suite

Before running any demonstration application, you must convert the trained model to the Inference Engine format (.xml, .bin) with the OpenVINO Model Optimizer.

For details on creating the .bin/.xml files, refer to the FPGA AI Suite Getting Started Guide.

The network as described in the .xml and .bin files (created by the Model Optimizer) is compiled for a specific FPGA AI Suite architecture file by using the FPGA AI Suite compiler.

The FPGA AI Suite compiler compiles the network and exports it to a .bin file that uses the same .bin format as required by the OpenVINO Inference Engine.

This .bin file created by the compiler contains the compiled network parameters for all the target devices (FPGA, CPU, or both) along with the weights and biases. The inference application imports this file at runtime.

The FPGA AI Suite compiler can also compile the graph and provide estimated area or performance metrics for a given architecture file or produce an optimized architecture file.

For more details about the FPGA AI Suite compiler, refer to the FPGA AI Suite Compiler Reference Manual.

## 4.6. Performing Inference on the Agilex 5 FPGA E-Series or Agilex 3 FPGA C-Series

After the FPGA device on the targeted FPGA device has been programmed you can perform inference.

For this system example design, the FPGA AI Suite runtime needs the locations of the following items before performing inference:

* **Bitstream file location**
  The default bitstream path is `top.sof` located in the `$COREDLA_WORK` directory. You can override this default location by specifying the `$DLA_SOF_PATH` environment variable.

* **Quartus Prime System Console Tcl script** (required to properly claim JTAG services)
  The default script is `$COREDLA_WORK/runtime/build_Release/system_console_script.tcl`. You can override this value by specifying the `$DLA_SYSCON_SOURCE_FILE` environment variable.

Perform inference by running the following command:

**For Agilex 5 E-Series:**

```bash
# Modify MODEL to suit your application
export DLA_SOF_PATH=$COREDLA_WORK/build_agx5_jtag_ed/AGX5_Generic.sof
export MODEL=<path-to-model-XML-file>/resnet50.xml
cd $COREDLA_WORK/runtime/build_Release/dla_benchmark
dla_benchmark \
-b=1 \
-m=$MODEL \
-d=HETERO:FPGA,CPU \
-i <path-to-image-files> \
-niter=2 \
-plugins=../../plugins.xml \
-arch_file= $COREDLA_ROOT/example_architectures/AGX5_Generic.arch \
-api=async \
-perf_est \
-nireq=1 -dump_output -report_lsu_counters -enable_early_access
```

**For Agilex 3 C-Series**

```bash
# Modify MODEL to suit your application
export DLA_SOF_PATH=$COREDLA_WORK/build_agx3_jtag_ed/AGX3_Small_NoSoftmax.sof
export MODEL=<path-to-model-XML-file>/resnet50.xml
cd $COREDLA_WORK/runtime/build_Release/dla_benchmark

dla_benchmark \
-b=1 \
-m=$MODEL \
-d=HETERO:FPGA,CPU \
-i <path-to-image-files> \
-niter=2 \
-plugins=../../plugins.xml \
-arch_file= $COREDLA_ROOT/example_architectures/AGX3_Small_NoSoftmax.arch \
-api=async \
-perf_est \
-nireq=1 -dump_output -report_lsu_counters -enable_early_access
```

By default, the `dla_benchmark` application records the system-console commands that are executed during inference in a log file named `csr_log.txt` in the current work directory, and preserves the intermediate files created during inference. To prevent the creation of the log file and intermediate files, specify the `-dump_csr=false` of the dla_benchmark command.

For more information about the `dla_benchmark` application, refer to [Performing Accelerated Inference with the `dla_benchmark` Application](https://altera-fpga.github.io/rel-26.1/ed-ai-suite/agilex7/pcie/pcie_getting_started_extended/).

## 4.7 Inference Performance Measurement

The `dla_benchmark` application reports inference duration and throughput for the entire design example as well as for the FPGA AI Suite IP.

To perform one inference iteration, the host performs the following steps:

1. Write input data via JTAG to the DDR memory on the FPGA development board.
2. Program CSRs on the FPGA AI Suite IP to start inference.
3. Poll the CSRs until the FPGA AI Suite IP completes the inference.
4. Read the output from the DDR memory to the host via JTAG.

The system duration accounts for all these steps above.

In contrast, the IP duration omits the duration of input and output data transfer.

For this design example, system duration is usually much larger than the IP duration because data transfer over JTAG is relatively slow. Thus, the IP duration and throughput better reflect the performance of the FPGA AI Suite IP.

The following output is an example throughput report generated by the `dla_benchmark` application after performing 3925 inferences on a quantized ResNet-18 model using the Agilex 5 E-Series Development Kit Board:

```
[Step 11/12] Dumping statistics report
count: 3925 iterations
system duration: 464549.5363 ms
IP duration: 17945.7971 ms
latency: 118.2524 ms
system throughput: 8.4490 FPS
number of hardware instances: 1
number of network instances: 1
IP throughput per instance: 218.7142 FPS
IP throughput per fmax per instance: 1.0936 FPS/MHz
IP clock frequency: 200.0000 MHz
```

## 4.8 Known Issues and Limitations

The JTAG design example has the following known issues and limitations:

* The number of inference request (-nireq) must be 1 when running `dla_benchmark` with either the Agilex 5 E-Series or Agilex 3 C-Series JTAG Example Designs.

* The USB-JTAG connection between the host and the FPGA is relatively slow, so the system throughput is much lower than both the measured and estimated IP throughputs per instance.

* For FPGA AI Suite IP configured with large K<sub>vec</sub> and C<sub>vec</sub> parallelism, the peak throughput of the DDR4 interface on the Agilex 5 FPGA E-Series 065B Modular Development Kit can become the bottleneck. When you run the `dla_benchmark` application with the flag `-perf_est`, the application provides a throughput estimation that does not fully account for the limited external memory bandwidth on the development kit, so the estimate might be higher than the measured IP throughput per instance.

* On Ubuntu 22 systems, the runtime might fail when loading model to the FPGA device if the `$DLA_SOF_PATH` environment variable does not point to the correct bitstream file, or if the Quartus Prime System Console `system-console` command is not present in the `$PATH` environment variable.

The Quartus Prime System Console command is in `$QUARTUS_ROOTDIR/syscon/bin`.

```
[Step 5/12] Resizing network to match image sizes and given batch
[Step 6/12] Configuring input of the model
[Step 7/12] Loading the model to the device
Generating unsupported layer chains graph (./unsupported_layer_chains.dot)
Using the Tcl setup script at /home/user/coredla-work/runtime/build_Release/system_console_script.tcl
Saving temporary files to /home/user/Downloads
Segmentation fault (core dumped)
```

* You might occasionally see the following Quartus Prime System Console error when running inference with the runtime on this design example:

```
claim_service: Path cannot be found while executing
"claim_service master $path {}
"\{${::g_const_master_offset_dla} ${::g_const_master_range_dla} EXCLUSIVE\}""
procedure "claim_dla_csr_service" line 4)
invoked from within"claim_dla_csr_service"
procedure "initialization" line 4)
invoked from within
"initialization"
```

To recover from the issue, reprogram the FPGA with the correct bitstream and rerun the dla_benchmark application. To reduce the likelihood of this issue, lower the JTAG clock frequency to 16 MHz before running the run the dla_benchmark application:

```bash
jtagconfig --setparam 1 JtagClock 16M
```

# 5 Design Example Components

## 5.1 Hardware Components

The FPGA AI Suite JTAG design example uses a JTAG-USB connection on the development kit to facilitate host-FPGA transactions. The following diagram shows a simplified block diagram of the design.

### Figure 1: Simplified System Design of the JTAG Design Example

![](./images/image-1.png)

The design example stores filter weights, biases, configurations for the FPGA AI Suite IP, graph inputs, outputs, and intermediate data on the lower 2GB of a DDR4/LPDDR4 memory interface, similar to the PCIe-based design examples. An external memory interface (EMIF) IP manages the DDR4/LPDDR4 memory and toggles the 32-bit interface at 1600 MT/s for the Agilex 5 E-Series development kit board and 2133 Mb/s for the Agilex 3 E-Series development kit board.

For the Agilex 5 example design, the FPGA AI Suite IP can typically meet timing at around 300 MHz and accesses the EMIF IP via a 128-bit AXI4 data interface clocked at 200 MHz. The IP can only access the first 2GB of the memory. For the Agilex 3 version, the FPGA AI Suite IP can meet timing at around 400 MHz and use the EMIF IP at 200 MHz.

The host uses a JTAG-Avalon Bridge IP to access the DDR4 memory, as well as the CSR registers of the FPGA AI Suite IP via a 32-bit Avalon-MM interface clocked at 100 MHz. As seen from the JTAG-Avalon Bridge IP, the subordinates reside at the addresses outlined in the following table:

### Table 1: Subordinate Addresses Accessible from the JTAG-Avalon Interface

| External Memory | FPGA AI Suite IP CSRs |
|-----------------|----------------------|
| Address Range (Bytes) | 0x0000_0000 – 0x7FFF_FFFF | 0x8000_0000 – 0x8000_0FFF |

To investigate and modify the implementation of the hardware components, review the source files of the system design part of the design example in the `$COREDLA_ROOT/platform/a5e_modular_devkit_jtag` directory. For users who targeted the Agilex 3 development kit, these files can be found in `$COREDLA_ROOT/platform/agx3c_jtag directory`.

## 5.2. Software Components

The JTAG design example relies on the following software components to executed FPGA inference via the `dla_benchmark` application:

* OpenVINO Toolkit
* FPGA AI Suite Runtime Plugin
* Quartus Prime System Console

When the build target is this design example, the FPGA AI Suite Runtime Plugin instantiates an MMD Wrapper object that converts external memory and FPGA AI Suite CSR access commands into Quartus Prime System Console calls. The MMD wrapper depends on the Boost C++ Libraries. The definitions of the MMD wrapper object and its methods are implemented in `$COREDLA_WORK/runtime/coredla_device/mmd/system_console/mmd_wrapper.cpp`.

Upon instantiation, the MMD wrapper initializes the JTAG services via the routine in a Quartus Prime System Console script: `$COREDLA_WORK/runtime/coredla_device/mmd/system_console/system_console.tcl`.