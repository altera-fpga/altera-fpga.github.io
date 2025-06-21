

## Introduction

### Nios® V/m Baseline Golden Hardware Reference Design (GHRD) Overview

 This design demonstrates the baseline Golden Hardware Reference Design (GHRD) for a Nios® V/m processor with basic bare minimum peripherals required for any application execution for the Agilex™ 5 FPGA E-Series 065B Premium Development Kit.

### Prerequisites

 - Agilex™ 5 FPGA E-Series 065B Premium Development Kit, ordering code DK- A5E065BB32AES1. Refer to the board documentation for more information about the development kit.
 - Mini and Micro USB Cable. Included with the development kit.
 - Host PC with 64 GB of RAM. Less will be fine for only exercising the binaries, and not rebuilding the GHRD.
 
### Release Contents  

#### Binaries
 - Prebuilt binaries are located [here](https://github.com/altera-fpga/agilex5e-nios-ed/blob/rel/25.1.0/a5e065b-prem-devkit/niosv_m/niosv_m_baseline_ghrd/ready_to_test).
 - The sof and elf files required to run the design can be found in "ready_to_test" folder 
 - Program the sof and download the elf file on board

### Nios® V/m Baseline Golden Hardware Reference Design (GHRD) Archiecture
 This example design includes a Nios® V/m processor connected to the On Chip RAM-II, JTAG UART IP, Parallel-IO and System ID peripheral core. The objective of the design is to accomplish data transfer between the processor and soft IP peripherals.
 
 ![Block Diagram](https://github.com/altera-fpga/agilex5e-nios-ed/blob/rel/25.1.0/niosv_m/niosv_m_baseline_ghrd/img/baseling_ghrd_block_design.png?raw=true)

#### Nios® V/m Processor
- Microcontroller- Balanced (For interrupt driven baremetal and RTOS code)
- Nios® V/m processor is highly customizable and can be tailored to meet specific application requirements, providing flexibility and scalability in embedded system designs.
 
#### IP Cores
 The following IPs are used in this Platform Designer component of the design:
- Nios® V/m soft processor core

- On Chip RAM-II

- JTAG UART

- Parallel-IO

- System ID

- Clock Bridge, Reset Controller


### Hardware Setup

Refer to [Agilex™ 5 FPGA Premium Development Kit User Guide](https://www.intel.com/content/www/us/en/docs/programmable/814550.html) to setup the hardware connection.


### Address Map Details

#### Nios V Address Map
 |Address Offset	|Size (Bytes)	|Peripheral	| Description|
  |-|-|-|-|
  |0x0000_0000|1MB|On-Chip RAM|To store application|
  |0x0011_0068|8|JTAG UART|Communication between a host PC and the Nios V processor system|
  |0x0011_0050|16|PIO 0|LED connections on board|
  |0x0011_0040|16|PIO 1|LED connections on board|
  |0x0011_0060|8|System ID|Hardware configuration system ID (0x000000a5)|
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
 ||Run simulation|Yes|Yes|
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
Note: Clean the app build project before regenerating elf
- To create software app, run the following commands in the terminal:
```console
niosv-bsp -c --quartus-project=hw/top.qpf --qsys=hw/qsys_top.qsys --type=hal sw/bsp/settings.bsp
niosv-app --bsp-dir=sw/bsp --app-dir=sw/app --srcs=sw/app/main.c
niosv-shell
cmake -S ./sw/app -B sw/app/build
make -C sw/app/build
elf2hex sw/app/build/app.elf -b 0x0 -w 32 -e 0xfffff hw/onchip_mem.hex -r4
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
quartus_pgm --cable=1 -m jtag -o 'p;ready_to_test/top.sof'
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
juart-terminal -d 1 -c 1 -i 0 
```

#### Running simulation
Simulation is enabled for this design where the memory is initialized with the application hex. Use the following commands to run the simulation:
```console
cp ./sw/app/build/onchip_mem.hex ./qsys_top_tb/qsys_top_tb/sim/mentor 
cd hw/qsys_top_tb/qsys_top_tb/sim/mentor/
vsim &
source msim_setup.tcl
ld_debug
run -all
```
