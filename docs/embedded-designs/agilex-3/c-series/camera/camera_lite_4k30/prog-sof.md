### **Programming the Development Kit**

* To program the FPGA using a SOF File:

  * Power up the board.

  * Launch the Quartus® Programmer and Configure the **"Hardware Setup..."**
    settings as follows:

<br>

![hw-setup-set](../camera_lite_4k30/images/hw-setup-set.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center markdown="1">

**Programmer GUI Hardware Settings**
</center>

<br>

* Click "Auto Detect", select the device `A3CW135BM16A` (for the Devkit with SoC) or `A3CY135BM16A` (for the Devkit without SoC), and press
  **"Change File.."**

<br>

![programmer-agx3](../camera_lite_4k30/images/programmer-agx3.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center markdown="1">

**Programmer after "Auto Detect"**
</center>

<br>

* Select your `SOF` file, e.g. `golden_agx3c_soc_devkit_isp_lite_top.sof`. Check the
**"Program/Configure"** box and press the **"Start"** button (see below). Wait
until the programming has been completed.

<br>

![programmer-agx3-3](../camera_lite_4k30/images/programmer-agx3-3.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center markdown="1">

**Programming the FPGA with a SOF file**
</center>


