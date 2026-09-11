

## Introduction

RiscFree* is Ashling’s Eclipse* C/C++ Development Toolkit (CDT) based integrated development environment (IDE) for Altera® FPGAs Arm*-based HPS and RISC-V based Nios® V processors.

This page demonstrates how to use RiscFree* to debug U-Boot SPL and U-Boot.

For further information about RiscFree*, visit [The Ashling RiscFree IDE for Altera® FPGAs](https://www.altera.com/products/development-tools/ashling).

## Prerequisites

The following are needed:

- [Agilex 5 FPGA E-Series 065B Premium Development Kit (ES)](https://www.altera.com/products/devkit/po-3002/agilex-5-fpga-and-soc-e-series-premium-development-kit-es), ordering code DK-A5E065BB32AES1.

- Host PC with:
  - 64 GB of RAM. Less will be fine for only exercising the binaries, and not rebuilding the GSRD.
  - Linux OS installed. Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too
  - Serial terminal (for example GtkTerm or Minicom on Linux and TeraTerm or PuTTY on Windows)
  - Altera® Quartus<sup>&reg;</sup> Prime Pro Edition Version 26.1.1

You will also need to compile the [HPS Linux Boot Tutorial Example Design User Guide: Agilex 5 FPGA E-Series 065B Premium Development Kit (ES)](https://altera-fpga.github.io/rel-26.1.1/embedded-designs/agilex-5/e-series/premium/boot-examples/ug-linux-boot-agx5e-premium), refer to the *Boot from SD Card* section.

## Debug U-Boot

1\. Build the example design specified in the [Prerequisites](#prerequisites) section.

2\. Write the SD card image $TOP_FOLDER/sd_card/sdcard.img to the micro SD card and insert it on the slot on the HPS Enablement Board.

3\. Set MSEL dipswitch to JTAG, as specified in the design from the [Prerequisites](#prerequisites) section, then power cycle the board. That will ensure the device is not configured from QSPI.

4\.Add the Quartus and RiscFree* tools to the PATH:

```bash
source ~/altera_pro/26.1.1/qinit.sh
export PATH=~/altera_pro/26.1.1/riscfree/RiscFree:$PATH
```
5\. Configure the device with the 'debug' SOF, which contains an empty loop HPS FSBL, designed specifically for a debugger to connect afterwards:

```bash
cd $TOP_FOLDER
quartus_pgm -c 1 -m jtag -o "p;agilex5_soc_devkit_ghrd/output_files/baseline_a55_hps_debug.sof"
```

6\. Start RiscFree* Eclipse using a new workspace in the current folder:

```bash
cd $TOP_FOLDER
RiscFree -data workspace &
```

7\.  In Eclipse, go to **Run** > **Debug Configurations**, this will open the **Debug Configurations** window.

8\. In the **Debug Configurations** window, select **Ashling Arm Hardware Debugging** on the left panel, right-click it then select **New Configuration** from the menu.

![](images/01-new-arm-config.png)

9\. Edit the configuration as follows

* Change the **Name** to "Debug U-Boot"
* Go to the **Debugger** tab
* Select the **Debug Probe** from the drop down to match your board
* Click on the **Auto-detect Scan Chain** to discover the Arm cores
* Check the first **Cortex-A55** in the list to enable debugging for it

The window will look similar to this:

![](images/04-connection-done.png)

10\. Go to the **Startup** tab, and change the configuration as follows:

* Uncheck **Load image**
* Uncheck **Load symbols**
* Uncheck **Set breakpoint at**
* Uncheck **Resume**

The window will look similar to this:

![](images/05-startup-config.png)

Then add in the **Run Commands** box the following commands that will enable you to load U-Boot SPL and start debugging it:

```bash
interrupt
delete breakpoints
set breakpoint always-inserted on
set mem inaccessible-by-default on
mem 0x00000000 0x0007FFFF rw
mem 0x80000000 0xFFFFFFFF rw
mem 0x880000000 0xFFFFFFFFFF rw
set confirm off
restore u-boot-socfpga/spl/u-boot-spl-dtb.bin binary 0x0
symbol-file u-boot-socfpga/spl/u-boot-spl
set $pc=0x0
step
```

If you want to run U-Boot SPL up to where it decides which image to load next, add the following lines to the previous step:

```bash
thb board_boot_order
continue
```

If then you want to load U-Boot and start debugging it, add the following lines to the previous step, which will load U-Boot, run it until the memory is relocated, perform the relocation, then drop to debugging mode

```bash
delete breakpoints
set spl_boot_list[0]=0
set $pc=$lr
set $x0=0
restore u-boot-socfpga/u-boot.itb binary 0x82000000
symbol-file "u-boot-socfpga/u-boot" 
thb relocate_code
continue
delete breakpoints
set $offset = ((gd_t*)$x18)->reloc_off
symbol-file
add-symbol-file u-boot-socfpga/u-boot -o $offset
thb board_init_r
continue
```

If you only want to run U-Boot, without debugging it, then remove the "thb board_init_r" from the above script, so it would not stop at the beginning of U-Boot, and instead continue running it.

11\. Click the **Debug** button on the bottom of the window. Eclipse will warn that the program file was not specified. Click **Yes** to proceed with the launch.

![](images/06-no-program-file.png)

12\. Eclipse will suggest to move to the debug perspective. Click **Switch** to accept:

![](images/07-switch-debug-perspective.png)

13\. Eclipse will then run the specified sequence of instructions. 

When the instructions for debugging U-Boot SPL were used, after running them, Eclipse will show the U-Boot SPL started:

![](images/08-spl-started.png)

When the instructions for debugging U-Boot were used, after running them, Eclipse will show the U-Boot started:

![](images/09-u-boot-started.png)

At this point, all the debugging features of Eclipse are available, such as:

* Viewing and editing variables and registers
* Setting breakpoints
* Controlling execution: run step by step, step into functions 
