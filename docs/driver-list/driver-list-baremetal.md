# Baremetal Drivers

## Overview

This page presents the pre-release of the Agilex 5 baremetal drivers. The purpose of the drivers is to provide developers with access to the low-level functionality of the HPS IP blocks, including the ability to access IP registers. The drivers are provided through the following git repository: [https://github.com/altera-fpga/baremetal-drivers](https://github.com/altera-fpga/baremetal-drivers) and  are released under the [MIT License](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/LICENSE). 

Resources:

* [Documentation](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/DOCUMENTATION.md)
* [API Construction](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/DESIGN.md)
* [Build Details](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/BUILD.md)
* [Release Notes](https://github.com/altera-fpga/baremetal-drivers/releases/tag/24.3.1)

Majority of validation for this pre-release was done on the Intel Simics Simulator for Intel FPGAs.

## Demo

The following demo is provided:

 * [Agilex™ 5 E-Series Premium Development Kit Baremetal Hello World](https://altera-fpga.github.io/rel-24.3.1/baremetal-embedded/agilex-5/e-series/premium/ug-baremetal-agx5e-premium/)

## Driver List
 
| **Name** | Documentation | Source |
| :--:|:--:|:--:|
|Clock Manager|[clkmgr](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/clkmgr/clkmgr.md)|[clkmgr](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/clkmgr)|
|Combophy for SDMMC|[combophy](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/combophy/combophy.md)|[combophy](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/combophy)|
|DMA|[dma](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/dma/dma.md)|[dma](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/dma)|
|GIC|[gic](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/gic/gic.md)|[gic](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/gic)|
|General Purpose IO|[gpio](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/gpio/gpio.md)|[gpio](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/gpio)|
|HPS Mailbox to SDM|[mailbox](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/mailbox/mailbox.md)|[mailbox](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/mailbox)|
|I2C|[i2c](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/i2c/i2c.md)|[i2c](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/i2c)|
|I3C|[i3c](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/i3c/i3c.md)|[i3c](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/i3c)|
|MMU|[mmu](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/mmu/mmu.md)|[mmu](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/mmu)|
|Reset Manager|[rstmgr](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/rstmgr/rstmgr.md)|[rstmgr](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/rstmgr)|
|SDMMC|[sdmmc](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/sdmmc/sdmmc.md)|[sdmmc](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/sdmmc)|
|SPI|[spi](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/spi/spi.md)|[spi](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/spi)|
|System Manager|[sysmgr](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/sysmgr/sysmgr.md)|[sysmgr](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/sysmgr)|
|Timers|[timer](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/timer/timer.md)|[timer](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/timer)|
|UART|[uart](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/uart/uart.md)|[uart](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/uart)|
|Watchdog Timers|[watchdog](https://github.com/altera-fpga/baremetal-drivers/blob/24.3.1/inc/watchdog/watchdog.md)|[watchdog](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1/src/watchdog)|
