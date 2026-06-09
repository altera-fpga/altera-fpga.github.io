

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


# Drive-On-Chip with PLC Design Example for Agilex™ Devices

## Compiling the project using a MDT QAR file

* Download the relevant design `.qar` file for your development kit and power
   board from  link/repository.

* Double click in the .qar file or alternatively use Quartus® command line to
  open it:

    ```bash
      quartus <MDT_QAR_NAME>.qar
    ```

    The contents of the `.qar` file open into the working directory. The
    design example has the following directory structure.

    <br>

    ![qar-content](/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/drive-on-chip/common/images/qar-content.png){:style="display:block; margin-left:auto; margin-right:auto"}
    <center>

    **QAR file content.**
    </center>
    <br>

    **Note:** This `QAR` file was generated using the "Modular Design Toolkit" flow.

    <br>

    <center>

     **QAR and Project Directory Structure.**

    | Directory     | Description  |
    | --------------| ---- |
    | assets        | Contains base files to run the example design derived from the hardware compilation. |
    | non_qpds_ip   | Contains the source code (RTL) of the design’s custom IP that is not part of Quartus® Prime. |
    | quartus       | Contains the base files for the Quartus® Project including the top.qpf, top.qsf. |
    | rtl           | Contains the sources files to build the project. |
    | scripts       | Contains a collection of TCL scripts from "Modular Design Toolkit" to build and compile the design software and hardware. |
    | sdc           | Contains the .sdc files for the subsystems to compile the project. |
    | software      | Contains all the files for building the application for the Nios V and/or HPS. Look for the app.elf binary or *_cpu_ram_cpu_ram.hex that is included in the SOF |

    </center>

<br>

* Navigate to `<project>/quartus/` and open the `top.qpf` file either by double
   clicking on it or using the command:

    ```bash
    quartus top.qpf
    ```

* To generate the `.sof` file, click on **"Processing -> Start Compilation Ctrl+L"**
  or simply press the **"Start Compilation"** icon in the Quartus® Prime Pro GUI.

<br>

![quartus-comp](/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/drive-on-chip/common/images/quartus-comp.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**Quartus® Prime Pro compilation flow.**
</center>
<br>

  Wait for the compilation to finish. The `.sof` file should be located in the
  `<project>/quartus/output_files` directory. Follow the steps generate the
  `RBF/JIC` file using the `.sof` file and the `u-boot-spl-dtb.hex` file.

**Note:** it si recommended to generate any embedded software images that are
included in the `.sof` file before compiling, i.e NiosV software.


<br>

[Back to User Flows](../doc-plc.md#recommended-user-flows){ .md-button }



<br>

[Back to User Flows](../doc-plc.md#recommended-user-flows){ .md-button }



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


## Creating the QSPI Flash and SD card configuration bitstreams for the board

### Create phase 1 and phase 2 configuration bitstreams for "HPS First" Flow

Follow these steps if the "HPS init" property for the `hps_subsystem` in the `XML`
is set to `"HPS FIRST"`. You can check this property by executing the following
Quartus® command and the `"\*.sof"` file. For example:

``` bash
quartus_pfg -i top.sof
```

**Note:** top.sof is located in `<project>/quartus/output_files/top.sof`

In the log, look for the property `"HPS/FPGA configuration order"` SET TO `"HPS_FIRST"`

<br>

![hps-first](/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/drive-on-chip/common/images/hps-first.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**HPS First SOF file.**
</center>
<br>

**Important!** The following step depends on the output of u-boot compilation
specifically the file `u-boot-spl-dtb.hex`. To generate the pair `top.core.rbf`
and `top.hps.jic` execute:

**Note:** top.sof is located in `<project>/quartus/output_files/top.sof`

=== "Agilex™ 5"
    For [Agilex™ 5 FPGA E-Series 065B Modular Development Kit](https://www.altera.com/products/devkit/po-3274/agilex-5-fpga-and-soc-e-series-065b-modular-development-kit)
    ```bash
    quartus_pfg -c top.sof top.jic \
    -o device=MT25QU02G \
    -o flash_loader=A5ED065BB32AE4S \
    -o hps_path=u-boot-spl-dtb.hex \
    -o mode=ASX4 \
    -o hps=1
    ```
=== "Agilex™ 3"
    For [Agilex™ 3 FPGA and SoC C-Series Development Kit]
    ```bash
    quartus_pfg -c top.sof top.jic \
    -o device=MT25QU512 \
    -o flash_loader=A3CW135BM16AE6S \
    -o hps_path=u-boot-spl-dtb.hex \
    -o mode=ASX4 \
    -o hps=1
    ```

### Create phase 1 and phase 2 configuration bitstream for "FPGA First" Flow

Follow these steps if the `"HPS init"` property for the hps_subsystem in the `XML`
is set to `"AFTER INIT_DONE"`. You can check this property by executing the following
Quartus® command and the `"\*.sof"` file. For example:

```bash
quartus_pfg -i top.sof
```

In the log, look for the property `"HPS/FPGA configuration order"` SET TO `"AFTER INIT_DONE"`

<br>

![fpga-first](/rel-26.1/embedded-designs/agilex-5/e-series/modular-065b/drive-on-chip/common/images/fpga-first.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**FPGA First SOF file.**
</center>
<br>

**Important!** The following step depends on the output of u-boot compilation
specifically the file `u-boot-spl-dtb.hex`. To generate the `top.jic` execute:

=== "Agilex™ 5"
    For [Agilex™ 5 FPGA E-Series 065B Modular Development Kit](https://www.altera.com/products/devkit/po-3274/agilex-5-fpga-and-soc-e-series-065b-modular-development-kit)
    ```bash
    quartus_pfg -c top.sof top.jic \
    -o device=MT25QU02G \
    -o flash_loader=A5ED065BB32AE4S
    -o hps_path=u-boot-spl-dtb.hex \
    -o mode=ASX4 \
    ```
=== "Agilex™ 3"
    For [Agilex™ 3 FPGA and SoC C-Series Development Kit]
    ```bash
    quartus_pfg -c top.sof top.jic \
    -o device=MT25QU512 \
    -o flash_loader=A3CW135BM16AE6S
    -o hps_path=u-boot-spl-dtb.hex \
    -o mode=ASX4 \
    ```


<br>

[Back to User Flows](../doc-plc.md#recommended-user-flows){ .md-button }
