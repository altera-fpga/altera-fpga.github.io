

# 4Kp30 Multi-Sensor Camera with AI Inference Solution System Example Design for Agilex™ 5 Devices

The design is compatible with
[Altera® Quartus® Prime Pro Edition version 26.1 Linux](https://www.altera.com/downloads/fpga-development-tools/quartus-prime-pro-edition-design-software-version-26-1-linux).

## Overview

The 4Kp30 Multi-Sensor Camera with AI Inference Solution System Example Design
for Agilex™ 5 Devices demonstrates a practical glass-to-glass smart camera
solution. The exclusive support for industry-standard MIPI (Mobile Industry
Processor Interface) D-PHY and MIPI CSI-2 interface on Agilex™ 5 FPGAs, along
with Altera®'s FPGA AI Suite, provides a powerful tool for smart camera product
development.

|<center markdown="1">An example of AI Detect</center>|<center markdown="1">An example of AI Pose</center>|
|-|-|
| ![Detect example](../camera_4k_ai/images/detect_hd.png) | ![POSE example](../camera_4k_ai/images/pose_hd.png) |

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

## Detailed Design

The detailed design can be found at [camera_4k_ai.md](https://github.com/altera-fpga/agilex5-ed-camera/blob/rel/26.1/docs/camera/camera_4k_ai/camera_4k_ai.md)

The project GitHub repository can be found at [https://github.com/altera-fpga/agilex5-ed-camera](https://github.com/altera-fpga/agilex5-ed-camera)

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

<br/>
