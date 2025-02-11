# Baremetal Drivers

## Overview

This page presents the pre-release of the Agilex 5 baremetal drivers. The purpose of the drivers is to provide developers with access to the low-level functionality of the HPS IP blocks, including the ability to access IP registers. The drivers are provided through the following git repository: [https://github.com/altera-fpga/baremetal-drivers](https://github.com/altera-fpga/baremetal-drivers) and  are released under the [MIT License](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/LICENSE). 

Resources:

* [Documentation](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/DOCUMENTATION.md)
* [API Construction](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/DESIGN.md)
* [Build Details](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/BUILD.md)
* [Release Notes](https://github.com/altera-fpga/baremetal-drivers/releases/tag/QPDS24.3.1_REL_GSRD_PR)

Majority of validation for this pre-release was done on the Intel Simics Simulator for Intel FPGAs.

## Demo

The following demo is provided:

 * [Agilex™ 5 E-Series Premium Development Kit Baremetal Hello World](https://altera-fpga.github.io/rel-24.3.1/baremetal-embedded/agilex-5/e-series/premium/ug-baremetal-agx5e-premium/)

## Driver List
 
| **Name** | Documentation | Source |
| :--:|:--:|:--:|
|Clock Manager|[clkmgr](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/clkmgr/clkmgr.md)|[clkmgr](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/clkmgr)|
|Combophy for SDMMC|[combophy](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/combophy/combophy.md)|[combophy](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/combophy)|
|DMA|[dma](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/dma/dma.md)|[dma](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/dma)|
|GIC|[gic](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/gic/gic.md)|[gic](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/gic)|
|General Purpose IO|[gpio](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/gpio/gpio.md)|[gpio](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/gpio)|
|HPS Mailbox to SDM|[hps_mailbox](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/hps_mailbox/hps_mailbox.md)|[hps_mailbox](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/hps_mailbox)|
|I2C|[i2c](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/i2c/i2c.md)|[i2c](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/i2c)|
|I3C|[i3c](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/i3c/i3c.md)|[i3c](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/i3c)|
|MMU|[mmu](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/mmu/mmu.md)|[mmu](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/mmu)|
|Reset Manager|[rstmgr](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/rstmgr/rstmgr.md)|[rstmgr](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/rstmgr)|
|SDMMC|[sdmmc](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/sdmmc/sdmmc.md)|[sdmmc](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/sdmmc)|
|SPI|[spi](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/spi/spi.md)|[spi](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/spi)|
|System Manager|[sysmgr](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/sysmgr/sysmgr.md)|[sysmgr](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/sysmgr)|
|Timers|[timer](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/timer/timer.md)|[timer](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/timer)|
|UART|[uart](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/uart/uart.md)|[uart](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/uart)|
|Watchdog Timers|[watchdog](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS24.3.1_REL_GSRD_PR/inc/watchdog/watchdog.md)|[watchdog](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS24.3.1_REL_GSRD_PR/src/watchdog)|
