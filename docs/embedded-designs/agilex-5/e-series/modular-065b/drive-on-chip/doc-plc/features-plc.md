

[Drive-On-Chip with Functional Safety System Example Design for Agilex™ 5 Devices]: https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/drive-on-chip/doc-funct-safety
[Drive-On-Chip with PLC System Example Design for Agilex™ Devices]: https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/drive-on-chip/doc-plc
[ROS Consolidated Robot Controller Example Design for Agilex™ 5 Devices]: https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/drive-on-chip/doc-crc
[Robot Controller with Vision System Example Design for Agilex™ 5 Devices]: https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/robotics/robotics-vision-doc
[Robotics Camera System Example Design for Agilex™ 5 Devices]: https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/robotics/robotics-camera
[Agilex™ 5 FPGA - Drive-On-Chip Design Example]: https://docs.altera.com/r/example-designs/825736/current
[Altera® Agilex™ 7 FPGA – Drive-On-Chip for Altera® Agilex™ 7 Devices Design Example]: https://docs.altera.com/r/example-designs/780358/current
[Agilex™ 7 FPGA – Safe Drive-On-Chip Design Example]: https://docs.altera.com/r/example-designs/825942/current
[Agilex™ 5 E-Series Modular Development Kit GSRD User Guide (26.1)]: https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/gsrd/ug-gsrd-agx5e-modular-065b/
[Agilex™ 5 E-Series Modular Development Kit GHRD Linux Boot Examples]: https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/modular/boot-examples/ug-linux-boot-agx5e-modular/




[AN 1000: Drive-on-Chip Design Example: Agilex™ 5 Devices]: https://docs.altera.com/r/docs/826207/current
[AN 999: Drive-on-Chip with Functional Safety Design Example: Agilex™ 7 Devices]: https://docs.altera.com/r/docs/823627/current/an-999-drive-on-chip-with-functional-safety-design-example-agilextm-7-devices
[AN 994: Drive-on-Chip Design Example for Altera® Agilex™ 7 Devices]: https://docs.altera.com/r/docs/780361/current/an-994-drive-on-chip-design-example-for-agilextm-7-devices
[AN 773: Drive-On-Chip Design Example for Altera® MAX® 10 Devices]: https://docs.altera.com/r/docs/683072/current/an-773-drive-on-chip-design-example-for-intel-max-10-devices
[AN 669: Drive-On-Chip Design Example for Cyclone V Devices]: https://docs.altera.com/r/docs/683466/current/an-669-drive-on-chip-design-example-for-cyclone-v-devices



[Hard Processor System Technical Reference Manual: Agilex™ 5 SoCs (26.1)]: https://docs.altera.com/r/docs/814346/26.1/hard-processor-system-technical-reference-manual-agilextm-5-socs
[NiosV Processor for Altera® FPGA]: https://www.altera.com/products/ip/po-3098/nios-v-processors
[Tandem Motion-Power 48 V Board Reference Manual]: https://docs.altera.com/r/docs/683164/current/tandem-motion-power-48-v-board-reference-manual
[Agilex™ 5 FPGA E-Series 065B Modular Development Kit]: https://www.altera.com/products/devkit/po-3274/agilex-5-fpga-and-soc-e-series-065b-modular-development-kit
[Agilex™ 3 FPGA C-Series Development Kit]: https://www.altera.com/products/devkit/po-3000/agilex-3-fpga-and-soc-c-series-development-kit
[Agilex™ 3 FPGA and SoC C-Series Development Kit]:https://www.altera.com/products/devkit/a1jui000004kfuxma0/agilex-3-fpga-and-soc-c-series-development-kit
[Motor Control Designs with an Integrated FPGA Design Flow]: https://docs.altera.com/v/u/docs/654665/motor-control-ip-suite-components-for-drive-on-chip-reference-designs
[Install Docker Engine]: https://docs.docker.com/engine/install/
[Docker Build: Multi-Platform Builds]: https://docs.docker.com/build/building/multi-platform/
[quartus_pgm command]: https://docs.altera.com/r/docs/847422/25.3.1/device-configuration-user-guide-agilextm-3-fpgas-and-socs/understanding-configuration-status-using-quartus_pgm-command


[Disk Imager]: https://sourceforge.net/projects/win32diskimager


# Drive-On-Chip with PLC Design Example for Agilex™ Devices

## Features of the Drive-on-Chip with PLC Design Example for Agilex™ Devices

### Linux operating system on the Agilex™ HPS

* Based on Poky Linux with additional Yocto layers supporting Altera® FPGAs.
* Uses the Yocto build system.
* Additional Yocto Layer(s) supporting OpenPLC and Docker (meta-altera-fpga).

### Docker container for Runtime

A Docker container is an encapsulated environment used to isolate
programs from each other within an operating system.

* Dockerfile and build scripts are supplied for OpenPLC runtime.
* Docker build flow for cross-compiling:
  * The container is built on x86 system to run on Arm processor HPS.

### OpenPLC Runtime

The OpenPLC Runtime is a system for running IEC 61131 Structured
Text (ST) PLC Applications to control the Drive-on-Chip simulated
motor axes.

* OpenPLC is an Open Source PLC (Programmable Logic Controller) Runtime.
* The PLC Runtime has software tools to convert the PLC application
  (written in Structured Text) to a compiled binary for the Agilex™ HPS.
* The software compiling tools run on a host PC x86-64 architecture and the
  output binaries (docker image) are for the Arm64 (Agilex™ HPS architecture)
* A Motion Control library as specified by the PLCOpen Standard
  is integrated into the runtime and is available to PLC applications.
* The Motion Control library provides a high level API for motor
  axis control e.g. setting velocity, setting position, stopping,
  etc; with defined constraints for acceleration and speed.
* Drive-On-Chip OpenPLC driver for Agilex™ devices.
* Ruckig library for trajectory control.
* Hardware support for dual axis Agilex™ Drive-On-Chip IP application.
* Structured Text (.st) example application for Agilex™ Drive-On-Chip control.

### Drive-on-Chip Motor Control IP on the Agilex™ FPGA

* Integration in a single Agilex™ FPGA of multi-axis
  motor control IP, see:
  * [AN 1000: Drive-on-Chip Design Example: Agilex™ 5 Devices](https://docs.altera.com/r/docs/826207/current)
  * [AN 999: Drive-on-Chip with Functional Safety Design Example: Agilex™ 7 Devices](https://docs.altera.com/r/docs/823627/current/an-999-drive-on-chip-with-functional-safety-design-example-agilextm-7-devices)

<br>

[Back to Documentation](../doc-plc.md#example-design-documentation){ .md-button }
