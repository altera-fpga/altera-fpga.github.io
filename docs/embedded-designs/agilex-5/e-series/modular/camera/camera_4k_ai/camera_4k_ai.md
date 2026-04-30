





# 4Kp30 Multi-Sensor Camera with AI Inference Solution System Example Design for Agilex™ 5 Devices

The design is compatible with
[Altera® Quartus® Prime Pro Edition version 25.1 Linux](https://www.intel.com/content/www/us/en/software-kit/851652/intel-quartus-prime-pro-edition-design-software-version-25-1-for-linux.html).

## Overview

The 4Kp30 Multi-Sensor Camera with AI Inference Solution System Example Design for Agilex™ 5 Devices demonstrates a practical glass-to-glass smart
camera solution. The exclusive support for industry-standard MIPI (Mobile Industry 
Processor Interface) D-PHY and MIPI CSI-2 interface on Agilex™ 5 FPGAs, along with
Altera®'s FPGA AI Suite, provides a powerful tool for smart camera product development.

|<center markdown="1">An example of AI Detect</center>|<center markdown="1">An example of AI Pose</center>|
|-|-|
|![Detect example](../camera_4k_ai/images/AI/detect_hd.png){:style="display:block; margin-left:auto; margin-right:auto; width: 100%"} | ![POSE example](../camera_4k_ai/images/AI/pose_hd.png){:style="display:block; margin-left:auto; margin-right:auto; width: 100%"}|

The MIPI interface supports up to 2.5Gbps per lane and up to 8x lanes per MIPI
interface, enabling seamless data reception from multiple 4K image sensors to
the FPGA fabric for further processing. Each MIPI CSI-2 IP instance converts
pixel data to AXI4-Streaming outputs, enabling connectivity to other IP cores
within Altera®'s Video and Vision Processing (VVP) Suite.

Altera®'s FPGA AI Suite is flexible and configurable for a variety of smart
camera use cases. In the 4Kp30 Multi-Sensor Camera with AI Inference Solution
System Example Design, the FPGA AI Suite IP is optimized to run the Ultralytics
YOLOv8 nano detection and pose inference models.

The design is a hardware-software co-design. The hardware component comprises
an Image Signal Processor (ISP), various VVP IPs, Altera®'s FPGA AI Suite IP
(AI IP), Hard Processor Subsystem (HPS) and various connectivity IPs. The
software stack is Linux based and runs on the HPS. The software runs compiled
YOLOv8 nano models from the microSD card. The End User must license and
download the models directly from Ultralytics.

The hardware includes a multi-sensor input video switch feeding into an Image
Signal Processing (ISP) subsystem. The ISP is a video processing pipeline
incorporating many VVP IP cores such that the raw sensor image data can be
processed into RGB video data. The backend of the ISP pipeline feeds the AI
pipeline which consists of many VVP IP cores to buffer, format, and scale the
video suitable for AI processing. The backend of the AI pipeline drives the
resulting 4Kp30 streaming video output data (complete with AI inference
overlay) through an Altera® DisplayPort IP.

The software stack consists of an application software binary running on the Linux
operating system with various layers of drivers. The backend part of the
application software interrogates the hardware, dynamically discovers the IP components
and configures them. The AI inference part of the application 
software schedules inference requests to Altera®'s FPGA AI Suite IP, and 
processes the inference results. The results are rendered as graphics in a
frame buffer, which the hardware overlays on the video stream.
Multiple feedback loops, in the application software, monitor the hardware
and keep various hardware components in lockstep. Some of the notable feedback
loops are Automatic White Balance (AWB), Auto Exposure (AE), and Adaptive Noise
Reduction (ANR) algorithms, reading their relevant statistics and adjusting
various coefficients and Look Up Tables (LUTs) in real time. The frontend of
the software creates a web-based Graphical User Interface (GUI) and runs it
over a web server.

The following diagram provides an overview of the interaction of the software
running in the Hard Processor Subsystem (HPS) and hardware components running in
the Programmable Logic parts of the device. (For more information on ARM HPS in 
Altera® Agilex™ Devices refer to the
[Other Documentation and References](#other-documentation-and-references) section.)

<br/>

![VVP_ISP_AI_ED_Top_level](../camera_4k_resources/images/VVP_ISP_AI_ED_Top_level.png){:style="display:block; margin-left:auto; margin-right:auto; width: 80%"}
<center markdown="1">

**High-Level Block Diagram of the Camera with AI Inference Solution System Example Design**
</center>
<br/>

## Pre-requisites

### **Hardware Requirements**

* [Agilex™ 5 FPGA E-Series 065B Modular Development Kit].

<br/>
![Agx5-MDK](../common/images/Agx5-MDK.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center markdown="1">

**Agilex™ 5 FPGA E-Series 065B Modular Development Kit**
</center>
<br/>

* 1 or 2 [Framos FSM:GO IMX678C Camera Modules], with:
  * [Wide 110deg HFOV Lens], or
  * [Medium 100deg HFOV Lens], or
  * [Narrow 54deg HFOV Lens].
* (Optional) Mount/Tripod
  * [Framos Tripod Mount Adapter].
  * [Tripod].
* A Framos cable for PixelMate MIPI-CSI-2 for each Camera Module:
  * [150mm flex-cable], or
  * [300mm micro-coax cable].
* (Optional) [Framos GMSL3 5m] (if the Camera Solution System Example Design
  supports this feature).
* MicroSD card (minimum 8Gb).
* DP cable or HDMI cable with [DP to HDMI Adapter] (recommend 4Kp60 capable).
* USB Micro B cable x2 (for QSPI programming and HPS serial console access).
* Ethernet cable (for HPS network connection).
* PC monitor or TV: 4Kp30 capable required.

<br/>


### **Software Requirements to run**

* Host PC with:
  * 8 GB of RAM (less if not rebuilding binaries).
  * Linux/Windows OS installed.
  * Serial terminal (such as GtkTerm or Minicom on Linux, and [TeraTerm] or
    [PuTTY] on Windows).
    * FTDI FT232R USB UART drivers (for a Windows host).
  * Tool to write images for removable USB drives or microSD cards such as
  [Win32DiskImager] on Windows or "dd" command on Linux.
  * [Altera® Quartus® Prime Pro Edition version 25.1 Programmer and Tools].
  * Ethernet connection (either direct from Host PC to development board, or
    via a switch or router).
    * Note, you may need to disconnected/disabled VPN if it is installed on the
      Host PC.
  * Web browser.

<br/>


### **Download and Compile the AI Models**

The Altera® FPGA AI Suite IP in the Camera with AI Inference Solution System
Example Design, is optimized to run both the ultralytics YOLOv8 nano detection
and pose inference models, switching between them at runtime. The End User must
go to ultralytics website to review and accept licensing and copyright
information, before downloading the YOLOv8 nano models. The models must then be
compiled for the FPGA AI Suite IP. This will only need to be done once:

* Visit the [ultralytics YOLO] website.
* Review and accept the licensing and copyright terms.
* Download the YOLOv8 nano detection inference model `yolov8n.pt`
* Download the YOLOv8 nano pose inference model `yolov8n-pose.pt`
* Download the [model_compiler] to your `<workspace>` directory
* Compile the models for FPGA AI Suite IP:

!!! NOTE "Note"
    The downloaded YOLOv8 nano models must be placed in the directory specified

  ```bash
  mkdir -p <workspace>
  cd <workspace>
  git clone [https://github.com/altera-fpga/agilex-ed-camera-ai] .
  cd yolo_cnn
  ```

  ```bash
  echo "Download the YOLOv8 nano inference models from ultralytics website into directory yolo_cnn"
  wget <url>
  ```

  ```bash
  mkdir -p compile
  cd compile
  echo "This step can take some time to extract Altera® FPGA AI Suite"
  cmake -G Ninja ..
  echo "This step can take some time to generate a python virtual environment"
  ninja
  cd output
  tree
  ```

  ```bash
  .
  ├── generated_arch.arch
  │   ├── yolov8n-pose_dla_m2m_compiled_640_384.bin
  │   └── yolov8n_dla_m2m_compiled_640_384.bin
  ├── yolov8n-pose_categories.txt
  └── yolov8n_categories.txt

  1 directory, 4 files
  ```

The model_compiler generates the following YOLOv8 nano inference model binaries:

* Detection `generated_arch.arch/yolov8n_dla_m2m_compiled_640_384.bin`
* Pose `generated_arch.arch/yolov8n-pose_dla_m2m_compiled_640_384.bin`

Additionally, the model_compiler generates the following category identifier files:
* Detection `yolov8n_categories.txt`
* Pose `yolov8n-pose_categories.txt`


<br/>



## Getting Started - run with pre-built binaries

Follow the instructions provided in this section to run the Camera Solution System Example Design on the Agilex™ 5 FPGA E-Series 065B Modular Development
Kit.

### **Download the pre-built Binaries**

* Download the pre-built Camera Solution System Example Design binaries for the
  Modular Development Kit:

<br/>
<center markdown="1">

**Binaries**

| Source | Link | Description |
| ---- | ---- | ---- |
| QSPI | [top.core.jic] | Allows the Camera Solution System Example Design to be booted from the microSD card |
| microSD Card Image | [hps-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz] | The Camera Solution System Example Design |

<br/>

</center>


## Programming

### **Setting Up the Development Kit**

!!! NOTE "Warning"
    Handle ESD-sensitive equipment (boards, microSD cards, camera sensors, etc.) only when properly grounded and at an ESD-safe workstation

* Configure the Agilex™ 5 FPGA E-Series 065B Modular Development Kit switches
  as shown:

<br>

![board-1](../common/images/board-1.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center markdown="1">

**Modular Development Kit - Default Switch Positions**
</center>
<br>

!!! note "FPGA configuration modes used by the Camera Solution System Example Design"

    The Camera Solution System Example Design can use one of the following FPGA configuration modes: JTAG or ASx4(QSPI).<br>
    The MSEL switch (S4) on the SOM board instructs the FPGA device on which configuration mode to use.

    JTAG mode:         Modular Development Kit SOM Board S4=OFF:OFF, or<br>
    ASx4 (QSPI) mode:  Modular Development Kit SOM Board S4=ON:ON

    The pre-built version of the design uses ASx4 (QSPI) mode, S4=ON:ON.

<br>

* Make the required connections between the Host PC and the Modular Development
  Kit as shown in the following diagram:

<br/>

![ed-conn](../camera_4k_resources/images/ed-conn.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**Host PC and Modular Development Kit Connections diagram**
</center>
<br/>

* Connect micro USB cable between the Modular Development Kit Carrier Board
  (`J35`) and the Host PC. This will be used for QSPI programming / FGPA
  configuration over JTAG.
  Look at what serial ports are enumerated on your Host computer. There should be a
  series of four.
* Connect micro USB cable between the Modular Development Kit SOM Board (`J2`,
  HSP_UART) and the Host PC. This will be used to access HPS serial console. Look
  at what ports are enumerated on your Host computer. There should be a series
  of four. Use the 3rd one in the list as the HPS serial port.
* Connect an RJ45 cable between the ethernet port on the Modular Development
  Kit SOM Board (`J6`, ETH 1G HPS) and make sure it is on the same network as
  your Host PC. You can check the `eth0` IP address after boot using the Linux
  `ip a` command.

<br>

![Agx-MDK-Conn](../common/images/Agx5-MDK-Conn.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center markdown="1">

**Modular Development Kit Connector Locations**
</center>
<br>


### **Burn the microSD Card Image**

* Either use your own or download the pre-built `<name>.wic.gz` image.
* If required, extract `<name>.wic` image from the compressed download file.
  * On Linux, use the `dd` utility:

  ```bash
  tar -xzf `<name>.wic.gz`
  ```

  * On Windows, use the [7-Zip](https://www.7-zip.org) program (or similar):
    * Right click `<name>.wic.gz` file, and select "Extract All..."

* Write the `<name>.wic` image to the microSD card using a USB writer:
  * On Linux, use the `dd` utility:

  ```bash
  # Determine the device associated with the SD card on the host computer.
  cat /proc/partitions
  # This will return for example /dev/sd<x>
  # Use dd to write the image in the corresponding device
  sudo dd if=<name>.wic of=/dev/sd<x> bs=1M
  # Flush the changes to the microSD card
  sync
  ```

  * On Windows, use the [Win32DiskImager](https://sourceforge.net/projects/win32diskimager) program (or similar):
    * Click browse icon and select "\*.\*" filter:

    ![disk-imager-browse](../common/images/disk-imager-browse.png){:style="display:block; margin-left:auto; margin-right:auto"}
    <center markdown="1">

    **Navigate to your download and select `<name>.wic` in the "Disk Imager" tool**
    </center>
<br>

    * Write the image (note your Device may be different to that shown):

    ![disk-imager](../common/images/disk-imager.png){:style="display:block; margin-left:auto; margin-right:auto"}
    <center markdown="1">

    **Write the microSD Card using the "Disk Imager" tool**
    </center>

* Turn off the Modular Development Kit and insert the microSD card in the
  microSD card slot located on the Modular Development Kit SOM Board.

<br>



[Agilex™ 5 E-Series Modular Development Board GSRD User Guide (25.1)]: https://altera-fpga.github.io/rel-25.1/embedded-designs/agilex-5/e-series/modular/gsrd/ug-gsrd-agx5e-modular/



[Hard Processor System Technical Reference Manual: Agilex™ 5 SoCs (25.1)]: https://www.intel.com/content/www/us/en/docs/programmable/814346/25-1/hard-processor-system-technical-reference.html
[NiosV Processor for Altera® FPGA]: https://www.altera.com/design/guidance/nios-v-developer
[Agilex™ 5 FPGA E-Series 065B Modular Development Kit]: https://www.altera.com/products/devkit/a1jui0000061qabmaa/agilex-5-fpga-and-soc-e-series-modular-development-kit-es
[Agilex™ 5 FPGA E-Series 065B Modular Development Kit Product Brief]: https://www.intel.com/content/www/us/en/content-details/815178/agilex-5-fpga-e-series-065b-modular-development-kit-product-brief.html
[Altera® FPGA AI Suite]: https://www.altera.com/products/development-tools/fpga-ai-suite


[Win32DiskImager]: https://sourceforge.net/projects/win32diskimager
[7-Zip]: https://www.7-zip.org
[TeraTerm]: https://github.com/TeraTermProject/teraterm/releases
[PuTTY]: https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html


[Framos FSM:GO IMX678C Camera Modules]: https://www.framos.com/en/fsmgo
[Wide 110deg HFOV Lens]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FSMGO-IMX678C-M12-L110A-PM-A1Q1?qs=%252BHhoWzUJg4KQkNyKsCEDHw%3D%3D
[Medium 100deg HFOV Lens]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FSMGO-IMX678C-M12-L100A-PM-A1Q1?qs=%252BHhoWzUJg4IesSwD2ACIBQ%3D%3D
[Narrow 54deg HFOV Lens]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FSMGO-IMX678C-M12-L54A-PM-A1Q1?qs=%252BHhoWzUJg4L5yHZulKgVGA%3D%3D
[Framos Tripod Mount Adapter]: https://www.framos.com/en/products/fma-mnt-trp1-4-v1c-26333
[Tripod]: https://thepihut.com/products/small-tripod-for-raspberry-pi-hq-camera
[150mm flex-cable]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FMA-FC-150-60-V1A?qs=GedFDFLaBXGCmWApKt5QIQ%3D%3D&_gl=1*d93qim*_ga*MTkyOTE4MjMxNy4xNzQxMTcwMzQy*_ga_15W4STQT4T*MTc0MTE3MDM0Mi4xLjEuMTc0MTE3MDQ5OS40NS4wLjA
[300mm micro-coax cable]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FFA-MC50-Kit-0.3m?qs=%252BHhoWzUJg4K3LtaE207mhw%3D%3D
[DP to HDMI Adapter]: https://www.amazon.co.uk/gp/product/B01M6WK3KU/ref=ppx_yo_dt_b_asin_title_o02_s00?ie=UTF8&psc=1
[Framos GMSL3 5m]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FFA-GMSL3-Kit-5m?qs=%252BHhoWzUJg4IkLHv%2F6fzsXQ%3D%3D
[Framos FFA-GMSL-SER-V2A Serializer]: https://www.framos.com/en/products/ffa-gmsl-ser-v2a-27617
[Framos FFA-GMSL-DES-V2A Deserializer]: https://www.framos.com/en/products/ffa-gmsl-des-v2a-27240


[VVP IP Suite]: https://www.altera.com/products/ip/a1jui000004qxfpmak/video-and-vision-processing-suite
[MIPI DPHY IP and MIPI CSI-2 IP]: https://www.altera.com/products/ip/a1jui0000049uuamam/mipi-d-phy-ip#tab-blade-1-3
[Nios® V Processor]: https://www.altera.com/products/ip/a1jui0000049uvama2/nios-v-processors


[Altera® Quartus® Prime Pro Edition version 25.1 Linux]: https://www.intel.com/content/www/us/en/software-kit/851652/intel-quartus-prime-pro-edition-design-software-version-25-1-for-linux.html
[Altera® Quartus® Prime Pro Edition version 25.1 Windows]: https://www.intel.com/content/www/us/en/software-kit/851653/intel-quartus-prime-pro-edition-design-software-version-25-1-for-windows.html
[Altera® Quartus® Prime Pro Edition version 25.1 Programmer and Tools]: https://www.intel.com/content/www/us/en/software-kit/851652/intel-quartus-prime-pro-edition-design-software-version-25-1-for-linux.html


[ultralytics YOLO]: https://docs.ultralytics.com
[ONNX]: https://onnx.ai/
[OpenVINO Toolkit]: https://storage.openvinotoolkit.org/repositories/openvino/packages/2024.6/linux



### **Copying the Compiled AI Models to the microSD Card**

The compiled models must be copied onto the microSD card for the Application
Software to use at runtime:

* `scp` and `ssh` the compiled models directly to the Development Kit (using its
  `<ip address>`):
  * Power up the Modular Development Kit (if not already powered) and set up the
    serial terminal emulator (minicom, [TeraTerm], [PuTTY], etc.):
    * Select the correct `COMx` port. (The Modular Development Kit presents 4
      serial COM ports over a single connection and the Linux system uses the 3rd
      port in order). Set the port configuration as follows:
      * 115200 baud rate, 8 Data bits, 1 Stop bit, CRC and Hardware flow control
        disabled.
    * The Linux OS will boot.
    * Take note of the Modular Development Kit IP address.
      * The IP address can also be found using the terminal by logging in as `root`
      (no password required) and querying the Ethernet controller:

      ```bash
      root
      ifconfig
      ```

      * `eth0` provides the IPv4 or IPv6 address to connect to.
 
  * Using a Linux terminal (or Windows equivalent like PowerShell) on your Host,
    copy the files from the output directory to the Development Kit:

    ```bash
    cd compile/output
    scp -r * root@<ip address>:
    ```
  * Ensure sdcard has stored the files
    ```bash
    ssh root@<ip address>
    sync
    ls *_categories.txt *.arch
    ```
    Outputs:
    ```bash
    yolov8n-pose_categories.txt yolov8n_categories.txt

    generated_arch.arch:
    yolov8n-pose_dla_m2m_compiled_640_384.bin yolov8n_dla_m2m_compiled_640_384.bin
    ```
  * The Development Kit can be powered down, and restarted to load the models.


<br/>



### **Program the QSPI Flash Memory**

This should only need to be done once. To program the QSPI flash memory:

* Ensure the Modular Development Kit is powered off. Set MSEL=JTAG by setting
  the **S4** dip switch on the Modular Development SOM Board to **OFF-OFF**.
  * This prevents any bootloader from starting and leaves the JTAG chain in a
    default state.

* Power up the Modular Development Kit.

* Either use your own or download the pre-built `JIC` image, and write it to
  the QSPI Flash memory using either the command:

    ```bash
    quartus_pgm -c 1 -m jtag -o "pvi;top.core.jic" 
    ```

* or, optionally using the Quartus® Programmer GUI:

  * Launch the Quartus® Programmer and Configure the **"Hardware Setup..."**
settings as following:
  <br>

![hw-setup-set](../common/images/hw-setup-set.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center markdown="1">

**Programmer - GUI Hardware Settings**
</center>
<br>

* Click "Auto Detect", select the device `A5EC065BB32AR0`, and press **"Change File.."**
<br>

![programmer-agx5](../common/images/programmer-agx5.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center markdown="1">

**Programmer - After "Auto Detect"**
</center>
<br>

Select your `top.core.jic` file. The `MT25QU02G` device should be shown (see
below). Check the **"Program/Configure"** box and press the **"Start"** button.
Wait until the programming has been completed (which can take several minutes).
<br>

![programmer-agx5-2](../common/images/programmer-agx5-2.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center markdown="1">

**Programming the QSPI Flash with the JIC file**
</center>
<br>

* Power down the Modular Development Kit. Set MSEL=ASX4 (QSPI) by setting the
  **S4** dip switch on the Modular Development SOM Board to **ON-ON**.
  * This starts the HPS bootloader and FPGA configuration from the microSD Card
    after power up.
<br>


## Running

### **Setting Up the Camera Solution**

!!! NOTE "Warning"
    Handle ESD-sensitive equipment (boards, microSD Cards, Camera sensors, etc.) only when properly grounded and at an ESD-safe workstation

* Make the required connections between the Host PC and the
[Agilex™ 5 FPGA E-Series 065B Modular Development Kit] as detailed in the
  **Setting Up the Modular Development Kit** section.
* Connect the Framos cable(s) between the Framos Camera Module(s) and the MIPI
  connector(s) on the Modular Development Kit Carrier Board taking care to
  align the cable(s) correctly with the connector(s) (pin 1 to pin 1). When
  using a single camera module, either MIPI connector can be used.

<br/>

![board-mipi](../common/images/Agx5-MDK-MIPI.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**Modular Development Kit Carrier Board MIPI Connector Locations**
</center>
<br/>

![mipi-ribbon](../common/images/mipi-ribbon-connection.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**Modular Development Kit Carrier Board with MIPI Framos Flex Cable Connected**
</center>
<br/>

![camera-ribbon](../common/images/camera-ribbon-connection.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**Framos Camera with Flex Cable Connected**
</center>
<br/>

* If using the optional Framos GMSL3 solution (and the Camera Solution System
  Example Design supports it):
  * Connect the [Framos FFA-GMSL-SER-V2A Serializer] module back-to-back to the
    Framos Camera module.
  * Using the Framos [150mm flex-cable] connect the
    [Framos FFA-GMSL-DES-V2A Deserializer] module to the MIPI0 connector on the
    Modular Development Kit Carrier Board taking care to align the cable
    correctly with the connector (pin 1 to pin 1).
    * Note the System Example Design only supports one GMSL3 link on the MIPI0
      port. However, a second Framos Camera module can be connected directly to
      the MIPI1 port using a Framos [150mm flex-cable].
  * Connect the serializer module to the deserializer module using the GMSL3 5m
    coax cable. 
  * Connect the power supply to the deserializer module.
    * Note the GMSL3 deserializer module must be powered up before the Modular
      Development Kit.
  * Power up the Modular Development Kit and ensure the deserializer
    modules Lock LED is illuminated green.

<br/>

![GMSL](../common/images/GMSL.png){:style="display:block; margin-left:auto; margin-right:auto; width: 85%"}
<center markdown="1">

**GMSL Connections**
</center>
<br/>

* Connect the Modular Development Kit Carrier Board DisplayPort Tx connector to
  the Monitor using a suitable cable (and the adapter if you are using an HDMI cable).

<br/>

![full-system](../common/images/full-system.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**Modular Development Kit with Connections**
</center>
<br/>


### **Connecting with a Web Browser**

* Power up the Modular Development Kit (if not already powered) and set up the
  serial terminal emulator (minicom, [TeraTerm], [PuTTY], etc.):
  * Select the correct `COMx` port. (The Modular Development Kit presents 4
    serial COM ports over a single connection and the Linux system uses the 3rd
    port in order). Set the port configuration as follows:
    * 115200 baud rate, 8 Data bits, 1 Stop bit, CRC and Hardware flow control
      disabled.
* The Linux OS will boot and the Camera Solution System Example Design Software
  Application should run automatically.
* A few seconds after Linux boots, the Software Application will detect the
  attached Monitor and the ISP processed output will be displayed using the
  best supported format.
* Take note of the Modular Development Kit's IP address.
  * The IP address can also be found using the terminal by logging in as `root`
    (no password required) and querying the Ethernet controller:

    ```bash
    root
    ifconfig
    ```

  * `eth0` provides the IPv4 or IPv6 address to connect to.
<br/>

![ed-conn](../camera_4k_resources/images/Setup/ifconfig-dhcp.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**An Example ifconfig Output for a DHCP Network**
</center>

<br/>

![ed-conn](../camera_4k_resources/images/Setup/ifconfig-direct.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<center markdown="1">

**An Example ifconfig Output for a Network with no DHCP support or is using a direct connection**
</center>

<br/>

* Connect your web browser to the boards IP address so you can interact with
  the Camera Solution System Example Design using the GUI.
  * To connect using IPv6 in the example address shown above, you would use
    `http://[fe80::a8bb:ccff:fe55:6688]` (note the square brackets)
  * To connect using IPv4 for the DHCP example shown above, you would use
    `http://192.168.0.1`

<br/>

![ed-conn](../camera_4k_resources/images/Setup/Browser-IPv6.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**An Example Web Browser URL for an IPv6 Address**
</center>

<br/>

![ed-conn](../camera_4k_resources/images/Setup/Browser-IPv4.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**An Example Web Browser URL for an IPv4 address**
</center>

<br/>

* During connection, you will see the Altera® splash screen, after which you
  will be presented with the Web GUI.

<br/>

![ed-conn](../camera_4k_resources/images/Setup/UI-screen.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**An Example Camera Solution System Example Design GUI**
</center>

<br/>


## Recommended User Flows

### **Sources**

The sources listed in this table are the most current and highly recommended
for [Altera® Quartus® Prime Pro Edition version 25.1 Linux](https://www.intel.com/content/www/us/en/software-kit/851652/intel-quartus-prime-pro-edition-design-software-version-25-1-for-linux.html) builds. Users are
advised to utilize the updated versions of these building blocks in production
environments. Please note that this is a demonstration design and is not
suitable for production or final deployment.

<center markdown="1">

**Camera with AI Inference Solution System Example Design Source Repository**

|Component |Location |Branch |
|-|-|-|
|Assets Release Tag|[https://github.com/altera-fpga/agilex-ed-camera-ai/releases/tag/rel-25.1](https://github.com/altera-fpga/agilex-ed-camera-ai/releases/tag/rel-25.1)| rel-25.1|
|Repository|[https://github.com/altera-fpga/agilex-ed-camera-ai](https://github.com/altera-fpga/agilex-ed-camera-ai)|rel-25.1|

</center>

<br/>

With the available source, you can create and modify, build and compile, and
execute the Camera Solution System Example Design. There are 3 recommended
flows that you can explore:

* [User Flow 1]: [Getting Started - Running with pre-built binaries.](#getting-started-run-with-pre-built-binaries)
* [User Flow 2]: Use the [SOF Modular Design Toolkit (MDT) Flow](https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt) - typically
  used for Quartus® with OpenCore Plus IP Evaluation License for time limited
  and tethered camera solutions. Supports the full and free FPGA AI Suite
  license.
* [User Flow 3]: Use the [RBF Modular Design Toolkit (MDT) Flow](https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt) - typically
  used for Quartus® with full IP License for turnkey microSD card camera
  solutions. Supports the full and free FPGA AI Suite license.

!!! NOTE "Note"
    The free OpenCore Plus feature allows you to evaluate licensed IP cores in
    simulation and hardware before purchase. OpenCore Plus evaluation supports
    the following two operation modes: <br/>
    Untethered — run the design containing the licensed IP for a limited time. <br/>
    Tethered — run the design containing the licensed IP for a longer time or
    indefinitely. This operation requires a JTAG connection between your
    Development Kit and the Host computer. <br/>
    Note: All video IP cores that use OpenCore Plus time out simultaneously
    when any one video IP core in the design times out. <br/> <br/>
    The free FPGA AI Suite license operates independently to the OCP license
    and is typically limited to 100k inferences (around 56 minutes using a
    30FPS inference model). Note that the OCP licensed IP will continue to run
    even if the FPGA AI Suite license expires.

<br/>

<style>
r { color: Red; font-weight: bold;}
o { color: Orange; font-weight: bold;}
g { color: Green; font-weight: bold;}
y { color: #CCCC00; font-weight: bold;}
</style>

<center markdown="1">

### Flows 
**Recommended User Flows**

 |User Flow                        |Description                                                                                                                                                                         | [User Flow 1]                                                                                        | [User Flow 2]                                                                                                      | [User Flow 3]                                                                                                      |
 |---------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------:|
 |[Pre-requisites](#pre-requisites)| [Hardware Requirements.](#hardware-requirements)                                                                                                                                   |[<g>&check;</g>](../camera_4k_ai/camera_4k_ai.md#hardware-requirements)                             |[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#hardware-requirements)                             |[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#hardware-requirements)                             |
 |                                 | Software Requirements to build.                                                                                                                                                    |<r>&cross;</r>                                                                                        |[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#software-requirements-to-build)                    |[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#software-requirements-to-build)                    |
 |                                 | License Requirements to build.                                                                                                                                                     |<r>&cross;</r>                                                                                        |[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#license-requirements-to-build)                     |[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#license-requirements-to-build)                     |
 |                                 | [Software Requirements to run.](#software-requirements-to-run)                                                                                                                     |[<g>&check;</g>](../camera_4k_ai/camera_4k_ai.md#software-requirements-to-run)                      |[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#software-requirements-to-run)                      |[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#software-requirements-to-run)                      |
 |                                 | [Download and Compile the AI Models.](#download-and-compile-the-ai-models)                                                                                                         |[<g>&check;</g>](../camera_4k_ai/camera_4k_ai.md#download-and-compile-the-ai-models)                |[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#download-and-compile-the-ai-models)                |[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#download-and-compile-the-ai-models)                |
 |                                 | [Download the Pre-built Binaries.](#download-the-pre-built-binaries)                                                                                                               |[<g>&check;</g>](../camera_4k_ai/camera_4k_ai.md#download-the-pre-built-binaries)                   |<r>&cross;</r>                                                                                                      |<r>&cross;</r>                                                                                                      |
 |HW-Compilation                   | Creating and Building the Design based on the [SOF Modular Design Toolkit (MDT) Flow](https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt)                                                                                              |<r>&cross;</r>                                                                                        |[<g>&check;</g><span hidden="true"> SOF MDT Flow </span>](https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt)                                                           |<r>&cross;</r>                                                                                                      |
 |                                 | Creating and Building the Design based on the [RBF Modular Design Toolkit (MDT) Flow](https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt)                                                                                              |<r>&cross;</r>                                                                                        |<r>&cross;</r>                                                                                                      |[<g>&check;</g><span hidden="true"> RBF MDT Flow </span>](https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt)                                                           |
 |SW-Compilation                   | [Create microSD card image (.wic.gz) using YOCTO/KAS](https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/sw/README.md) <br/> <r>NOTE</r>: use <g>**KAS_MACHINE=agilex5_mk_a5e065bb32aes1**</g> and <g>**kas/agilex_camera_ff.yml**</g> configuration|<r>&cross;</r>                                                                                        |[<g>&check;</g><span hidden="true"> YOCTO/KAS </span>](https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/sw/README.md)                                                              |<r>&cross;</r>                                                                                                      |
 |                                 | [Create microSD card image (.wic.gz) using YOCTO/KAS](https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/sw/README.md) <br/> <r>NOTE</r>: use <g>**KAS_MACHINE=agilex5_mk_a5e065bb32aes1**</g> and <g>**kas/agilex_camera.yml**</g> configuration   |<r>&cross;</r>                                                                                        |<r>&cross;</r>                                                                                                      |[<g>&check;</g><span hidden="true"> YOCTO/KAS </span>](https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/sw/README.md)                                                              |
 |[Programming](#programming)      | [Setting Up the Development Kit.](#setting-up-the-development-kit)                                                                                                                 |[<g>&check;</g>](../camera_4k_ai/camera_4k_ai.md#setting-up-the-development-kit)                    |[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#setting-up-the-development-kit)                    |[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#setting-up-the-development-kit)                    |
 |                                 | [Burn the microSD card image.](#burn-the-microsd-card-image)                                                                                                                       |[<g>&check;</g>](../camera_4k_ai/camera_4k_ai.md#burn-the-microsd-card-image)                       |[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#burn-the-microsd-card-image)                       |[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#burn-the-microsd-card-image)                       |
 |                                 | [Copying the Compiled AI Models to the microSD Card.](#copying-the-compiled-ai-models-to-the-microsd-card)                                                                         |[<g>&check;</g>](../camera_4k_ai/camera_4k_ai.md#copying-the-compiled-ai-models-to-the-microsd-card)|[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#copying-the-compiled-ai-models-to-the-microsd-card)|[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#copying-the-compiled-ai-models-to-the-microsd-card)|
 |                                 | [Program the QSPI Flash Memory.](#program-the-qspi-flash-memory)                                                                                                                   |[<g>&check;</g>](../camera_4k_ai/camera_4k_ai.md#program-the-qspi-flash-memory)                     |<r>&cross;</r>                                                                                                      |[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#program-the-qspi-flash-memory)                     |
 |[Running](#running)              | [Setting Up the Camera Solution.](#setting-up-the-camera-solution)                                                                                                                 |[<g>&check;</g>](../camera_4k_ai/camera_4k_ai.md#setting-up-the-camera-solution)                    |[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#setting-up-the-camera-solution)                    |[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#setting-up-the-camera-solution)                    |
 |                                 | Program the FPGA SOF.                                                                                                                                                              |<r>&cross;</r>                                                                                        |[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#program-the-fpga-sof)                              |<r>&cross;</r>                                                                                                      |
 |                                 | [Connecting with a Web Browser.](#connecting-with-a-web-browser)                                                                                                                   |[<g>&check;</g>](../camera_4k_ai/camera_4k_ai.md#connecting-with-a-web-browser)                     |[<g>&check;</g>](../camera_4k_ai/flow2-sof-mdt.md#connecting-with-a-web-browser)                     |[<g>&check;</g>](../camera_4k_ai/flow3-rbf-mdt.md#connecting-with-a-web-browser)                     |

</center>
<br/>

## Resources

### **Documentation**
* [Features.](./features.md)
* [AI Software Design Functional Description.](./isp-ai-funct-descr.md)
* [ISP and AI IP Design Functional Description.](./isp-funct-descr.md)
* [Hardware Design Functional Description.](./hw-funct-descr.md)
* [Software Functional Description.](./sw-funct-descr.md)
* [Web GUI Functional Description.](./ui-funct-descr.md)
* [Design Security Considerations.](./design-security-considerations.md)
* [Acronyms and Terminology.](./glossary.md)

### **References**
* [Agilex™ 5 FPGA E-Series 065B Modular Development Kit Product Brief](https://www.intel.com/content/www/us/en/content-details/815178/agilex-5-fpga-e-series-065b-modular-development-kit-product-brief.html).
* [Framos FSM:GO IMX678C Camera Modules](https://www.framos.com/en/fsmgo).
* [Framos FFA-GMSL-SER-V2A Serializer](https://www.framos.com/en/products/ffa-gmsl-ser-v2a-27617).
* [Framos FFA-GMSL-DES-V2A Deserializer](https://www.framos.com/en/products/ffa-gmsl-des-v2a-27240).
* [Video and Vision Processing Suite Altera® FPGA IP User Guide](https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/about-the-video-and-vision-processing-suite.html).
* [VVP IP Suite](https://www.altera.com/products/ip/a1jui000004qxfpmak/video-and-vision-processing-suite).
* [Tone Mapping Operator](https://www.altera.com/products/ip/a1jui000004r0hlmak/tone-mapping-operator-fpga-ip).
* [3D LUT](https://www.altera.com/products/ip/a1jui000004r4gnmas/3d-lut-altera-fpga-ip).
* [MIPI DPHY IP and MIPI CSI-2 IP](https://www.altera.com/products/ip/a1jui0000049uuamam/mipi-d-phy-ip#tab-blade-1-3).
* [Nios® V Processor](https://www.altera.com/products/ip/a1jui0000049uvama2/nios-v-processors).
* [Altera® FPGA AI Suite](https://www.altera.com/products/development-tools/fpga-ai-suite).
* [ultralytics YOLO](https://docs.ultralytics.com).
* [ONNX](https://onnx.ai/).
* [OpenVINO Toolkit](https://storage.openvinotoolkit.org/repositories/openvino/packages/2024.6/linux).

### **Other Repositories Used**
|Component |Location |Branch |
|-|-|-|
|Modular Design Toolkit|[https://github.com/altera-fpga/modular-design-toolkit](https://github.com/altera-fpga/modular-design-toolkit)|rel-25.1|
|Linux|[https://github.com/altera-opensource/linux-socfpga](https://github.com/altera-opensource/linux-socfpga)|socfpga-6.6.22-lts|
|Arm Trusted Firmware|[https://github.com/ARM-software/arm-trusted-firmware](https://github.com/ARM-software/arm-trusted-firmware)|socfpga_v2.11.0|
|U-Boot|[https://github.com/altera-opensource/u-boot-socfpga](https://github.com/altera-opensource/u-boot-socfpga)|v2024.01|
|Yocto Project: poky|[https://git.yoctoproject.org/poky](https://git.yoctoproject.org/poky)|scarthgap|

### **Other Documentation and References**
* [Hard Processor System Technical Reference Manual: Agilex™ 5 SoCs (25.1)](https://www.intel.com/content/www/us/en/docs/programmable/814346/25-1/hard-processor-system-technical-reference.html).
* [NiosV Processor for Altera® FPGA](https://www.altera.com/design/guidance/nios-v-developer).
* [Agilex™ 5 FPGA E-Series 065B Modular Development Kit](https://www.altera.com/products/devkit/a1jui0000061qabmaa/agilex-5-fpga-and-soc-e-series-modular-development-kit-es).

<br/>

## Notices & Disclaimers

Altera<sup>&reg;</sup> Corporation technologies may require enabled hardware, software or service activation.
No product or component can be absolutely secure. 
Performance varies by use, configuration and other factors.
Your costs and results may vary. 
You may not use or facilitate the use of this document in connection with any infringement or other legal analysis concerning Altera or Intel products described herein. You agree to grant Altera Corporation a non-exclusive, royalty-free license to any patent claim thereafter drafted which includes subject matter disclosed herein.
No license (express or implied, by estoppel or otherwise) to any intellectual property rights is granted by this document, with the sole exception that you may publish an unmodified copy. You may create software implementations based on this document and in compliance with the foregoing that are intended to execute on the Altera or Intel product(s) referenced in this document. No rights are granted to create modifications or derivatives of this document.
The products described may contain design defects or errors known as errata which may cause the product to deviate from published specifications.  Current characterized errata are available on request.
Altera disclaims all express and implied warranties, including without limitation, the implied warranties of merchantability, fitness for a particular purpose, and non-infringement, as well as any warranty arising from course of performance, course of dealing, or usage in trade.
You are responsible for safety of the overall system, including compliance with applicable safety-related requirements or standards. 
<sup>&copy;</sup> Altera Corporation.  Altera, the Altera logo, and other Altera marks are trademarks of Altera Corporation.  Other names and brands may be claimed as the property of others. 

OpenCL* and the OpenCL* logo are trademarks of Apple Inc. used by permission of the Khronos Group™. 



[User flow 1]: ../camera_4k_ai/camera_4k_ai.md#pre-requisites
[User flow 2]: ../camera_4k_ai/flow2-sof-mdt.md
[User flow 3]: ../camera_4k_ai/flow3-rbf-mdt.md



[https://github.com/altera-fpga/agilex-ed-camera-ai]: https://github.com/altera-fpga/agilex-ed-camera-ai
[https://github.com/altera-fpga/modular-design-toolkit]: https://github.com/altera-fpga/modular-design-toolkit
[meta-altera-fpga]: https://github.com/altera-fpga/agilex-ed-camera-ai/tree/rel-25.1/sw/meta-altera-fpga
[meta-altera-fpga-ocs]: https://github.com/altera-fpga/agilex-ed-camera-ai/tree/rel-25.1/sw/meta-altera-fpga-ocs
[meta-vvp-isp-demo]: https://github.com/altera-fpga/agilex-ed-camera-ai/tree/rel-25.1/sw/meta-vvp-isp-demo
[agilex-ed-camera-ai/sw]: https://github.com/altera-fpga/agilex-ed-camera-ai/tree/rel-25.1/sw



[Release Tag]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/tag/rel-25.1
[https://github.com/altera-fpga/agilex-ed-camera-ai/releases/tag/rel-25.1]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/tag/rel-25.1
[hps-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/download/rel-25.1/hps-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz
[fpga-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/download/rel-25.1/fpga-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz
[fsbl_agilex5_modkit_vvpisp_time_limited.sof]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/download/rel-25.1/fsbl_agilex5_modkit_vvpisp_time_limited.sof
[top.core.jic]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/download/rel-25.1/top.core.jic
[top.core.rbf]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/download/rel-25.1/top.core.rbf
[model_compiler]: https://github.com/altera-fpga/agilex-ed-camera-ai/tree/rel-25.1/yolo_cnn



[AGX_5E_Modular_Devkit_ISP_AI_FF_RD.xml]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/AGX_5E_Altera_Modular_Dk_ISP_designs/AGX_5E_Modular_Devkit_ISP_AI_FF_RD.xml
[AGX_5E_Modular_Devkit_ISP_AI_RD.xml]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/AGX_5E_Altera_Modular_Dk_ISP_designs/AGX_5E_Modular_Devkit_ISP_AI_RD.xml
[Create microSD card image (.wic.gz) using YOCTO/KAS]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/sw/README.md
[<g>&check;</g><span hidden="true"> YOCTO/KAS </span>]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/sw/README.md

[SOF Modular Design Toolkit (MDT) Flow]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt
[RBF Modular Design Toolkit (MDT) Flow]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt
[<g>&check;</g><span hidden="true"> SOF MDT Flow </span>]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt
[<g>&check;</g><span hidden="true"> RBF MDT Flow </span>]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt



[Agilex™ 5 E-Series Modular Development Board GSRD User Guide (25.1)]: https://altera-fpga.github.io/rel-25.1/embedded-designs/agilex-5/e-series/modular/gsrd/ug-gsrd-agx5e-modular/



[Hard Processor System Technical Reference Manual: Agilex™ 5 SoCs (25.1)]: https://www.intel.com/content/www/us/en/docs/programmable/814346/25-1/hard-processor-system-technical-reference.html
[NiosV Processor for Altera® FPGA]: https://www.altera.com/design/guidance/nios-v-developer
[Agilex™ 5 FPGA E-Series 065B Modular Development Kit]: https://www.altera.com/products/devkit/a1jui0000061qabmaa/agilex-5-fpga-and-soc-e-series-modular-development-kit-es
[Agilex™ 5 FPGA E-Series 065B Modular Development Kit Product Brief]: https://www.intel.com/content/www/us/en/content-details/815178/agilex-5-fpga-e-series-065b-modular-development-kit-product-brief.html
[Altera® FPGA AI Suite]: https://www.altera.com/products/development-tools/fpga-ai-suite


[Win32DiskImager]: https://sourceforge.net/projects/win32diskimager
[7-Zip]: https://www.7-zip.org
[TeraTerm]: https://github.com/TeraTermProject/teraterm/releases
[PuTTY]: https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html


[Framos FSM:GO IMX678C Camera Modules]: https://www.framos.com/en/fsmgo
[Wide 110deg HFOV Lens]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FSMGO-IMX678C-M12-L110A-PM-A1Q1?qs=%252BHhoWzUJg4KQkNyKsCEDHw%3D%3D
[Medium 100deg HFOV Lens]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FSMGO-IMX678C-M12-L100A-PM-A1Q1?qs=%252BHhoWzUJg4IesSwD2ACIBQ%3D%3D
[Narrow 54deg HFOV Lens]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FSMGO-IMX678C-M12-L54A-PM-A1Q1?qs=%252BHhoWzUJg4L5yHZulKgVGA%3D%3D
[Framos Tripod Mount Adapter]: https://www.framos.com/en/products/fma-mnt-trp1-4-v1c-26333
[Tripod]: https://thepihut.com/products/small-tripod-for-raspberry-pi-hq-camera
[150mm flex-cable]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FMA-FC-150-60-V1A?qs=GedFDFLaBXGCmWApKt5QIQ%3D%3D&_gl=1*d93qim*_ga*MTkyOTE4MjMxNy4xNzQxMTcwMzQy*_ga_15W4STQT4T*MTc0MTE3MDM0Mi4xLjEuMTc0MTE3MDQ5OS40NS4wLjA
[300mm micro-coax cable]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FFA-MC50-Kit-0.3m?qs=%252BHhoWzUJg4K3LtaE207mhw%3D%3D
[DP to HDMI Adapter]: https://www.amazon.co.uk/gp/product/B01M6WK3KU/ref=ppx_yo_dt_b_asin_title_o02_s00?ie=UTF8&psc=1
[Framos GMSL3 5m]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FFA-GMSL3-Kit-5m?qs=%252BHhoWzUJg4IkLHv%2F6fzsXQ%3D%3D
[Framos FFA-GMSL-SER-V2A Serializer]: https://www.framos.com/en/products/ffa-gmsl-ser-v2a-27617
[Framos FFA-GMSL-DES-V2A Deserializer]: https://www.framos.com/en/products/ffa-gmsl-des-v2a-27240


[VVP IP Suite]: https://www.altera.com/products/ip/a1jui000004qxfpmak/video-and-vision-processing-suite
[MIPI DPHY IP and MIPI CSI-2 IP]: https://www.altera.com/products/ip/a1jui0000049uuamam/mipi-d-phy-ip#tab-blade-1-3
[Nios® V Processor]: https://www.altera.com/products/ip/a1jui0000049uvama2/nios-v-processors


[Altera® Quartus® Prime Pro Edition version 25.1 Linux]: https://www.intel.com/content/www/us/en/software-kit/851652/intel-quartus-prime-pro-edition-design-software-version-25-1-for-linux.html
[Altera® Quartus® Prime Pro Edition version 25.1 Windows]: https://www.intel.com/content/www/us/en/software-kit/851653/intel-quartus-prime-pro-edition-design-software-version-25-1-for-windows.html
[Altera® Quartus® Prime Pro Edition version 25.1 Programmer and Tools]: https://www.intel.com/content/www/us/en/software-kit/851652/intel-quartus-prime-pro-edition-design-software-version-25-1-for-linux.html


[ultralytics YOLO]: https://docs.ultralytics.com
[ONNX]: https://onnx.ai/
[OpenVINO Toolkit]: https://storage.openvinotoolkit.org/repositories/openvino/packages/2024.6/linux



[Test Pattern Generator IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/test-pattern-generator.html
[Switch IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/switch.html
[Black Level Statistics IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/black-level-statistics.html
[Clipper IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/clipper.html
[Defective Pixel Correction IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/defective-pixel-correction.html
[Adaptive Noise Reduction IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/adaptive-noise-reduction.html
[Black Level Correction IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/black-level-correction.html
[Vignette Correction IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/vignette-correction.html
[White Balance Statistics IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/white-balance-statistics.html
[White Balance Correction IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/white-balance-correction.html
[Demosaic IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/demosaic.html
[Histogram Statistics IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/histogram-statistics.html
[Color Space Converter IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/color-space-converter.html
[1D LUT]: https://www.altera.com/products/ip/a1jui000004r4gnmas/1d-lut-altera-fpga-ip
[1D LUT IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/1d-lut.html
[3D LUT]: https://www.altera.com/products/ip/a1jui000004r4gnmas/3d-lut-altera-fpga-ip
[3D LUT IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/3d-lut.html
[LUTCalc GitHub page]: https://github.com/cameramanben/LUTCalc
[Tone Mapping Operator]: https://www.altera.com/products/ip/a1jui000004r0hlmak/tone-mapping-operator-fpga-ip
[Tone Mapping Operator IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/tone-mapping-operator.html
[Unsharp Mask IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/unsharp-mask.html
[Warp]: https://www.altera.com/products/ip/a1jui000004rhk1mag/warp-fpga-ip
[Warp IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/warp.html
[Mixer IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/mixer.html
[Video Frame Writer IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/video-frame-writer-intel-fpga-ip.html
[Video Frame Reader IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/video-frame-reader-intel-fpga-ip.html
[Color Plane Manager IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/color-plane-manager.html
[Bits per Color Sample Adapter IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/bits-per-color-sample-adapter.html
[Protocol Converter IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/protocol-converter.html
[Pixels in Parallel Converter IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/pixels-in-parallel-converter.html
[Video and Vision Processing Suite Altera® FPGA IP User Guide]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/about-the-video-and-vision-processing-suite.html
[Altera® FPGA Streaming Video Protocol Specification]: https://www.intel.com/content/www/us/en/docs/programmable/683397/current/about-the-intel-fpga-streaming-video.html
[AMBA 4 AXI4-Stream Protocol Specification]: https://developer.arm.com/documentation/ihi0051/a/
[Avalon® Interface Specifications – Avalon® Streaming Interfaces]: https://www.intel.com/content/www/us/en/docs/programmable/683091/20-1/streaming-interfaces.html
[KAS]: https://kas.readthedocs.io/en/latest/
[EMIF]: https://www.altera.com/design/guidance/emif-support
[Scaler IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/scaler.html
[MSGDMA IP]: https://www.intel.com/content/www/us/en/docs/programmable/683130/25-1-1/modular-scatter-gather-dma-core.html


<br/>
