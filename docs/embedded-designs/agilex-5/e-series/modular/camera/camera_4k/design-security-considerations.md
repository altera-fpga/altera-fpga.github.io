

# 4Kp60 Multi-Sensor HDR Camera Solution System Example Design for Agilex™ 5 Devices - Design Security Considerations

This system example design is provided as a demonstration specifically for the
IP components of the ISP and is not intended for a final product or deployment.
As such, there are several features of the design that may not meet customer
safety and security requirements. It is important for you to conduct a safety
and security review of your final design to ensure you meet your safety and
security goals. Some of the areas of further consideration are listed below.
Please note that this is not an exhaustive list, and you should perform a full
security review of your own system, considering hardware, FPGA design and
software aspects, depending on the market requirements of the final product.

## JTAG/serial port connections 

The development kit hardware includes access to various parts of the design
using industry standard interfaces. In this design, these ports are freely
available to use to allow visibility into the design and for debug purposes. You
should consider whether these access points are to be made available on your
own hardware. If so, they should be protected as per your own security
requirements and policies.

## Debug capability 

This design includes multiple debug paths, for example, the use of technologies
such as Signal Tap, in-system memory editors, access to debuggers, etc. This
level of debug access may not be desirable in a final product, and you should
consider removing or restricting these capabilities.

## Frame buffers

This design stores video data in various frame buffers held in both external
DDR4 SDRAM memory and on-chip memory blocks. This video information is not
encrypted or protected in any way. You should consider if you wish to apply
security features to the way the video data is stored.

## Memory management

You may implement fine-grained memory access management and put restrictions in
place to prevent unauthorized access and protect memory corruption by other
IPs.

## Use of encrypted/protected video feeds

This design uses an industry standard DisplayPort video output interface.
Within the design, these video streams are not protected against security
attacks. You should consider the use of encryption techniques to meet your own
security requirements. An example could be the use of the HDCP encryption
scheme that is part of the feature set of the video standard.

## FPGA bitstream encryption

This design does not use Altera®’s FPGA bitstream encryption technology. You
may use this feature to further protect the FPGA design content of your
products. Refer to Using the Design Security Features in Altera® FPGAs for
information on FPGA bitstream encryption technology.

## Secure booting and OS restrictions

This design does not employ a secure booting scheme, which should be considered
in production-grade designs. The microSD card is not encrypted and therefore
can be mounted on another device and accessed freely. Furthermore, the embedded
OS does not include predefined user accounts and access policies, instead, a
root account with no password carries out all operations. In a final product
you should restrict access according to the intended use cases.

## Safe booting and remote updates

Adding remote update capability to a design is important for a final product,
which is not part of this system example design. It enables patching
vulnerabilities and making improvements on the product in the field, especially
when it is not feasible to gain physical access to the product. Various stages
of the bootloader, embedded Linux, drivers, application software, HPS
configurations and FPGA bitstream files may be updated remotely with
appropriate recovery mechanisms in place. You may also consider adding remote
reset and power cycling features depending on the application.

## Secure network connection

In this design the web server of the application uses unencrypted HTTP
protocol. In a final product it is necessary to consider the safety
implications and use encryption on all types of network connections. It is also
imperative to have a firewall suitable for the end user product with proper
restrictions and other security considerations in place. In extreme cases you
may disable network connectivity at OS kernel level when network connectivity
is not desired. 

## Related Information

* [AN 556: Using the Design Security Features in Altera FPGAs](https://www.intel.com/content/www/us/en/docs/programmable/683269/current/using-the-design-security-features-in-fpgas.html)

<br>

[Back](../camera_4k/camera_4k.md#documentation){ .md-button }







[User flow 1]: ../camera_4k/camera_4k.md#pre-requisites
[User flow 2]: ../camera_4k/flow2-sof-mdt.md
[User flow 3]: ../camera_4k/flow3-rbf-mdt.md



[https://github.com/altera-fpga/agilex-ed-camera]: https://github.com/altera-fpga/agilex-ed-camera
[https://github.com/altera-fpga/modular-design-toolkit]: https://github.com/altera-fpga/modular-design-toolkit
[meta-altera-fpga]: https://github.com/altera-fpga/agilex-ed-camera/tree/rel-25.1/sw/meta-altera-fpga
[meta-altera-fpga-ocs]: https://github.com/altera-fpga/agilex-ed-camera/tree/rel-25.1/sw/meta-altera-fpga-ocs
[meta-vvp-isp-demo]: https://github.com/altera-fpga/agilex-ed-camera/tree/rel-25.1/sw/meta-vvp-isp-demo
[agilex-ed-camera/sw]: https://github.com/altera-fpga/agilex-ed-camera/tree/rel-25.1/sw



[Release Tag]: https://github.com/altera-fpga/agilex-ed-camera/releases/tag/rel-25.1
[https://github.com/altera-fpga/agilex-ed-camera/releases/tag/rel-25.1]: https://github.com/altera-fpga/agilex-ed-camera/releases/tag/rel-25.1
[hps-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz]: https://github.com/altera-fpga/agilex-ed-camera/releases/download/rel-25.1/hps-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz
[fpga-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz]: https://github.com/altera-fpga/agilex-ed-camera/releases/download/rel-25.1/fpga-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz
[fsbl_agilex5_modkit_vvpisp_time_limited.sof]: https://github.com/altera-fpga/agilex-ed-camera/releases/download/rel-25.1/fsbl_agilex5_modkit_vvpisp_time_limited.sof
[top.core.jic]: https://github.com/altera-fpga/agilex-ed-camera/releases/download/rel-25.1/top.core.jic
[top.core.rbf]: https://github.com/altera-fpga/agilex-ed-camera/releases/download/rel-25.1/top.core.rbf
[model_compiler]: https://github.com/altera-fpga/agilex-ed-camera/releases/download/rel-25.1/compile_model.exe



[AGX_5E_Modular_Devkit_ISP_FF_RD.xml]: https://github.com/altera-fpga/agilex-ed-camera/blob/rel-25.1/AGX_5E_Altera_Modular_Dk_ISP_designs/AGX_5E_Modular_Devkit_ISP_FF_RD.xml
[AGX_5E_Modular_Devkit_ISP_RD.xml]: https://github.com/altera-fpga/agilex-ed-camera/blob/rel-25.1/AGX_5E_Altera_Modular_Dk_ISP_designs/AGX_5E_Modular_Devkit_ISP_RD.xml
[Create microSD card image (.wic.gz) using YOCTO/KAS]: https://github.com/altera-fpga/agilex-ed-camera/blob/rel-25.1/sw/README.md
[<g>&check;</g><span hidden="true"> YOCTO/KAS </span>]: https://github.com/altera-fpga/agilex-ed-camera/blob/rel-25.1/sw/README.md

[SOF Modular Design Toolkit (MDT) Flow]: https://github.com/altera-fpga/agilex-ed-camera/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt
[RBF Modular Design Toolkit (MDT) Flow]: https://github.com/altera-fpga/agilex-ed-camera/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt
[<g>&check;</g><span hidden="true"> SOF MDT Flow </span>]: https://github.com/altera-fpga/agilex-ed-camera/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt
[<g>&check;</g><span hidden="true"> RBF MDT Flow </span>]: https://github.com/altera-fpga/agilex-ed-camera/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt

