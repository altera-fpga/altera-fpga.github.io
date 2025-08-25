
* Download the `.jic` image from the prebuilt binary links above.
* Power down the board.
* Set **MSEL** dipswitch **S4** on SOM to **JTAG: OFF-OFF**
* Power up the board.
* Program the QSPI with the following command.

    ```bash
    quartus_pgm -c 1 -m jtag -o "pvi;top.hps.jic" 
    ```


* **(Optional)** Use the Quartus® Programmer GUI

  * Launch the Quartus® Programmer and Configure the **"Hardware Setup..."**
    settings as follows:
  <br>

  ![hw-setup-set](./common/images/hw-setup-set.png){:style="display:block; margin-left:auto; margin-right:auto"}

  <br>

  * Click "Auto Detect", select the device `A5EC065BB32AR0` and press
    **"Change File.."**
  <br>

  ![programmer-agx5](./common/images/programmer-agx5.png){:style="display:block; margin-left:auto; margin-right:auto"}

  <br>

  * Select the `.jic` file you downloaded earlier. The `MT25QU02G` device
    should now show. Select the **"Program/Configure"** box, and press **"Start"**.
    Wait until completed (It could take several minutes).
  <br>

  ![programmer-agx5-2](./common/images/programmer-agx5-2.png){:style="display:block; margin-left:auto; margin-right:auto"}

  <br>

* Power down the board. Set **MSEL** dip switch **S4** on SOM to **ASX4 (QSPI): ON-ON**
<br>
