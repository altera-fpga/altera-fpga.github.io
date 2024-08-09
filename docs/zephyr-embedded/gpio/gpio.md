# **General Purpose I/O Driver for Hard Processor System**

Last updated: **August 09, 2024** 

**Upstream Status**: Not Upstreamed

**Devices supported**: Agilex 5

## **Introduction**

General Purpose Input/Output (GPIO) Controller provides the low-level configuration through software or hardware to control the actual general purpose IO cells/pads present in the HPS. 
The below diagram represents block diagram of the GPIO controller connected with other components in the system.

![gpio_diagram](images/gpio_diagram.png)

Two GPIO module instances present in HPS and each having support of 24 GPIO ports. Only Port A of GPIO Controller is configured.
All the design contained of this document is referred from “Synopsys GPIO Databook”.

**Functional Modes:**

* Software Control Mode: In the software control mode, the port direction is set by writing to the corresponding port control register of a GPIO pin. These port control registers are memory mapped.
* Hardware Control Mode : If a signal is configured for hardware control, an external auxiliary hardware-signal controls the direction of the port. For the SM, Auxiliary H/W support is not enabled.

For More information please refer to the following link:
[Agilex 5 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/814346)

## **Features**

* Digital debounce
* Configurable interrupt mode
* Up to 48 dedicated I/O pins

## **Driver Sources**

The source code for this driver can be found at [https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/gpio/gpio_intel_socfpga.c](https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/gpio/gpio_intel_socfpga.c).

## **Driver Capabilities**

* GPIO Pin configure as input or output.
* GPIO Port/Pin set value using mask.
* GPIO Port/Pin get value using mask.
* GPIO Port/Pin toggle using mask.


## **Kernel Configurations**

No additional Kernel configurations needed to enable GPIO driver functionality.

## **Device Tree**

Example Device tree location:

[https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/dts/arm64/intel/intel_socfpga_agilex5.dtsi](https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/dts/arm64/intel/intel_socfpga_agilex5.dtsi)

![gpio_device_tree](images/gpio_device_tree.png)

## **Known Issues**

None known

## **Other Consideration**

Pinmux configuration should be in GPIO mode to use respective IO functionality.
