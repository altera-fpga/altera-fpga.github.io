# Robot Controller with Vision System Example Design — Acronyms and Terminology

<center>

**Acronyms and Terminology**

| **Term**             | **Description** |
| :------------------: | :-------------- |
|                      | **Platform and design methodology** |
| AXI                  | Advanced eXtensible Interface — on-chip interconnect protocol used by HPS bridges and many IP cores |
| BSP                  | Board Support Package — software support layer for embedded processors (Nios® V / NiosV/g) |
| CSR                  | Control and Status Registers — memory-mapped registers used to configure and monitor IP blocks |
| EMIF                 | External Memory Interface — FPGA interface to external DDR memory used for frame buffering |
| FPGA                 | Field-Programmable Gate Array — programmable logic device hosting the vision and motor-control pipelines |
| F2SDRAM              | FPGA-to-SDRAM bridge — hardened path between FPGA logic and HPS-attached system memory |
| HPS                  | Hard Processor System — integrated ARM processors running Linux and application software |
| HPS2FPGA             | HPS-to-FPGA bridge — memory-mapped access from HPS into FPGA fabric |
| IP                   | Intellectual Property — licensed or custom hardware blocks integrated in Platform Designer |
| IRQ                  | Interrupt Request — signal from hardware to processor for event handling |
| ISR                  | Interrupt Service Routine — software handler executed when an IRQ is asserted |
| JTAG                 | Joint Test Action Group — industry-standard debug and programming interface |
| MDT                  | Modular Design Toolkit — XML-driven flow to create and build Platform Designer systems from subsystems |
| MIPI                 | Mobile Industry Processor Interface — standard for camera sensor and display interfaces |
| PD                   | Platform Designer — Altera® system integration tool (formerly Qsys) |
| PIP                  | Pixels In Parallel — number of parallel pixels processed per clock in streaming video IP |
| QPDS                 | Quartus® Prime Design Software |
| RTL                  | Register Transfer Level — hardware description level for FPGA design |
| SoC                  | System-on-Chip — device combining processors and FPGA in one package |
| UART                 | Universal Asynchronous Receiver-Transmitter — serial console interface |
| UIO                  | Userspace I/O — Linux mechanism to access hardware registers/devices from user space |
|                      | **Vision, ISP, and display** |
| AE                   | Auto Exposure — automatic adjustment of exposure time/gain |
| ArUco                | Augmented Reality marker dictionary — fiducial markers used for pose estimation and visual feedback |
| AWB                  | Auto White Balance — automatic color balance correction |
| Bayer                | Raw sensor format where each pixel is one of R, G, or B (CFA pattern) |
| BLC                  | Black Level Correction — offset correction for sensor black level |
| BLS                  | Black Level Statistics — hardware statistics used to guide BLC/AE |
| CCM                  | Color Correction Matrix — color transformation matrix in the ISP pipeline |
| CFA                  | Color Filter Array — sensor color filter layout (often Bayer) |
| CSC                  | Color Space Converter — converts between color spaces (for example RGB to YCbCr or grayscale) |
| CSI-2                | MIPI Camera Serial Interface — packetized protocol for image data from sensors |
| Demosaic (DMS)       | Reconstruction of full-color pixels from Bayer CFA data |
| DisplayPort (DP)     | Digital display interface standard used for local video output |
| D-PHY                | MIPI physical layer for high-speed serial camera/display links |
| FPS                  | Frames Per Second — video frame rate |
| HDR                  | High Dynamic Range — imaging with extended luminance range (full camera designs; optional in lite variants) |
| HS                   | Histogram Statistics — pixel distribution stats for AE/AWB loops |
| ISP                  | Image Signal Processor — pipeline block(s) for raw-to-processed video |
| ISP Lite             | Streamlined ISP variant used in robotics camera/vision designs (versus full multi-stage HDR ISP) |
| LUT                  | Look-Up Table — 1D/3D tables for tone/color transforms |
| MSGDMA               | Modular Scatter-Gather DMA — DMA engine for efficient memory transfers between FPGA and HPS |
| OBR                  | Optical Black Region — sensor/optical black reference region |
| Remosaic (RMS)       | Re-insertion of Bayer pattern from processed data (used with test-pattern paths) |
| RGB                  | Red, Green, Blue — common processed video color format |
| TMO                  | Tone Mapping Operator — HDR tone reproduction (full [VVP IP Suite] designs) |
| TPG                  | Test Pattern Generator — synthetic video source for debug without a sensor |
| UHD                  | Ultra-High Definition — typically 4K resolution video |
| VVP                  | Video and Vision Processing — Altera® IP suite for camera/vision pipelines |
| WBC                  | White Balance Correction — color gain adjustment in the ISP |
|                      | **Drive-on-Chip and motion control** |
| 3×2 (DoC)            | Three dual-axis Drive-on-Chip instances — six motor axes total in this vision variant |
| ADC                  | Analog-to-Digital Converter — samples motor phase currents and other analog signals |
| BLDC                 | Brushless DC motor — common motor type controlled by FOC |
| DoC                  | Drive-on-Chip — motor control IP and reference designs in FPGA fabric |
| FOC                  | Field-Oriented Control — motor control algorithm operating in the rotating reference frame |
| PMSM                 | Permanent Magnet Synchronous Motor — motor type commonly used with FOC |
| PWM                  | Pulse-Width Modulation — technique to drive inverter switches for motor phases |
| QEP                  | Quadrature Encoder Pulse — encoder interface for position/speed feedback |
|                      | **Software, robotics, and build flows** |
| Docker               | Container runtime used to deploy ROS 2/MoveIt environments on the HPS |
| DTB                  | Device Tree Blob — compiled device tree consumed by Linux boot |
| DTS                  | Device Tree Source — source description of hardware visible to Linux |
| KAS                  | Tooling to orchestrate Yocto/OpenEmbedded builds from YAML manifests |
| MoveIt / MoveIt2     | ROS motion-planning framework used with the example robot controller flow |
| OpenPLC              | Open-source PLC runtime (referenced in some robotics software stacks) |
| ROS / ROS 2          | Robot Operating System — middleware for robotics applications |
| ROS Control          | ROS framework for hardware interfaces to actuators/sensors |
| RViz                 | ROS visualization tool for robot models, scenes, and topics |
| Yocto                | Embedded Linux build system used to produce the HPS `.wic` image |

</center>

<br>

[Back to Documentation](../robotics-vision-doc.md#example-design-documentation){ .md-button }
