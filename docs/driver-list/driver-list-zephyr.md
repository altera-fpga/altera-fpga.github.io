# **Zephyr Drivers**

The table below provides a comprehensive list of embedded Zephyr drivers available for the HPS and Nios V on Agilex 5 FPGA devices.
  
* IP Name column indicates what type of IP the driver targets. 
* Target is 
* Documentation column provides a link to driver description, architectural details, driver capabilities and configurations, known issues and release information.
* Upstream Status column indicates mainstream status of driver.
* Kernel Source indicates location of driver.

You can use the filter fields to narrow your search.

 | **IP Name**    | Supported Device(s)    |  Target | Documentation | Upstream Status | Kernel Source|
| :-------:|:-----------:|:-----------------:|:----------:|:------------:|:-----------|
| Arm<sup>&reg;</sup> Silicon Provider (SiP) Services | Agilex 5 | HPS | [SiP-SVC](../zephyr-embedded/sip_svc/sip_svc.md) | [Yes]((https://github.com/zephyrproject-rtos/zephyr/tree/main/subsys/sip_svc)) | [sip_smc_intel_socfpga](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/sip_svc/sip_smc_intel_socfpga.c)|
| Clock Manager  | Agilex 5 | HPS | [Clock Manager](../zephyr-embedded/clock_manager/clock_manager.md) | Yes | [clock_control_agilex5]( https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/clock_control/clock_control_agilex5.c) |
| FPGA Bridge | Agilex 5 | HPS | [FPGA Bridge](../zephyr-embedded/fpga_bridge/fpga_bridge.md) | In Progress | [fpga_altera_agilex_bridge](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/fpga/fpga_altera_agilex_bridge.c) |
| General Purpose Timer  | Agilex 5 | HPS | [Timer](../zephyr-embedded/timer/timer.md) | Yes | [counter_dw_timer]( https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/counter/counter_dw_timer.c ) |
| GPIO  | Agilex 5 | HPS | [gpio](../zephyr-embedded/gpio/gpio.md) | No | [gpio_intel_socfpga]( https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/gpio/gpio_intel_socfpga.c) |
| Interrupt Latency Calculator | Agilex 5 | HPS | [ILC](../zephyr-embedded/ilc/ilc.md) | In Progress | [pull/68518](https://github.com/zephyrproject-rtos/zephyr/pull/68518)|
| Interrupt Controller (GICv3)  | Agilex 5 | HPS | [GIC](../zephyr-embedded/GIC/gic.md) | Yes | [intc_gicv3]( https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/interrupt_controller/intc_gicv3.c) |
| NAND  | Agilex 5 | HPS |  [NAND](../zephyr-embedded/nand/nand.md) | Yes | [flash_cadence_nand](https://github.com/zephyrproject-rtos/zephyr/tree/main/drivers/flash/flash_cadence_nand.c) |
| Power State Coordination Interface (PSCI) | Agilex 5 | [PSCI](../zephyr-embedded/psci/psci.md) | Yes | [pm_cpu_ops_psci](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/pm_cpu_ops/pm_cpu_ops_psci.c) |
| QSPI  | Agilex 5 | HPS | [QSPI](../zephyr-embedded/qspi/qspi.md) | No | [flash_cadence_qspi_nor](https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/flash/flash_cadence_qspi_nor.c) |
| Reset Manager  | Agilex 5 | HPS | [Reset Manager](../zephyr-embedded/reset_manager/reset_manager.md) | Yes | [reset_intel_socfpga](https://github.com/zephyrproject-rtos/zephyr/commits/main/drivers/reset/reset_intel_socfpga.c) |
| Remote OS Update  | Agilex 5 | HPS | [Remote OS Update](../zephyr-embedded/remote_os_update/remote_os_update.md) | Yes|[socfpga_ros](https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/+/refs/heads/master/plat/intel/soc/common/socfpga_ros.c) |
| SD/eMMC  | Agilex 5 | HPS | [SD/eMMC](../zephyr-embedded/sd-mmc/sd-mmc.md) | Yes | [sdhci-cadence]( https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-cadence.c ) |
| Single Event Upset (SEU) | Agilex 5 | HPS | [SEU](../zephyr-embedded/seu/seu.md) | [In Progress]((https://github.com/zephyrproject-rtos/zephyr/pull/67097)) | [pull/67097](https://github.com/zephyrproject-rtos/zephyr/pull/67097)|
| SPI  | Agilex 5 | HPS | [SPI](../zephyr-embedded/spi/spi.md) | Yes | [spi_dw]( https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/spi/spi_dw.c ) |
| SMP  | Agilex 5 | HPS | [SMP](../zephyr-embedded/smp/smp.md) | Yes | [smp]( https://github.com/zephyrproject-rtos/zephyr/blob/main/arch/arm64/core/smp.c ) |
| UART | Agilex 5 | HPS | [UART](../zephyr-embedded/uart/uart.md) | Yes | [uart_ns16550](  https://github.com/zephyrproject-rtos/zephyr/commits/main/drivers/serial/uart_ns16550.c) |
| USB 2.0  | Agilex 5 | HPS | [USB 2.0](../zephyr-embedded/usb2_0_otg/usb_2_0_otg.md) | No | [uhc_dwc_hs](  https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/usb/uhc/uhc_dwc_hs.c) |
| Watchdog Timer | Agilex 5 | HPS | [Watchdog Timer](../zephyr-embedded/watchdog/watchdog.md) | Yes | [wdt_dw](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/watchdog/wdt_dw.c) |

