# Baremetal Drivers

## Overview

This page presents the pre-release of the Agilex 5 baremetal drivers. The purpose of the drivers is to provide developers with access to the low-level functionality of the HPS IP blocks, including the ability to access IP registers. The drivers are provided through the following git repository: [https://github.com/altera-fpga/baremetal-drivers](https://github.com/altera-fpga/baremetal-drivers) and  are released under the [MIT License](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/LICENSE). 

Resources:

* [Documentation](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/DOCUMENTATION.md)
* [API Construction](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/DESIGN.md)
* [Build Details](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/BUILD.md)
* [Release Notes](https://github.com/altera-fpga/baremetal-drivers/releases/tag/QPDS25.1.1_REL_GSRD_PR)

Validation for this pre-release was done on the Intel Simics Simulator for Intel FPGAs and on Agilex 5 Premium Development Kit.

## Demo

The following demo is provided:

 * [Agilex™ 5 E-Series Premium Development Kit Baremetal Hello World](https://altera-fpga.github.io/rel-25.1.1/baremetal-embedded/agilex-5/e-series/premium/ug-baremetal-agx5e-premium/)

## Driver List
 
| **Name** | Device | Documentation | Source |
| :--:|:--:|:--:|:--:|
|Clock Manager|Agilex 5|[clkmgr](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/clkmgr/clkmgr.md)|[clkmgr](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/clkmgr)|
|Combophy for SDMMC|Agilex 5|[combophy](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/combophy/combophy.md)|[combophy](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/combophy)|
|DMA|Agilex 5|[dma](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/dma/dma.md)|[dma](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/dma)|
|ECC|Agilex 5|[ecc](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/ecc/ecc.md)|[ecc](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/ecc)|
|GIC|Agilex 5|[gic](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/gic/gic.md)|[gic](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/gic)|
|General Purpose IO|Agilex 5|[gpio](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/gpio/gpio.md)|[gpio](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/gpio)|
|HPS Mailbox to SDM|Agilex 5|[hps_mailbox](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/hps_mailbox/hps_mailbox.md)|[hps_mailbox](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/hps_mailbox)|
|I2C|Agilex 5|[i2c](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/i2c/i2c.md)|[i2c](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/i2c)|
|I3C|Agilex 5|[i3c](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/i3c/i3c.md)|[i3c](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/i3c)|
|MMU|Agilex 5|[mmu](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/mmu/mmu.md)|[mmu](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/mmu)|
|NoC Firewall|Agilex 5|[noc_firewall](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/noc_firewall/noc_firewall.md)|[noc_firewall](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/noc_firewall)|
|NoC Probe|Agilex 5|[noc_probe](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/noc_probe/noc_probe.md)|[noc_probe](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/noc_probe)|
|QSPI|Agilex 5|[qspi](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/qspi/qspi.md)|[qspi](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/qspi)|
|Reset Manager|Agilex 5|[rstmgr](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/rstmgr/rstmgr.md)|[rstmgr](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/rstmgr)|
|SDMMC|Agilex 5|[sdmmc](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/sdmmc/sdmmc.md)|[sdmmc](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/sdmmc)|
|SMMU|Agilex 5|[smmu](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/smmu/smmu.md)|[sdmmc](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/smmu)|
|SPI|Agilex 5|[spi](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/spi/spi.md)|[spi](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/spi)|
|System Manager|Agilex 5|[sysmgr](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/sysmgr/sysmgr.md)|[sysmgr](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/sysmgr)|
|Timers|Agilex 5|[timer](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/timer/timer.md)|[timer](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/timer)|
|UART|Agilex 5|[uart](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/uart/uart.md)|[uart](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/uart)|
|Watchdog Timers|Agilex 5|[watchdog](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/watchdog/watchdog.md)|[watchdog](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/watchdog)|
|XGMAC|Agilex 5|[xgmac](https://github.com/altera-fpga/baremetal-drivers/blob/QPDS25.1.1_REL_GSRD_PR/inc/xgmac/xgmac.md)|[watchdog](https://github.com/altera-fpga/baremetal-drivers/tree/QPDS25.1.1_REL_GSRD_PR/src/xgmac)|