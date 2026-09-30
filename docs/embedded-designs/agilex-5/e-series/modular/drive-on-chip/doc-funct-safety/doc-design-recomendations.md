# Drive-On-Chip with Functional Safety Design Example for Agilex™ 5 Devices

## Drive-on-Chip Design Recommendations and Disclaimers

The Drive-on-Chip with Functional Safety Design Example for Agilex™ 5 devices
implements the CAT3 Pl D safety concept for Altera® FPGAs. The design is based
on the monitoring of axis speed in the Drive-On-Chip Design Example for Agilex™
5 Devices.

This design only shows how to implement the safety concept. Altera® does not
intend in any way for you to deploy this design in a real-world production
environment. The design is not validated for any certification related to safety
standards compliance.

This design only demonstrates the safety concept principles, but it does not
meet the rigorous standards and requirements for deployment in production
systems. You must put in place all mechanisms, validation, verification, checks,
and extension of the safety concept for your design if such application is required.

The external safety logic block constitutes a fundamental part of the safety
concept for FPGA. It must be an independent piece of hardware (another FPGA,
micro-controller, CPU, etc) for the safety concept to be valid. This design
includes the external safety logic in the same Agilex™ device fabric as the
safety function logic to demonstrate the design in a single chip. You must
implement the external safety logic as a separate entity.

The design provides meta-layers for custom Yocto build based on KAS with the
same underlying components recommended in the Agilex™ 5 GSRD 25.1 documented on
the [**Altera® FPGA Developer Site**](https://altera-fpga.github.io/) website.
The meta layer provides the application and the modifications to the SD card
collaterals to enable the HPS safety channel and the communication with devices
in the FPGA fabric. However, you must modify or fix the meta layer and the
software application components if you use any other version of these components
as a base to build the SD card image. Altera® does not maintain the SW and SD
card images. An SD card image, based on the GSRD and/or in this example design
is not a production ready framework. You must validate the operating system of
your choice and programming models to certify your system with functional safety
standards.

<br>

[Back to Documentation](../doc-funct-safety.md#example-design-documentation){ .md-button }
