# **General Purpose Timer Driver for Hard Processor System**

**Upstream Status**: [Upstreamed](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/counter/counter_dw_timer.c)

**Devices supported**: Agilex 5

## **Introduction**

The hard processor system (HPS) provides four 32-bit general-purpose timers. The timer generates an interrupt when the 32-bit binary count-down timer reaches zero.

Each timer can operate in one-shot mode (alarm mode) or periodic mode.

For more information, please refer to the following link:
[Agilex 5 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/814346/24-1/hard-processor-system-technical-reference.html)

![timer_block_diagram](images/timer_block_diagram.png)

## **Driver Sources**

The source code for this driver can be found at [https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/counter/counter_dw_timer.c](https://github.com/zephyrproject-rtos/zephyr/blob/main/drivers/counter/counter_dw_timer.c).

## **Driver Capabilities**

* The timer can be configured to run as a one-shot timer(alarm).
* The timer can be configured to run as a periodic timer.
* Run timer in free running mode.
* Stop Timer.


## **Kernel Configurations**
CONFIG_COUNTER_SNPS_DW

![timer_kconfig](images/timer_kconfig.png)

## **Device Tree**

Device tree location to configure the timer:[https://github.com/zephyrproject-rtos/zephyr/blob/main/dts/arm64/intel/intel_socfpga_agilex5.dtsi](https://github.com/zephyrproject-rtos/zephyr/blob/main/dts/arm64/intel/intel_socfpga_agilex5.dtsi)

![timer_device_tree](images/timer_device_tree.png)

## **Known Issues**

None known
