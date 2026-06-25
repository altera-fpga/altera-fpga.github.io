


* Configure the board switches:
  The following provides the default configuration for all the switches in the
  board.

![board-1](./common/images/board-1.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**Development Board switch position**
</center>
<br>

!!! note "Main configurations used in this example design"

    JTAG:     SOM SW1[1:0]=OFF:OFF <br>
    ASx4 (QSPI):  SOM SW1[1:0]=ON:ON

<br>

!!! warning "ESD"
    Handle ESD-sensitive equipment (boards, microSD cards, camera sensors, etc.) only when properly grounded at an ESD-safe workstation.

* Connect the Framos cable between the [Framos FSM:GO IMX678C Camera Modules] and the MIPI connector on the modular development kit SOM (`MIPI0`).
  Align pin 1 on the flex cable with pin 1 on the connector.
* Connect a DisplayPort or HDMI display to the development kit when validating the ISP and display pipeline (`J16`).
* Connect micro USB cable from bottom right of the SOM board to PC
  (`J2`, HPS_UART). This will be used for HPS UART communication and JTAG terminal
  for FPGA programming. Look at what ports are enumerated on your host computer.
  Use the new one in the list as the HPS serial
  port (see figure below).
* Connect an ethernet cable to the ethernet port on the SOM board (`J6`, ETH 1G HPS) and make
  sure your device is in the same network as your intended host device. After
  Linux boots, check the IP address of the `end2` ethernet interface using the
  `ip addr` command.

![Agx-MDK-Conn](./common/images/Agx5-MDK-Conn.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**USB connections to the board**
</center>
<br>