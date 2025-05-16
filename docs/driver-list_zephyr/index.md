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
| Clock Manager                                                |Agilex 5| HPS    | <a href="../zephyr-embedded/clock_manager/clock_manager" target="_blank">Clock Manager</a> | Yes                                                          | <a href="https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/clock_control/clock_control_agilex5.c" target="_blank">clock_control_agilex5</a> |
| Cold & Warm Reset -Power State Coordination Interface (PSCI) |Agilex 5| HPS    | <a href="../zephyr-embedded/psci/psci" target="_blank">PSCI</a> | Yes                                                          | <a href="https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/pm_cpu_ops/pm_cpu_ops_psci.c" target="_blank">pm_cpu_ops_psci</a> |
| DMA Controller                                                         |Agilex 5| HPS    | <a href="../zephyr-embedded/dma/dma" target="_blank">DMAC</a> | Yes                                                          | <a href="https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/dma/dma_dw_axi.c" target="_blank">dma</a> |
| General Purpose Timer                                        |Agilex 5| HPS    | <a href="../zephyr-embedded/timer/timer" target="_blank">Timer</a> | Yes                                                          | <a href="https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/counter/counter_dw_timer.c" target="_blank">counter_dw_timer</a> |
| GPIO                                                         |Agilex 5| HPS    | <a href="../zephyr-embedded/gpio/gpio" target="_blank">gpio</a> | No                                                           | <a href="https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/gpio/gpio_intel_socfpga.c" target="_blank">gpio_intel_socfpga</a> |
| QSPI                                                         |Agilex 5| HPS    | <a href="../zephyr-embedded/qspi/qspi" target="_blank">QSPI</a> | Yes                                                          | <a href="https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/flash/flash_cadence_qspi_nor.c" target="_blank">flash_cadence_qspi_nor</a> |
| Reset Manager                                                |Agilex 5| HPS    | <a href="../zephyr-embedded/reset_manager/reset_manager" target="_blank">Reset Manager</a> | Yes                                                          | <a href="https://github.com/zephyrproject-rtos/zephyr/commits/main/drivers/reset/reset_intel_socfpga.c" target="_blank">reset_intel_socfpga</a> |
| Single Event Upset (SEU)                                     |Agilex 5| HPS    | <a href="../zephyr-embedded/seu/seu" target="_blank">SEU</a> | <a href="https://github.com/zephyrproject-rtos/zephyr/pull/67097" target="_blank">In Progress</a> | <a href="https://github.com/zephyrproject-rtos/zephyr/pull/67097" target="_blank">pull/67097</a> |
| SMP                                                          |Agilex 5| HPS    | <a href="../zephyr-embedded/smp/smp" target="_blank">SMP</a> | Yes                                                          | <a href="https://github.com/zephyrproject-rtos/zephyr/blob/main/arch/arm64/core/smp.c" target="_blank">smp</a> |
| UART                                                         |Agilex 5| HPS    | <a href="../zephyr-embedded/uart/uart" target="_blank">UART</a> | Yes                                                          | <a href="https://github.com/zephyrproject-rtos/zephyr/commits/main/drivers/serial/uart_ns16550.c" target="_blank">uart_ns16550</a> |
| Watchdog Timer                                               |Agilex 5| HPS    | <a href="../zephyr-embedded/watchdog/watchdog" target="_blank">Watchdog Timer</a> | Yes                                                          | <a href="https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/watchdog/wdt_dw.c" target="_blank">wdt_dw</a> |
