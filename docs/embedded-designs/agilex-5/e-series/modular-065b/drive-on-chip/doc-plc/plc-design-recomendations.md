# Drive-On-Chip with PLC Design Example for Agilex™ Devices

## Recommendations and Disclaimers

The Drive-on-Chip with PLC Design Example for Agilex™ devices
implements the a combination of hardware compiled using Quartus®, Altera®
Platform designer and high-level software from OpenSource resources
deployed with Docker to demonstrate a basic PLC (Programmable Logic Controller)
system. The design is based on the controlling the Drive-On-Chip IP (dual axis)
from a Structured Text (ST) PLC IEC 61131-3 complaint program and the
OpenPLC Runtime.

This design only shows how to implement the PLC system concept in a SoC
FPGA device. Altera® does not intend in any way for you to deploy
this design in a real-world production environment. The design is
not validated for any certification related to industrial or safety
standards compliance.

This design only demonstrates the PLC concept principles, but it does not
meet the rigorous standards and requirements for deployment in production
systems. You must put in place all mechanisms, validation, verification, checks,
and extension of your production application.

The design provides meta-layers for custom Yocto build based on KAS with the
same underlying components recommended in the Agilex™ GSRD documented on
the [**Altera® FPGA Developer Site**](https://altera-fpga.github.io/) website.
The meta layer provides the application and the modifications to the SD card
collaterals to enable the HPS software stack and the communication with devices
in the FPGA fabric. However, you must modify or fix the meta layer and the
software application components if you use any other version of these components
as a base to build the SD card image. Altera® does not maintain the SW and SD
card images. An SD card image, based on the GSRD and/or in this example design
is not a production ready framework. You must validate the operating system of
your choice and programming models to certify your system with suitable industry
standards. The same principles apply with any "production-ready" implications
concerning the deployment of docker containers and OpenSource software.

<br>

[Back to Documentation](../doc-plc.md#example-design-documentation){ .md-button }
