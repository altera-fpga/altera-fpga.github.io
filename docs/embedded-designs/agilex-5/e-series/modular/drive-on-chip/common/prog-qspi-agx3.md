
* Download the `.jic` image from the prebuilt binary links above.
* Power up the board.
* Program the QSPI with the following command.

    ```bash
    quartus_pgm -c 1 -m jtag -o "pvi;top.hps.jic" 
    ```

* **(Optional)** Use the Quartus® Programmer GUI

  * Launch the Quartus® Programmer and Configure the **"Hardware Setup..."**
    settings as follows:
  <br>

  ![hw-setup-set-agx3](./common/images/hw-setup-set-agx3.png){:style="display:block; margin-left:auto; margin-right:auto"}

  <br>

  * Click "Auto Detect", select the device `A3CW135BM16A` and press
    **"Change File.."**
  * Select the `.jic` file you downloaded earlier. The `MT25QU512` device
    should now show. Select the **"Program/Configure"** box, and press **"Start"**.
    Wait until completed (It could take several minutes).
  <br>

  ![programmer-agx3-2](./common/images/programmer-agx3-2.png){:style="display:block; margin-left:auto; margin-right:auto"}

  <br>

* Power cycle the board.
<br>
