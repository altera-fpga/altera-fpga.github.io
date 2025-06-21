

## Introduction

### Nios® V/g Processor Floating Point Unit Design Overview

This example design is about applying the floating point unit in Nios V/g processor. The example application evaluates the floating point rate of Nios V/g processor by using Linpack benchmark

### Prerequisites

 - Agilex™ 7 FPGA F-Series Transceiver-SoC Development Kit (P-Tile and E-Tile), ordering code DK-SI-AGF014EB. Refer to the board documentation for more information about the development kit.
 - Mini and Micro USB Cable. Included with the development kit.
 
### Release Contents  

#### Binaries
 - Prebuilt binaries are located [here](https://github.com/altera-fpga/agilex7f-nios-ed/tree/rel/25.1.0/agf014eb-si-devkit/niosv_g/fpu_test/ready_to_test).
 - The sof and elf files required to run the design can be found in "ready_to_test" folder 
 - Program the sof and download the elf file on board

### Design Archiecture
 This example design includes a Nios® V/g processor connected to the On Chip RAM-II, JTAG UART IP and System ID peripheral core. The objective of the design is to accomplish data transfer between the processor and soft IP peripherals for showcasing the FPU feature of the Nios V/g IP core.
 The application demonstrates the Floating Point Unit (FPU) feature of Nios V/g IP core using Linpack Benchmark- http://www.netlib.org/utk/people/JackDongarra/faq-linpack.html
 
 ![Block Diagram](https://github.com/altera-fpga/agilex7f-nios-ed/blob/rel/25.1.0/agf014eb-si-devkit/niosv_g/fpu_test/img/block_diagram.png?raw=true)
 

#### Nios® V/g Processor 
- Balanced (For interrupt driven baremetal and RTOS code)
- Nios® V/g processor is highly customizable and can be tailored to meet specific application requirements, providing flexibility and scalability in embedded system designs.

 
#### IP Cores
 The following IPs are used in this Platform Designer component of the design:

- Nios® V/g soft processor core

- On Chip RAM-II

- JTAG UART

- System ID

- Clock Bridge, Reset Controller


### Hardware Setup

  Refer to [Agilex® 7 FPGA F-Series Transceiver-SoC Development Kit User Guide](https://www.intel.com/content/www/us/en/docs/programmable/683752/current/overview.html) to setup the hardware connection.


### Address Map Details

#### Nios V Address Map
 |Address Offset	|Size (Bytes)	|Peripheral	| Description|
  |-|-|-|-|
  |0x0000_0000|1MB|On-Chip RAM|To store application|
  |0x0011_0068|8|JTAG UART|Communication between a host PC and the Nios V processor system|
  |0x0011_0060|8|System ID|Hardware configuration system ID (0x000000a5)|
  |0x0011_0040|32|Timer|Timer IP to calculate the computation time|
  ||||


## User Flow 

 There are two ways to test the design based on use case. 

   <h5> User Flow 1: Testing with Prebuild Binaries.</h5>
   
   <h5> User Flow 2: Testing Complete Flow.</h5>

 |User Flow|Description|Required for [User flow 1](#user-flow-1-testing-with-prebuild-binaries)|Required for [User flow 2](#user-flow-2-testing-complete-flow)|
 |-|-|-|-|
 |Environment Setup|[Tools Download and Installation](#tools-download)|Yes|Yes|
 |Compilation|Hardware compilation|No|Yes|
 ||Software compilation|No|Yes|    
 |Programing|Program Hardware Binary SOF|Yes|Yes|
 ||Program Software Image ELF|Yes|Yes|
 |Testing|Open JTAG UART Terminal|Yes|Yes|
 ||||

### Environment Setup

#### Tools Download and Installation
1. Quartus Prime Pro

 - Download the Quartus® Prime Pro Edition software version 25.1 from the FPGA Software Download Center webpage of the Intel website. Follow the on-screen instructions to complete the installation process. Choose an installation directory that is relative to the Quartus® Prime Pro Edition software installation directory.
 - Set up the Quartus tools in the PATH, so they are accessible without full path.
```console
export QUARTUS_ROOTDIR=~/intelFPGA_pro/25.1/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```

### Compilation 

#### Hardware Compilation 
 - Invoke the `quartus_py` shell in the terminal
 - Run the following command in the terminal from top level project directory:
 
```console
quartus_py ./scripts/build_sof.py
```

 - The quartus tool will compile the design and generate the output files

#### Software Compilation 
Note:	It is recommended to clean the app/build project before regenerating elf (cmake and make).
- To create software app, run the following commands in the terminal:
```console
niosv-bsp -c --quartus-project=hw/quartus_ag.qpf --qsys=hw/qsys_ag.qsys --type=hal sw/bsp/settings.bsp --cmd="set_setting hal.sys_clk_timer {none}" --cmd="set_setting hal.timestamp_timer {timer_0}"
niosv-app --bsp-dir=sw/bsp --app-dir=sw/app --srcs=sw/app/linpack.c
niosv-shell
cmake -S ./sw/fpu -B sw/fpu/build -G "Unix Makefiles"
make -C sw/fpu/build
elf2hex sw/app/build/app.elf -b 0x0 -w 32 -e 0xfffff 
```

Note:The software can be compiled using the Ashling Visual Studio Code Extension for Altera FPGAs

For information on the build process, please refer to the following document- [Ashling VSCode Extension](https://www.intel.com/content/www/us/en/docs/programmable/730783/current/ashling-visual-studio-code-extension.html)

### Programing 
Note: Reduce the JTAG clock frequency to 6MHz using the following command, before programming the sof file
```console
jtagconfig --setparam 1 JtagClock 6M
```

#### Program Hardware Binary SOF
- Program the generated sof and then download the elf file on the board
    
```console
quartus_pgm --cable=1 -m jtag -o 'p;ready_to_test/quartus_ag.sof'
```

#### Program Software Image ELF
- Download the elf file on the board
```console
niosv-download -g ready_to_test/app.elf -c 1
```

### Testing

#### Open JTAG UART Terminal
- Verify the output on the terminal by using the following command in the terminal:
    
```console
juart-terminal -c 1 -i 0 
```

