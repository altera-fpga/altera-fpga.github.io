## QSPI Reference Clock
The QSPI peripheral clocks are provided by the SDM, based on the SDM input clocks and configuration clock settings defined in the Quartus® Pro project. However, the HPS needs to know the QSPI reference clock, so that it can properly set the dividers in the QSPI controller to create the desired external QSPI clock frequency.

The HPS obtains the QSPI controller reference clock frequency when it obtains exclusive access to the QSPI from the SDM. The frequency reported by the SDM is stored in the U-Boot environment variable called **${qspi_clock}**.

Before booting Linux, U-Boot loads the Linux device tree in memory, then runs the command **linux_qspi_enable** which sets the QSPI controller reference clock appropriately using the value from the **${qspi_clock}** environment variable.
