## Enabling Bridges from U-Boot

U-Boot offers the **bridge** command for controlling the bridges.

The **bridge** command can be used with either **'enable'** or **'disable'** parameter, followed by an optional **'mask'** parameter indicating which of the bridges needs to be enabled or disabled. When the **'mask'** parameter is omitted, all bridges are either enabled or disabled.

See bellow the help message for the command:
  ```
  # bridge
  bridge - SoCFPGA HPS FPGA bridge control

  Usage:
  bridge enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges 
  bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges
  Bit 3, Bit 4 and Bit 5 bridges only available in Stratix 10
  ```
The** 'mask'** is a hexadecimal number, with 3 bits available for Agilex™ 7, and 6 bits for Stratix® 10, as indicated above.

The following table shows examples of enabling and disabling various bridges:

| Command | Description |
| :-- | :-- | 
| bridge enable | Enable all bridges |
| bridge disable | Disable all bridges |
| bridge enable 1 | Enable HPS-to-FPGA bridge |
| bridge enable 2  | Enable LWHPS-to-FPGA bridge |
| bridge enable 4 | Enable FPGA-to-HPS bridge |
| bridge enable 7 | Enable HPS-to-FPGA, LWHPS-to-FPGA, FPGA-to-HPS bridges | 
| bridge enable 35 | Enable HPS-to-FPGA, FPGA-to-HPS, F2SDRAM1, F2SDRAM2 bridges(Stratix® 10 only)  |
| bridge disable 30 | Disable F2SDRAM1, F2SDRAM2 bridges (Stratix® 10 only) |
