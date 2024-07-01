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
| Arm<sup>&reg;</sup> Silicon Provider (SiP) Services | Agilex 5 | HPS | [SiP-SVC](../zephyr-embedded/sip_svc/sip_svc.md) | Yes | [sip_smc_intel_socfpga](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/sip_svc/sip_smc_intel_socfpga.c)|
| Clock Manager  | Agilex 5 | HPS | [Clock Manager](../zephyr-embedded/clock_manager/clock_manager.md) | Yes | [clock_control_agilex5]( https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/clock_control/clock_control_agilex5.c) |
| Cold & Warm Reset -Power State Coordination Interface (PSCI) | Agilex 5 | HPS | [PSCI](../zephyr-embedded/psci/psci.md) | Yes | [pm_cpu_ops_psci](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/pm_cpu_ops/pm_cpu_ops_psci.c) |
| DMAC | Agilex 5 | HPS | [DMAC](../zephyr-embedded/dma/dma.md) | Yes | [dma](https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/dma/dma_dw_axi.c) |
| General Purpose Timer  | Agilex 5 | HPS | [Timer](../zephyr-embedded/timer/timer.md) | Yes | [counter_dw_timer]( https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/counter/counter_dw_timer.c ) |
| GPIO  | Agilex 5 | HPS | [gpio](../zephyr-embedded/gpio/gpio.md) | No | [gpio_intel_socfpga]( https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/gpio/gpio_intel_socfpga.c) |
| Cold & Warm Reset -Power State Coordination Interface (PSCI)  | Agilex 5 | HPS | [psci](../zephyr-embedded/psci/psci.md) | No | [psci]( https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/pm_cpu_ops/pm_cpu_ops_psci.c) |
| QSPI  | Agilex 5 | HPS | [QSPI](../zephyr-embedded/qspi/qspi.md) | Yes | [flash_cadence_qspi_nor](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/flash/flash_cadence_qspi_nor.c) |
| Reset Manager  | Agilex 5 | HPS | [Reset Manager](../zephyr-embedded/reset_manager/reset_manager.md) | Yes | [reset_intel_socfpga](https://github.com/zephyrproject-rtos/zephyr/commits/main/drivers/reset/reset_intel_socfpga.c) |
| Single Event Upset (SEU) | Agilex 5 | HPS | [SEU](../zephyr-embedded/seu/seu.md) | [In Progress]((https://github.com/zephyrproject-rtos/zephyr/pull/67097)) | [pull/67097](https://github.com/zephyrproject-rtos/zephyr/pull/67097)|
| SMP  | Agilex 5 | HPS | [SMP](../zephyr-embedded/smp/smp.md) | Yes | [smp]( https://github.com/zephyrproject-rtos/zephyr/blob/main/arch/arm64/core/smp.c ) |
| UART | Agilex 5 | HPS | [UART](../zephyr-embedded/uart/uart.md) | Yes | [uart_ns16550](  https://github.com/zephyrproject-rtos/zephyr/commits/main/drivers/serial/uart_ns16550.c) |
| Watchdog Timer | Agilex 5 | HPS | [Watchdog Timer](../zephyr-embedded/watchdog/watchdog.md) | Yes | [wdt_dw](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/watchdog/wdt_dw.c) |

