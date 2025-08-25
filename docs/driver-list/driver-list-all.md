# All Drivers, Altera Driver

This table comprehensively lists all Altera drivers available for Agilex 3, Agilex 5 and Agilex 7. 

You can filter your search by entering your query into any number of available columns.

- The Name column indicate the name of the IP that the driver supports.
- If a driver exists then a link to a driver page is provided for more details. N/A means driver support "Not Available" for the particular IP.

| **IP Name** | Linux Driver | Zephyr Driver |
| :-------:|:-----------------:|:----------:|
| Altera 16550 Compatible UART Core                            | <a href="../linux-dfl/uart_16550/uart_16550.md" target="_blank">Linux</a> | <a href="../zephyr-embedded/uart/uart.md" target="_blank">Zephyr</a> |
| Altera Hardware Monitor                                      | <a href="../linux-embedded/hwmon/hwmon.md" target="_blank">Linux</a> | N/A                                                          |
| Clock Manager                                                | <a href="../linux-embedded/clock_manager/clock_manager.md" target="_blank">Linux</a> | <a href="../zephyr-embedded/clock_manager/clock_manager.md" target="_blank">Zephyr</a> |
| Cold & Warm Reset -Power State Coordination Interface (PSCI) | N/A                                                          | <a href="../zephyr-embedded/psci/psci.md" target="_blank">PSCI</a> |
| Device Feature List (DFL) Capability                         | <a href="../linux-dfl/dfl/dfl.md" target="_blank">Linux</a>  | N/A                                                          |
| DFL Accelerator Functional Unit (AFU workload)               | <a href="../linux-dfl/dfl_afu/dfl_afu.md" target="_blank">Linux</a> | N/A                                                          |
| DFL FPGA Management Engine IP                                | <a href="../linux-dfl/dfl_fme/dfl_fme.md" target="_blank">Linux</a> | N/A                                                          |
| DFL Memory Interface/Subsystem                               | <a href="../linux-dfl/dfl_emif/dfl_emif.md" target="_blank">Linux</a> | N/A                                                          |
| DFL Time of Day Clock Intel FPGA IP                          | <a href="../linux-dfl/ptp_dfl_tod/ptp_dfl_tod.md" target="_blank">Linux: Host Attach TOD</a>   <a href="../linux-embedded/ptp_dfl_tod/ptp_dfl_tod.md" target="_blank">Linux: Embedded TOD</a> | N/A                                                          |
| Direct Memory Access Controller (DMAC)                       | <a href="../linux-embedded/dma/dma.md" target="_blank">Linux</a> | <a href="../zephyr-embedded/dma/dma.md" target="_blank">Zephyr</a> |
| Error Detection and Correction (EDAC)                        | <a href="../linux-embedded/edac/edac.md" target="_blank">Linux</a> | N/A                                                          |
| Ethernet Media Access Controller                             | <a href="../linux-embedded/emac/emac.md" target="_blank">Linux</a> | N/A                                                          |
| Ethernet Subsystem (HSSI SS)                                 | <a href="../linux-embedded/hssi/hssi.md" target="_blank">Linux</a> | N/A                                                          |
| Ethernet Subsystem Intel FPGA IP (HSSI xTile)                | <a href="../linux-embedded/hssi_xtile/hssi_xtile.md" target="_blank">Linux</a> | N/A                                                          |
| Ethernet 1588 PTP Time of Day Clock                          | <a href="../linux-dfl/ptp_dfl_tod/ptp_dfl_tod.md" target="_blank">Linux</a> | N/A                                                          |
| General Purpose Timers                                       | <a href="../linux-embedded/apb_timers/apb_timers.md" target="_blank">Linux</a> | N/A                                                          |
| Generic Serial Flash Interface Intel FPGA IP                 | <a href="../linux-dfl/spi_altera_dfl/spi_altera_dfl.md" target="_blank">Linux</a> | N/A                                                          |
| GPIO                                                         | <a href="../linux-embedded/gpio/gpio.md" target="_blank">Linux</a> | <a href="../zephyr-embedded/gpio/gpio.md" target="_blank">Zephyr</a> |
| I2C                                                          | <a href="../linux-embedded/i2c/i2c.md" target="_blank">Linux</a> | N/A                                                          |
| I3C                                                          | <a href="../linux-embedded/i3c/i3c.md" target="_blank">Linux</a> | N/A                                                          |
| Interrupt Controller (GICv3)                                 | <a href="../linux-embedded/interrupt_controller_GICv3/irq_gic_v3.md" target="_blank">Linux</a> | Agilex 5   Agilex 7                                          |
| Microchip® Zarlink ZL30793 Network Synchronizer              | <a href="../linux-embedded/zarlink_clock_synchronizer/zarlink_clock_synchronizer.md" target="_blank">Linux</a> | N/A                                                          |
| MSGDMA                                                       | <a href="../linux-embedded/dma/msgdma/msgdma.md" target="_blank">Linux</a> | N/A                                                          |
| NAND Controller                                              | <a href="../linux-embedded/nand/nand.md" target="_blank">Linux</a> | N/A                                                          |
| PCIe Subsystem                                               | <a href="../linux-dfl/dfl-pci/dfl-pcie.md" target="_blank">Linux</a> | N/A                                                          |
| QSPI                                                         | <a href="../linux-embedded/qspi/qspi.md" target="_blank">Linux</a> | <a href="../zephyr-embedded/qspi/qspi.md" target="_blank">Zephyr</a> |
| QSFP                                                         | <a href="../linux-embedded/qsfp/qsfp.md" target="_blank">Linux</a> | N/A                                                          |
| Reset Manager                                                | <a href="../linux-embedded/reset_manager/reset_manager.md" target="_blank">Linux</a> | <a href="../zephyr-embedded/reset_manager/reset_manager.md" target="_blank">Zephyr</a> |
| Single Error Upset (SEU)                                     | N/A                                                          | <a href="../zephyr-embedded/seu/seu.md" target="_blank">Zephyr</a> |
| SD/eMMC Controller                                           | <a href="../linux-embedded/sd-emmc/sd-emmc.md" target="_blank">Linux</a> | N/A                                                          |
| SMMU                                                         | <a href="../linux-embedded/smmu/smmu.md" target="_blank">Linux</a> | N/A                                                          |
| SPI                                                          | <a href="../linux-embedded/spi/spi.md" target="_blank">Linux</a> | N/A                                                          |
| System Manager                                               | <a href="../linux-embedded/system_manager/system_manager.md" target="_blank">Linux</a> | N/A                                                          |
| Timer                                                        | N/A                                                          | <a href="../zephyr-embedded/timer/timer.md" target="_blank">Zephyr</a> |
| UART                                                         | <a href="../linux-embedded/uart/uart.md" target="_blank">Linux</a> | N/A                                                          |
| USB 2.0 OTG                                                  | <a href="../linux-embedded/usb2_0_otg/usb2_0_otg.md" target="_blank">Linux</a> | N/A                                                          |
| Watchdog Timer                                               | <a href="../linux-embedded/watchdog_timers/watchdog_timers.md" target="_blank">Linux</a> | <a href="../zephyr-embedded/watchdog/watchdog.md" target="_blank">Zephyr</a> |
