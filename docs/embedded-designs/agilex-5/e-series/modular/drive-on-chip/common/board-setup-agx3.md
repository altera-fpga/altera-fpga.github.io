
* Configure the board switches:
  The following provides the default configuration for all the switches in the
  board.

![board-2](./common/images/board-2.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**Development Board switch position**
</center>
<br>

<br>

* Connect USB-C cable from top-right connector of the board to PC (`J2`).
  This will be used for JTAG communication (see figure below).
* Connect micro USB cable from top left of the board to PC
  (`U1`, UART). This will be used for HPS UART communication. Look at what
  ports are enumerated on your host computer, there should be a new one as 
  soon as the board is connected to the PC.
* If ethernet capabilities or remote connection via `ssh` is required connect an
  ethernet cable to the ethernet port on the board (`J10`, ETH 1G HPS) and make
  sure your device is in the same network as your intended host device. After
  Linux boots, check the IP address of the `end2` ethernet interface using the
  `ip addr` command.

![Agx3-MDK-Conn](./common/images/Agx3-MDK-Conn.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**USB connections to the board**
</center>
<br>
