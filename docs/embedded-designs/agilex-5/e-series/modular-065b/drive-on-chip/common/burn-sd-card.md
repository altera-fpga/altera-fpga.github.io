

[Drive-On-Chip with Functional Safety System Example Design for Agilex™ 5 Devices]: https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/drive-on-chip/doc-funct-safety
[Drive-On-Chip with PLC System Example Design for Agilex™ Devices]: https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/drive-on-chip/doc-plc
[ROS Consolidated Robot Controller Example Design for Agilex™ 5 Devices]: https://altera-fpga.github.io/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/drive-on-chip/doc-crc
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


### SD Card Image Flashing

* Download SD card image (`.wic` or `.wic.gz`) from the prebuilt binary links above.
* Write the `.wic` or `.wic.gz` SD card image to the micro SD card using one of the options below.
* Turn off the board and insert the SD card in the micro SD card slot on the SOM board.

#### [USBImager](https://bztsrc.gitlab.io/usbimager/) (Windows, Linux, Mac OS)

* Open [USBImager](https://bztsrc.gitlab.io/usbimager/) and click the `...` button in the top right.
* Select the image you downloaded earlier and click `Open`.
* Next select the device associated with your SD card reader from the drop-down list.
* Click `Write` to start flashing.

#### [bmaptool](https://github.com/yoctoproject/bmaptool) (Linux)

!!! note
    You will require a `.wic.bmap` file in addition to the `.wic` or `.wic.gz` in order to use `bmaptool`. If this is not available use `USBImager`.

On many distributions `bmap-tools` can be installed using your distros package manager (e.g. `sudo apt install bmap-tools`).

For more information see the [Yocto documentation](https://docs.yoctoproject.org/dev-manual/bmaptool.html) for `bmaptool`.

First of all determine the device `logical name` associated with the SD card on your host:

```
sudo lshw -class disk
```

Use `bmaptool` to copy the image to the SD card. Make sure the `wic` image file and `bmap` file are in the same directory.

```
sudo bmaptool copy ${IMAGE} ${DEVICE}
```

For example:

```
sudo bmaptool copy core-image-minimal-agilex5_mk_a5e065bb32aes1.wic.gz /dev/sda
```
