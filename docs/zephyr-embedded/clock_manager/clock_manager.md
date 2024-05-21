# **Clock Manager Driver for Hard Processor System**

Last updated: **May 21, 2024** 

**Upstream Status**: [Upstreamed](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/clock_control/clock_control_agilex5.c)

**Devices supported**: Agilex 5

Note: The clock manager IP is slightly different in Agilex5 vs Agilex7. Though both are supported and upstreamed, here we will describe only with respect to Agilex5 and most of these descriptions will apply to Agilex7 also.

## **Introduction**

Clock Manager is an Intel PSG proprietary IP which supplies the clock for all HPS peripherals. Clock Manager will be initialized only one time during boot up by the FSBL (ATF BL2) based on external user settings stored in HPS handoff data in the bitstream. TheZephyr Clock Manager driver will provide the API to retrieve the clock frequency of each peripheral.

For more information please refer to the [Intel Agilex 5 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/814346).

## **Driver Sources**

The source code for this driver can be found at [https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/clock_control/clock_control_agilex5.c](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/clock_control/clock_control_agilex5.c).

## **Driver Capabilities**

* Supply clock to each HPS peripheral as configured in the boot loader and provides an API to retrieve the clock for each peripheral.

## **Kernel Configurations**

CONFIG_CLOCK_CONTROL

![clock_control](images/clock_control.png)

CONFIG_CLOCK_CONTROL_AGILEX5

![clock_control_agilex5](images/clock_control_agilex5.png)

## **Device Tree**

Example Device tree location:

[https://github.com/zephyrproject-rtos/zephyr/blob/main/dts/arm64/intel/intel_socfpga_agilex5.dtsi](https://github.com/zephyrproject-rtos/zephyr/blob/main/dts/arm64/intel/intel_socfpga_agilex5.dtsi)

![clock_manager_device_tree](images/clock_manager_device_tree.png)

A clock manager node will be added in device tree.  Then, the peripheral can associate the clock manager in device tree so that the peripheral driver code can retrieve the clock frequency from clock manager. One such example is shown below.

![clock_manager_uart_dt_example](images/clock_manager_uart_dt_example.png)

## **Known Issues**

None Known. 
