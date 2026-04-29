### **Demonstrations**

* After the FPGA has been programmed, you could proceed to open a JTAG-UART terminal, using the following command:
  * Linux:
    ```bash
    juart-terminal --device 1 --instance 0
    ```

  * Windows:
    ```bash
    juart-terminal.exe --device 1 --instance 0
    ```

* If successful, you should see the following message on the terminal:

![board-mipi](../camera_lite_4k30/images/menu_demo_init.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<br>

* After pressing `h`, you should see the menu for this demo:

![board-mipi](../camera_lite_4k30/images/menu_demo_h.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<br>

* The menu provides a list of different debug and configuration options in this example design.
  Each option has been mapped to a specific alphanumeric character, and you can control them from a JTAG-UART terminal interface via keyboard input.
  A brief description of all the options is provided below:

* Pressing `s`, will toggle between MIPI Rx and Input TPG.
  The Input TPG has been pre-configured to support four patterns:
  * Color Bars
  * Solid Colors: Blue, Green, and Red

![board-mipi](../camera_lite_4k30/images/menu_demo_s.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<br>

* Pressing `r`, will restore the ISP video pipeline to its default configuration.

![board-mipi](../camera_lite_4k30/images/menu_demo_r.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<br>

* Pressing `t`, will toggle the Icon `on` and `off`.

![board-mipi](../camera_lite_4k30/images/menu_demo_t.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<br>

* Pressing `1` will enable the BLC, while Pressing `2` will put the BLC in bypass mode.

![board-mipi](../camera_lite_4k30/images/menu_demo_1_2.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<br>

* Pressing `3` will enable the WBC, while Pressing `4` will put the WBC in bypass mode.
  * WBC enabled allows incremental changes from 3000K to 9000K on 1000K steps

![board-mipi](../camera_lite_4k30/images/menu_demo_3_4.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<br>

* Pressing `5` will enable the Demosaic, while Pressing `6` will put the Demosaic in bypass mode.

![board-mipi](../camera_lite_4k30/images/menu_demo_5_6.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<br>

* Pressing `7` will enable the CCM, while Pressing `8` will put the CCM in bypass mode.
  * CCM enabled allows incremental changes from 3000K to 9000K on 1000K steps

![board-mipi](../camera_lite_4k30/images/menu_demo_7_8.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<br>

* Pressing `9` will enable the 1D-LUT, while Pressing `0` will put the 1D-LUT in bypass mode.
  * 1D-LUT enabled produces a BT-709 gamma curve

![board-mipi](../camera_lite_4k30/images/menu_demo_9_0.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<br>

* Pressing `m` will increase the exposure gain of the sensor, while Pressing `n` will decrease the exposure gain of the sensor.
  * For incremental changes, the SW App first increases the digital gain, and once the value reaches its maximum limit,
    it then increases the analog gain.
  * For decremental changes, the SW App first decreases the analog gain, and once the value reaches zero,
    it then decreases the digital gain.

![board-mipi](../camera_lite_4k30/images/menu_demo_m_n.png){:style="display:block; margin-left:auto; margin-right:auto;"}









