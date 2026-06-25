### Setting Up your Development Board

* Configure the board switches:
  The following provides the default configuration for all the switches in the
  board.

![board-1](./common/images/board-1.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**Development Board switch position**
</center>
<br>

!!! note "Main configurations used in this example design"

    JTAG:     SOM SW4[2:1]=OFF:OFF <br>
    ASx4 (QSPI):  SOM SW4[2:1]=ON:ON

<br>

* Connect micro USB cable from bottom left of the carrier board to PC (`J35`).
  This will be used for JTAG communication (see figure below).
* Connect micro USB cable from bottom right of the SOM board to PC
  (`J2`, HSP_UART). This will be used for HPS UART communication. Look at what
  ports are enumerated on your host computer, there should be a series of
  four. Use the 3rd one in the list as the HPS serial port (see figure below).
* If ethernet capabilities or remote connection via `ssh` is required connect an
  ethernet cable to the ethernet port on the SOM board (`J6`, ETH 1G HPS) and make
  sure your device is in the same network as your intended host device. After
  Linux boots, check the IP address of the `end2` ethernet interface using the
  `ip addr` command.

![Agx-MDK-Conn](./common/images/Agx5-MDK-Conn.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**USB connections to the board**
</center>
<br>
