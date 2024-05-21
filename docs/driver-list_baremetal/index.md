# **Bare Metal Drivers**

The table below provides a comprehensive list of the drivers available for X FPGA IP.
  
* The target link indicate the devices this driver supports.  
* The description link provides feature description, architectural details, known issues and release information.
* Upstreamed column indicates if driver is being mainstreamed in the Linux tree.

Location column indicates the link where the driver is located (userspace, linux.org, Quartus).

| Name    | Supported Device(s)    |  Documentation| Upstream Status  | Kernel Source|
| :-------:|-----------|-----------------|:----------:|---------------------- |
| 16550 UART  | Agilex 7 | [UART](../linux-dfl/uart_16550/uart_16550.md) | Yes | [Path](https://github.com/OFS/linux-dfl/blob/master/drivers/tty/serial/8250/8250_dfl.c) |
| Memory Interface/Subsystem | Stratix 10 <br> Agilex 7 | [Memory](../linux-dfl/emif_ip/emif_ip.md) | Yes | [Path](https://github.com/OFS/linux-dfl/tree/fpga-ofs-dev/drivers/memory) |
| Time of Day Clock Intel FPGA IP | Agilex 7 | [Host Attach TOD](../linux-dfl/ptp_dfl_tod/ptp_dfl_tod.md)  <br> [Embedded TOD](../linux-embedded/ptp_dfl_tod/ptp_dfl_tod.md) | Yes  | [Host-Attach Path](https://github.com/OFS/linux-dfl/blob/master/drivers/ptp/ptp_dfl_tod.c) <br> [Embedded Path](https://github.com/altera-opensource/linux-socfpga/blob/socfpga-6.1.55-lts/drivers/net/ethernet/altera/intel_fpga_tod.c) |
| USB 3.1  | Agilex 5 | [USB](../linux-embedded/uart_16550/usb3_1.md) | Yes | [Path](https://github.com/altera-opensource/linux-socfpga/tree/socfpga-6.1.55-lts/drivers/usb/dwc3) |