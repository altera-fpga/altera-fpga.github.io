


![Nios V Processor Header](../../devkit-img/niosv-header.png?raw=true)

## Introduction

### Nios® V/m Baseline Golden Hardware Reference Design (GHRD) Overview

 This design demonstrates the baseline Golden Hardware Reference Design (GHRD) for a Nios® V/m processor in Agilex™ 5 FPGA E-Series 065B Premium Development Kit. </br>
 The design is built with basic peripherals required for simple application execution:

 - JTAG UART for serial output.
 - Parallel Input/Output for IO control.

### Prerequisites

 - Agilex™ 5 FPGA E-Series 065B Premium Development Kit, ordering code DK- A5E065BB32AES1. </br> Refer to the board documentation for more information about the development kit.
 - Mini and Micro USB Cable. Included with the development kit.
 - Host PC with 64 GB of RAM. Less will be fine for only exercising the prebuilt binaries, and not rebuilding the design.
 - Quartus® Prime Pro Edition Software version 25.1.1
 - Ashling* RiscFree* IDE for Altera® FPGAs
 
### Release Contents  

Every Nios V processor design example is maintained based on this folder structure. </br>
Here is the Github link to root directory of this design example: [Nios® V/m Baseline Golden Hardware Reference Design (GHRD) Github link](https://github.com/altera-fpga/agilex5e-nios-ed/tree/rel/25.1.1/niosv_m/niosv_m_baseline_ghrd)

```mermaid 
---
title: Release Contents File Structure
config:
  flowchart:
    curve: linear
---

graph LR
    A[niosv_m_baseline_ghrd] --> B[docs]
    A --> C[img]
    A --> D[ready_to_test]
    A --> E[sources]
    B -->|contains| F{{Design Example MD file}}
    C -->|contains| G{{Figures or Illustrations}}
    D -->|contains| H{{Prebuilt Binary Files}}
    E --> I[hw]
    E --> J[scripts]
    E --> K[sw]
    I -->|contains| M{{Custom Hardware Design Files}}
    J -->|contains| N{{Scripts to Generate Hardware Design}}
    K -->|contains| P{{Custom Software Source Code}}

```


## Nios® V/m Baseline Golden Hardware Reference Design (GHRD) Architecture
 This example design includes a Nios® V/m processor connected to the On-Chip RAM II, JTAG UART IP, Parallel-IO and System ID peripheral core. </br>
 The objective of the design is to accomplish data transfer between the processor and soft IP peripherals:

 - Read and Write operation with On-Chip RAM II
 - Toggle the Parallel-IO
 - Verify design identification with System ID

```mermaid 
---
title: Design Block Diagram
config:
  flowchart:
    curve: linear
---

flowchart LR
subgraph top-level-subsystem
    Z[Clock Source]
    Y[Reset Source]
    X[IO Debounce Logic]
subgraph processor-subsystem
    A[Nios V/m Processor]
    A <--> B(Bus Interface : AXI / AvMM Interface)
    B <--> C[On-Chip RAM II]
    B <--> D[JTAG UART]
    B <---> E[Parallel IO]
    B ---> F[System ID]
end
end
Z --> processor-subsystem
Y --> processor-subsystem
E <--> X
```

### Nios® V/m Processor IP
- 32-bit Microcontroller to achieve balance between performance and logic area utilization. 
- Implements RV32I_Zicsr instruction set.
- Supports five-stages pipelined or non-pipelined datapath.
- It is a customizable soft-core processor, that can be tailored to meet specific application requirements, providing flexibility and scalability in embedded system designs.
 
### Embedded Peripheral IP Cores
The following embedded peripheral IPs are used in this design:

- On-Chip RAM II IP
- JTAG UART IP
- Parallel IO IP
- System ID IP

### System Components
The following components are used in this design:

- Clock Source (Clock Bridge with IO PLL)
- Reset Source (Reset Controller with Synchronizer)
- IO Debounce Logic

### Nios® V/m Processor Address Map Details
 |Address Offset	|Size (Bytes)	|Peripheral	| Description|
  |-|-|-|-|
  |0x0000_0000|1MB|On-Chip RAM|To store application|
  |0x0011_0068|8|JTAG UART|Communication between a host PC and the Nios V processor system|
  |0x0011_0050|16|PIO 0|LED connections on board|
  |0x0011_0040|16|PIO 1|LED connections on board|
  |0x0011_0060|8|System ID|Hardware configuration system ID (0xa5)|
  ||||

## Development Kit Setup

Refer to [Agilex™ 5 FPGA Premium Development Kit User Guide](https://www.intel.com/content/www/us/en/docs/programmable/814550.html) to setup the development kit.

![Development Kit](../../devkit-img/devkit.png?raw=true)

## Exercising Prebuilt Binaries

### Program Hardware Binary SOF
1. Connect the development kit to the host PC using USB Blaster II.
2. Change the JTAG clock frequency to 6 MHz, and probe the JTAGServer to get the JTAG scan chain.
3. Execute the quartus_pgm command to program the SOF file with the correct device number. </br>Based on the JTAG scan chain below, the FPGA is at device number 2. You may require to provide a different device number if your JTAG chain is different from the given example.

```console
jtagconfig --setparam 1 JtagClock 6M
jtagconfig -d
quartus_pgm --cable=1 -m jtag -o 'p;ready_to_test/top.sof@2'
```

Example of JTAG Scan Chain:
```console
 1) Agilex 5E065B Premium DK
  4BA06477   ARM_CORESIGHT_SOC_600 (IR=4)
  0364F0DD   A5E(C065BB32AR0|D065BB32AR0) (IR=10)
  020D10DD   VTAP10 (IR=10)
    Design hash    2696B57EB10A539DFB3F
    + Node 08586E00  (110:11) #0
    + Node 0C006E00  JTAG UART #0
    + Node 0C206E00  JTAG PHY #0
    + Node 19104600  Nios II #0
    + Node 30006E00  Signal Tap #0
 
  Captured DR after reset = (4BA064770364F0DD020D10DD) [96]
  Captured IR after reset = (100555) [24]
  Captured Bypass after reset = (0) [3]
  Captured Bypass chain = (0) [3]
  JTAG clock speed auto-adjustment is enabled. To disable, set JtagClockAutoAdjust parameter to 0
  JTAG clock speed 6 MHz
```


### Program Software Image ELF
1. Ensure that the development kit is successfully configured with the Hardware Binary SOF file.
2. Launch the Nios V Command Shell. You may skip this if the shell is active.
3. Execute the following command to download the ELF file.

```console
niosv-shell
niosv-download -g ready_to_test/app.elf -c 1
```

### Run Serial Console
You may proceed to to display the application printouts, and verify the design.

```console
juart-terminal -d 1 -c 1 -i 0 
```

For example, you should see similar display at the end of the application.

![JTAG UART Display](./img/juart-terminal.png?raw=true)

## Rebuilding the Design 

### Generate Hardware Binary SOF
Run the following command in the terminal from the *source* directory. </br> 
The script performs the following tasks, which generates the hardware binary SOF file of this design.

1. Create a new project
2. Create a new Platform Designer system
3. Configure assignments and constraints
4. Compile the project
5. Generate a hardware binary SOF file
 
```console
quartus_py ./scripts/build_sof.py
```

### Generate Software Image ELF
After the hardware binary SOF file is ready, you may begin building the software design. </br>
It consists of the following steps:

1. Create a board support package (BSP) project.
2. Create a Nios® V processor application project with Hello World source code.
3. Build the Hello World application.
4. Generate a software image ELF file.

Launch the Nios V Command Shell. You may skip this if the shell is active. </br>
Run the following command in the shell from the *source* directory.
```console
niosv-shell
niosv-bsp -c --quartus-project=hw/top.qpf --qsys=hw/qsys_top.qsys --type=hal sw/bsp/settings.bsp
niosv-app --bsp-dir=sw/bsp --app-dir=sw/app --srcs=sw/app/main.c
cmake -S ./sw/app -B sw/app/build -G "Unix Makefiles"
make -C sw/app/build
```

### Program Hardware Binary SOF
1. Connect the development kit to the host PC using USB Blaster II.
2. Change the JTAG clock frequency to 6 MHz, and probe the JTAGServer to get the JTAG scan chain.
3. Execute the quartus_pgm command to program the SOF file with the correct device number. </br>Based on the JTAG scan chain below, the FPGA is at device number 2. You may require to provide a different device number if your JTAG chain is different from the given example.

```console
jtagconfig --setparam 1 JtagClock 6M
jtagconfig -d
quartus_pgm --cable=1 -m jtag -o 'p;hw/output_files/top.sof@2'
```

Example of JTAG Scan Chain:
```console
 1) Agilex 5E065B Premium DK
  4BA06477   ARM_CORESIGHT_SOC_600 (IR=4)
  0364F0DD   A5E(C065BB32AR0|D065BB32AR0) (IR=10)
  020D10DD   VTAP10 (IR=10)
    Design hash    2696B57EB10A539DFB3F
    + Node 08586E00  (110:11) #0
    + Node 0C006E00  JTAG UART #0
    + Node 0C206E00  JTAG PHY #0
    + Node 19104600  Nios II #0
    + Node 30006E00  Signal Tap #0
 
  Captured DR after reset = (4BA064770364F0DD020D10DD) [96]
  Captured IR after reset = (100555) [24]
  Captured Bypass after reset = (0) [3]
  Captured Bypass chain = (0) [3]
  JTAG clock speed auto-adjustment is enabled. To disable, set JtagClockAutoAdjust parameter to 0
  JTAG clock speed 6 MHz
```


### Program Software Image ELF
1. Ensure that the development kit is successfully configured with the Hardware Binary SOF file.
2. Launch the Nios V Command Shell. You may skip this if the shell is active.
3. Execute the following command to download the ELF file.

```console
niosv-shell
niosv-download -g sw/app/build/app.elf -c 1
```

### Run Serial Console
You may proceed to to display the application printouts, and verify the design.

```console
juart-terminal -d 1 -c 1 -i 0 
```

For example, you should see similar display at the end of the application.

![JTAG UART Display](./img/juart-terminal.png?raw=true)

## Simulating the Design

### Generate Hardware Design-Under-Test (DUT) and Testbench System
Run the following command in the terminal from the *source* directory. </br> 
The commands below perform the following tasks, which generates the hardware DUT and testbench system.

1. Create a new project
2. Create a new Platform Designer system
3. Generate testbench system
 
```console
quartus_py ./scripts/build_sof.py
qsys-generate hw/qsys_top.qsys --testbench=STANDARD --testbench-simulation=VERILOG
```

### Generate Software Image HEX
After the hardware DUT and testbench are ready, you may begin building the software design. </br>
It consists of the following steps:

1. Create a board support package (BSP) project.
2. Create a Nios® V processor application project with Hello World source code.
3. Build the Hello World application.
4. Generate a software image HEX file.

Launch the Nios V Command Shell. You may skip this if the shell is active. </br>
Run the following command in the shell from the *source* directory.
```console
niosv-shell
niosv-bsp -c --quartus-project=hw/top.qpf --qsys=hw/qsys_top.qsys --type=hal sw/bsp/settings.bsp
niosv-app --bsp-dir=sw/bsp --app-dir=sw/app --srcs=sw/app/main.c
cmake -S ./sw/app -B sw/app/build -G "Unix Makefiles"
make -C sw/app/build
elf2hex sw/app/build/app.elf -b 0x0 -w 32 -e 0xfffff hw/onchip_mem.hex -r4
```

### Check Simulation Files 
You have generated your system and created all the files necessary for simulation.

| File | Description |
| - | - |
| Working Directory/hw/qsys_top_tb | Generated testbench system |
| Working Directory/hw/qsys_top_tb/qsys_top_tb/sim/mentor/msim_setup.tcl | Questa simulation setup script |
| Working Directory/hw/onchip_mem.hex | On-Chip RAM II memory initialization file |

### Start Simulator
With all the necessary simulation files, you can start the simulation.

1. Copy the memory initialization file into *mentor* folder.
2. Change directory to the same *mentor* folder.
3. Open the **Questa for Altera FPGA** simulator using the command *vsim*.

```console
cp hw/onchip_mem.hex hw/qsys_top_tb/qsys_top_tb/sim/mentor 
cd hw/qsys_top_tb/qsys_top_tb/sim/mentor/
vsim
```

### Setup Simulator
In the **Questa for Altera FPGA** software, run the following commands in the **Transcript**.

```console
source msim_setup.tcl
ld_debug
```

### Run Simulation
Run the simulation with *run -all* command. <br/>
For example, you should see similar display at the start of the simulation.

![Simulation](./img/simulation.png?raw=true)


![Nios V Processor Header](../../devkit-img/niosv-header.png?raw=true)
