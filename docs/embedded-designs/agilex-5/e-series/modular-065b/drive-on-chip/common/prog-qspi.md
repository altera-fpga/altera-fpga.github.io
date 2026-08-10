

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


* Download the `.jic` image from the prebuilt binary links above.
* Power down the board.
* Set **MSEL** dipswitch **S1** on SOM to **JTAG: OFF-OFF**
* Power up the board.
* Program the QSPI with the following command. See: [quartus_pgm command](https://docs.altera.com/r/docs/847422/25.3.1/device-configuration-user-guide-agilextm-3-fpgas-and-socs/understanding-configuration-status-using-quartus_pgm-command)

    ```bash
    quartus_pgm -c 1 -m jtag -o "pvi;top.hps.jic"
    ```

* **(Optional)** Use the Quartus® Programmer GUI

  * Launch the Quartus® Programmer and Configure the **"Hardware Setup..."**
    and select the SOM device (SM27 MDK OB-SOM UBIII)

  * Click "Auto Detect", select the device `A5ED065BB32A` and press
    **"Change File.."**

  * Select the `.jic` file you downloaded earlier. The `MT25QU02G` device
    should now show. Select the **"Program/Configure"** box, and press **"Start"**.
    Wait until completed (It could take several minutes).
  <br>

  ![programmer-agx5-2](./common/images/programmer-agx5-2.png){:style="display:block; margin-left:auto; margin-right:auto"}

  <br>

* Power down the board. Set **MSEL** dip switch **S1** on SOM to **ASX4 (QSPI): ON-ON**
<br>
