# **UART Driver for Hard Processor System**

Last updated: **March 26, 2025** 

**Upstream Status**: [Upstreamed](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/8250/8250_dw.c)

**Devices supported**: Agilex 7, Agilex 5

## **Introduction**

The Hard Processor System (HPS) provides two UART controllers for asynchronous serial communication.

For More information please refer to the following link:

[Agilex 5 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/814346)

![uart_diagram](images/uart_diagram.png){: style="height:450px;width:450px"}

## **Driver Sources**

The source code for this driver can be found at [https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/8250/8250_dw.c](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/8250/8250_dw.c).

## **Driver Capabilities**

* Probing and resource allocation as well as memory mapping.
* It provides the support for busy detect interrupt.

## **Kernel Configurations**

CONFIG_SERIAL_8250_DW

![uart_config_path](images/uart_config_path.png)

## **Device Tree**

Example Device tree location to configure the uart:

[https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi)

![uart_device_tree](images/uart_device_tree.png)

## **Known Issues**

None Known

