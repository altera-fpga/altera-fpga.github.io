

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
