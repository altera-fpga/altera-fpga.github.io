

## Introduction

Arm* Development Studio for Altera® SoC FPGAs is an Eclipse based tool suite enabling Arm* software development and debugging for Altera® FPGAs.

This page demonstrates how to use Arm* Development Studio to debug U-Boot SPL and U-Boot. For further information about the tool, go to [Arm Development Studio](https://developer.arm.com/Tools%20and%20Software/Arm%20Development%20Studio).

## Prerequisites

The following are needed:

* [Altera&reg; Agilex&trade; 5 FPGA E-Series 065B Premium Development Kit](https://www.altera.com/products/devkit/po-3284/agilex-5-fpga-e-series-065b-premium-development-kit), ordering code DK-A5E065BB32AEA.

- Host PC with:
  - 64 GB of RAM. Less will be fine for only exercising the binaries, and not rebuilding the GSRD.
  - Linux OS installed. Ubuntu 22.04LTS was used to create this page, other versions and distributions may work too
  - Serial terminal (for example GtkTerm or Minicom on Linux and TeraTerm or PuTTY on Windows)
  - Altera® Quartus<sup>&reg;</sup> Prime Pro Edition Version 26.1.1
  - Arm Development Studio 2025.1

You will also need to compile the [HPS Linux Boot Tutorial Example Design User Guide: Agilex™ 5 FPGA E-Series 065B Premium Development Kit](https://altera-fpga.github.io/rel-26.1.1/embedded-designs/agilex-5/e-series/premium-065b/boot-examples/ug-linux-boot-agx5e-premium-065b), refer to the *Boot from SD Card* section.

## Debug U-Boot

1\. Build the example design as specified above.

2\. Write the SD card image $TOP_FOLDER/sd_card/sdcard.img to the micro SD card and insert it on the slot on the HPS Enablement Board.

3\. Set MSEL dipswitch to JTAG, then power cycle the board. That will ensure the device is not configured from QSPI.


4\. Add the Quartus® tools in the path:

```bash
source ~/altera_pro/26.1.1/qinit.sh
```

5\. Configure the device with the 'debug' SOF, which contains an empty loop HPS FSBL, designed specifically for a debugger to connect afterwards:

```bash
cd $TOP_FOLDER
quartus_pgm -c 1 -m jtag -o "p;agilex5_soc_devkit_ghrd_a55/output_files/baseline_a55_hps_debug.sof"
```

6\. Start Arm* DS Eclipse using a new workspace in the current folder:

```bash
cd $TOP_FOLDER
/opt/arm/developmentstudio-2025.1/bin/suite_exec -t "Arm Compiler for Embedded 6" bash
armds_ide -data workspace &
```

7\. In Eclipse go to **Run** > **Debug Configurations** then select the **Generic Arm/C++ Application** and select **New launch configuration**: 

![](images/01-new-lauch-config.png)

8\. Change the **Name** of the configuration as **Debug U-Boot**. Select target as **Altera® SoC FPGA** > **Agilex 5** > **Bare Metal Debug** > **Cortex-A55_0**. Select target connection as **Altera® FPGA Download Cable**:

![](images/02-connection.png)

9\. Click on the **Connections** > **Browse** button and select the board connection, then click the **Select** button:

![](images/03-debug-cable-selection.png)

10\. In the **Debugger** tab, select **Connect Only**, click **Execute debugger commands** and enter the desired debugging commands shown below. Also uncheck **Use default** for the **Host working directory** and enter the parent folder of the workspace: "${workspace_loc}/../" :

![](images/04-debugger-config.png)

If you want to just load U-Boot SPL and start debugging it, enter the following debugging commands:

```bash
interrupt
restore "u-boot-socfpga/spl/u-boot-spl-dtb.bin" binary 0x0
loadfile "u-boot-socfpga/spl/u-boot-spl"
set $PC = 0x0
```

If you want to run U-Boot SPL to completion, up to the point where it decides what to load as next boot stage, add the following commands:

```bash
thb board_boot_order
continue
wait 60s
```

If after running U-Boot SPL to completion you want to load and run U-Boot, add the following commands:

```bash
set var $AARCH64::$Core::$X1 = 0
set spl_boot_list[0]=0
set $PC=$LR
restore "u-boot-socfpga/u-boot.itb" binary 0x82000000
continue
```

Instead, if you want to load U-Boot and start debugging it, replace the previous **continue** command with the following:

```bash
symbol-file "u-boot-socfpga/u-boot" 
thb el2:relocate_code
continue
wait 60s
symbol-file "u-boot-socfpga/u-boot" ((gd_t*)$x18)->reloc_off
thb board_init_r
continue
wait 60s
```

11\. Click on the **Debug** button at the bottom of the **Debug Configurations** window. Eclipse Arm* DS will connect to the board and execute the debugger instructions.

If you opted to debug U-Boot SPL the window will look as below, showing U-Boot SPL stopped at its entry point:

![](images/05-spl-started.png)

If you opted to debug U-Boot, it will show it stopped at board_init_r, after the symbol relocation:

![](images/06-u-boot-started.png)

At this point, all the debugging features of Eclipse are available, such as:

* Viewing and editing variables and registers
* Setting breakpoints
