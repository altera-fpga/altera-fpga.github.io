# Robotics Camera System Example Design — Acronyms and Terminology

<center>

**Acronyms and Terminology**

| **Term**                 | **Description** |
| :----------------------: | :-------------- |
|                          | **Platform and design methodology** |
| AXI                      | Advanced eXtensible Interface — on-chip interconnect protocol used by HPS bridges and many IP cores |
| BSP                      | Board Support Package — software support layer for embedded processors (Nios® V) |
| CSR                      | Control and Status Registers — memory-mapped registers used to configure and monitor IP blocks |
| EMIF                     | External Memory Interface — FPGA interface to external DDR memory used for frame buffering |
| FPGA                     | Field-Programmable Gate Array — programmable logic device hosting the camera pipeline |
| F2SDRAM                  | FPGA-to-SDRAM bridge — hardened path between FPGA logic and HPS-attached system memory |
| Glass-to-glass           | End-to-end path from image sensor through FPGA processing to display output |
| HPS                      | Hard Processor System — integrated ARM processors running Linux and application software |
| HPS2FPGA                 | HPS-to-FPGA bridge — memory-mapped access from HPS into FPGA fabric |
| IP                       | Intellectual Property — licensed or custom hardware blocks integrated in Platform Designer |
| IRQ                      | Interrupt Request — signal from hardware to processor for event handling |
| ISR                      | Interrupt Service Routine — software handler executed when an IRQ is asserted |
| JTAG                     | Joint Test Action Group — industry-standard debug and programming interface |
| MDT                      | Modular Design Toolkit — XML-driven flow to create and build Platform Designer systems from subsystems |
| MIPI                     | Mobile Industry Processor Interface — standard for camera sensor and display interfaces |
| Nios® V                  | Soft processor in FPGA fabric used for video pipeline control in this design |
| PD                       | Platform Designer — Altera® system integration tool (formerly Qsys) |
| PIP                      | Pixels In Parallel — number of parallel pixels processed per clock in streaming video IP |
| QPDS                     | Quartus® Prime Design Software |
| RTL                      | Register Transfer Level — hardware description level for FPGA design |
| SoC                      | System-on-Chip — device combining processors and FPGA in one package |
| UART                     | Universal Asynchronous Receiver-Transmitter — serial console interface |
|                          | **Vision, ISP, and display** |
| AE                       | Auto Exposure — automatic adjustment of exposure time/gain |
| AWB                      | Auto White Balance — automatic color balance correction |
| Bayer                    | Raw sensor format where each pixel is one of R, G, or B (CFA pattern) |
| BLC                      | Black Level Correction — offset correction for sensor black level |
| BLS                      | Black Level Statistics — hardware statistics used to guide BLC/AE |
| CCM                      | Color Correction Matrix — color transformation matrix in the ISP pipeline |
| CFA                      | Color Filter Array — sensor color filter layout (often Bayer) |
| Clipper                  | Video IP block that crops the active region of a frame |
| CSC                      | Color Space Converter — converts between color spaces (for example RGB to grayscale) |
| CSI-2                    | MIPI Camera Serial Interface — packetized protocol for image data from sensors |
| Demosaic (DMS)           | Reconstruction of full-color pixels from Bayer CFA data |
| DisplayPort (DP)         | Digital display interface standard used for local video output |
| D-PHY                    | MIPI physical layer for high-speed serial camera/display links |
| FPS                      | Frames Per Second — video frame rate |
| FRAMOS IMX678            | Framos FSM:GO IMX678C Camera Modules: sensor used on the modular development kit MIPI connector |
| HDR                      | High Dynamic Range — imaging with extended luminance range (not used in ISP Lite path) |
| HS                       | Histogram Statistics — pixel distribution stats for AE/AWB loops |
| ISP                      | Image Signal Processor — pipeline block(s) for raw-to-processed video |
| ISP In                   | Platform Designer subsystem selecting live Bayer input or test-pattern path |
| ISP Lite                 | Streamlined ISP variant — BLC, white balance, demosaic, and CCM in this design |
| ISP Lite Out             | Output stage of ISP Lite feeding ISP Robotics and the display path |
| ISP Out                  | Platform Designer subsystem buffering the 4K RGB path, mixer, and DisplayPort TX |
| ISP Robotics             | Robotics-oriented processing between ISP Lite and display — clip/scale, grayscale, frame buffer, and mixer inputs |
| LUT                      | Look-Up Table — 1D/3D tables for tone/color transforms |
| Mixer                    | Video compositor combining full-resolution RGB, grayscale preview, and overlays |
| MSGDMA                   | Modular Scatter-Gather DMA — DMA engine for frame transfers between FPGA EMIF and HPS memory |
| OBR                      | Optical Black Region — sensor/optical black reference region |
| Remosaic (RMS)           | Re-insertion of Bayer pattern from processed data (test-pattern debug path in ISP In) |
| RGB                      | Red, Green, Blue — processed video color format on the main display path |
| Scaler                   | Video IP block that resizes frames (for example 4K to 1080p and 540p branches) |
| TMO                      | Tone Mapping Operator — HDR tone reproduction (full camera solution designs) |
| TPG                      | Test Pattern Generator — synthetic video source for debug without a sensor |
| UHD                      | Ultra-High Definition — typically 4K (3840×2160) in this design |
| VVP                      | Video and Vision Processing — Altera® IP suite for camera/vision pipelines |
| WBC                      | White Balance Correction — color gain adjustment in the ISP |
|                          | **Software, robotics, and build flows** |
| Docker                   | Container runtime used to deploy application on the HPS |
| DTB                      | Device Tree Blob — compiled device tree consumed by Linux boot |
| DTS                      | Device Tree Source — source description of hardware visible to Linux |
| KAS                      | Tooling to orchestrate Yocto/OpenEmbedded builds from YAML manifests |
| mono8                    | Single-channel 8-bit pixel encoding used by the robotics_camera package (`sensor_msgs/Image`) |
| robotics_camera          | ROS 2 package and launch flow publishing grayscale frames from ISP Robotics to `/robotics_camera/image_raw` |
| ROS / ROS 2              | Robot Operating System — middleware for perception, recording, and visualization |
| RViz                     | ROS visualization tool for viewing `/robotics_camera/image_raw` and other topics |
| sensor_msgs              | ROS 2 message package; this design publishes `sensor_msgs/msg/Image` |
| Yocto                    | Embedded Linux build system used to produce the HPS `.wic` image |

</center>

<br>

[Back to Documentation](../robotics-camera.md#example-design-documentation){ .md-button }
