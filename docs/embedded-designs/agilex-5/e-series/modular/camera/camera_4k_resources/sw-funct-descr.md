# ${{ env_local.CAMERA_4K_TITLE }} - Software Functional Description

## Overview

The primary software components are summarized in the following diagram and
described below:
<br/>
<br/>

![top-swm.](../camera_4k_resources/images/SW/VVP_ISP_SW_Top_level.png){:style="display:block; margin-left:auto; margin-right:auto; width: 60%"}
<center markdown="1">

**Software Top Block Diagram**
</center>
<br/>

Summary:

* A Software application running on an embedded Linux system.
* The application provides Web based UI to control the video pipeline and
${{ env_local.CAMERA_4K_NO_AI }}
  individual ISP IP.
${{ env_local.CAMERA_4K_END_NO_AI }}
${{ env_local.CAMERA_4K_AI }}
  individual ISP IP, and the AI Inference.
${{ env_local.CAMERA_4K_END_AI }}
* User accesses Web UI from a remote PC or tablet over the network with a Web
browser e.g. Chrome.
* Linux system includes necessary drivers allowing the software application to
access and control FPGA using register read/write interface.


## Custom Linux distribution based on KAS

For the Camera Solution System Example Design, Altera® provides the files to
build the Linux system to run the demo application. A custom version of Linux
is built based on [KAS](https://kas.readthedocs.io/en/latest/) (setup tool for Yocto projects, see [KAS](https://kas.readthedocs.io/en/latest/)) and is
composed of the following meta-layers:

* Altera® FPGA Layer - **[meta-altera-fpga]**
* Altera® FPGA OCS (Offset Capability Structure) Layer - **[meta-altera-fpga-ocs]**
* Camera Layer - **[meta-vvp-isp-demo]**



${{ env_local.CAMERA_4K_NO_AI }}
!!! note "KAS Reference"
    [agilex-ed-camera/sw]
${{ env_local.CAMERA_4K_END_NO_AI }}
${{ env_local.CAMERA_4K_AI }}
!!! note "KAS Reference"
    [agilex-ed-camera-ai/sw]
${{ env_local.CAMERA_4K_END_AI }}


### Necessary elements in the meta-layers to bind Software and Hardware

This section details the various elements included in the meta-layers that
facilitate running the camera application. These elements assist in "binding"
the FPGA Soft IP with the Linux software running on the HPS. The following
sections explain these elements to clarify the interaction between the HPS
software stack and the FPGA soft IP. This interaction between the HPS and
Camera IP serves as an example of how to interface any soft IP in the FPGA
fabric with higher-level software.


#### Device Tree

Adds a custom .dtsi (device tree fragment) file to the main device tree for
Linux kernel boot up stage `socfpga_agilex5_socdk.dts`. it compiles into a DTB
(device tree blob) during kernel compilation and is added to the microSD card
image during the Yocto build with the recipe `device-tree.bb`. The specific
file for this design example (`agilex5_vvp-isp-demo.dtsi`), is appended using
`device-tree.bbappend` directive. Look for these files in the different
meta-layers provided.
<br/>

#### FPGA Bitstream

Adds the `agilex5_modkit_vvpisp.hps_first.core.rbf` file to the build. The file
is generated after Quartus® compilation. The `*core.rbf` file is added to the
boot partition of the microSD card (renamed as `top.core.rbf`). The HPS
configures the FPGA at initialization using u-boot `load` command in
`uboot.txt` generated into `boot.scr.uimg` in the boot partition by 
`u-boot-socfpga_%.bbappend` (look for the files in the meta-layer).
<br/>

``` #5
Found U-Boot script /boot.scr.uimg
1711 bytes read in 12 ms (138.7 KiB/s)
## Executing script at 81000000
crc32+ 12038144 bytes read in 627 ms (18.3 MiB/s)
............FPGA reconfiguration OK!
47645184 bytes read in 2435 ms (18.7 MiB/s)
42988 bytes read in 17 ms (2.4 MiB/s)
## Flattened Device Tree blob at 86000000
   Booting using the fdt blob at 0x86000000
Working FDT set to 86000000
   Loading Device Tree to 00000000feae5000, end 00000000feaf27eb ... OK
Working FDT set to feae5000

Starting kernel ...
```
<center markdown="1">

**FPGA configuration during HPS booting process**
</center>
<br/>

Look for the message **"..... FPGA reconfiguration OK "** during the device booting
process, as shown in the previous figure to ensure the FPGA bitstream (`top.core.rbf`)
has been properly loaded.


#### Additional u-boot configuration

Append to the u-boot arguments using `IMAGE_BOOT_ARGS` and
`IMAGE_BOOT_ARGS:append:agilex5_modular` in different KAS/YOCTO configuration
files to enable UIO drivers defined by `uio_pdrv_genirq.of_id=generic-uio`.
<br/>


## Using a Static IP Address

Linux on the microSD card obtains an IP address automatically via DHCP if the
Ethernet network has a DHCP server. Alternatively, you may configure the
network with a static IP address by editing the following file via the terminal
interface:
<br/>

```
/etc/systemd/network/11-eth.network
```

Find the following lines in the file:
```
[Network]
DHCP=yes
```

Replace the lines with the following content:
```
[Network]
DHCP=no
Gateway=192.168.1.1
Address=192.168.1.123/24
```

Use the gateway and the static IP address as appropriate for your network. Save
the file and reboot the board.
<br/>

<br/>
[Back](${{ env_local.CAMERA_4K_TOP_MD }}#documentation){ .md-button }
<br/>



[Agilex™ 5 E-Series Modular Development Board GSRD User Guide (25.1)]: https://altera-fpga.github.io/rel-25.1/embedded-designs/agilex-5/e-series/modular/gsrd/ug-gsrd-agx5e-modular/



[Hard Processor System Technical Reference Manual: Agilex™ 5 SoCs (25.1)]: https://www.intel.com/content/www/us/en/docs/programmable/814346/25-1/hard-processor-system-technical-reference.html
[NiosV Processor for Altera® FPGA]: https://www.altera.com/design/guidance/nios-v-developer
[Agilex™ 5 FPGA E-Series 065B Modular Development Kit]: https://www.altera.com/products/devkit/a1jui0000061qabmaa/agilex-5-fpga-and-soc-e-series-modular-development-kit-es
[Agilex™ 5 FPGA E-Series 065B Modular Development Kit Product Brief]: https://www.intel.com/content/www/us/en/content-details/815178/agilex-5-fpga-e-series-065b-modular-development-kit-product-brief.html
[Altera® FPGA AI Suite]: https://www.altera.com/products/development-tools/fpga-ai-suite


[Win32DiskImager]: https://sourceforge.net/projects/win32diskimager
[7-Zip]: https://www.7-zip.org
[TeraTerm]: https://github.com/TeraTermProject/teraterm/releases
[PuTTY]: https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html


[Framos FSM:GO IMX678C Camera Modules]: https://www.framos.com/en/fsmgo
[Wide 110deg HFOV Lens]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FSMGO-IMX678C-M12-L110A-PM-A1Q1?qs=%252BHhoWzUJg4KQkNyKsCEDHw%3D%3D
[Medium 100deg HFOV Lens]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FSMGO-IMX678C-M12-L100A-PM-A1Q1?qs=%252BHhoWzUJg4IesSwD2ACIBQ%3D%3D
[Narrow 54deg HFOV Lens]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FSMGO-IMX678C-M12-L54A-PM-A1Q1?qs=%252BHhoWzUJg4L5yHZulKgVGA%3D%3D
[Framos Tripod Mount Adapter]: https://www.framos.com/en/products/fma-mnt-trp1-4-v1c-26333
[Tripod]: https://thepihut.com/products/small-tripod-for-raspberry-pi-hq-camera
[150mm flex-cable]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FMA-FC-150-60-V1A?qs=GedFDFLaBXGCmWApKt5QIQ%3D%3D&_gl=1*d93qim*_ga*MTkyOTE4MjMxNy4xNzQxMTcwMzQy*_ga_15W4STQT4T*MTc0MTE3MDM0Mi4xLjEuMTc0MTE3MDQ5OS40NS4wLjA
[300mm micro-coax cable]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FFA-MC50-Kit-0.3m?qs=%252BHhoWzUJg4K3LtaE207mhw%3D%3D
[DP to HDMI Adapter]: https://www.amazon.co.uk/gp/product/B01M6WK3KU/ref=ppx_yo_dt_b_asin_title_o02_s00?ie=UTF8&psc=1
[Framos GMSL3 5m]: https://www.mouser.co.uk/ProductDetail/FRAMOS/FFA-GMSL3-Kit-5m?qs=%252BHhoWzUJg4IkLHv%2F6fzsXQ%3D%3D
[Framos FFA-GMSL-SER-V2A Serializer]: https://www.framos.com/en/products/ffa-gmsl-ser-v2a-27617
[Framos FFA-GMSL-DES-V2A Deserializer]: https://www.framos.com/en/products/ffa-gmsl-des-v2a-27240


[VVP IP Suite]: https://www.altera.com/products/ip/a1jui000004qxfpmak/video-and-vision-processing-suite
[MIPI DPHY IP and MIPI CSI-2 IP]: https://www.altera.com/products/ip/a1jui0000049uuamam/mipi-d-phy-ip#tab-blade-1-3
[Nios® V Processor]: https://www.altera.com/products/ip/a1jui0000049uvama2/nios-v-processors


[Altera® Quartus® Prime Pro Edition version 25.1 Linux]: https://www.intel.com/content/www/us/en/software-kit/851652/intel-quartus-prime-pro-edition-design-software-version-25-1-for-linux.html
[Altera® Quartus® Prime Pro Edition version 25.1 Windows]: https://www.intel.com/content/www/us/en/software-kit/851653/intel-quartus-prime-pro-edition-design-software-version-25-1-for-windows.html
[Altera® Quartus® Prime Pro Edition version 25.1 Programmer and Tools]: https://www.intel.com/content/www/us/en/software-kit/851652/intel-quartus-prime-pro-edition-design-software-version-25-1-for-linux.html


[ultralytics YOLO]: https://docs.ultralytics.com
[ONNX]: https://onnx.ai/
[OpenVINO Toolkit]: https://storage.openvinotoolkit.org/repositories/openvino/packages/2024.6/linux



[Test Pattern Generator IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/test-pattern-generator.html
[Switch IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/switch.html
[Black Level Statistics IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/black-level-statistics.html
[Clipper IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/clipper.html
[Defective Pixel Correction IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/defective-pixel-correction.html
[Adaptive Noise Reduction IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/adaptive-noise-reduction.html
[Black Level Correction IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/black-level-correction.html
[Vignette Correction IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/vignette-correction.html
[White Balance Statistics IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/white-balance-statistics.html
[White Balance Correction IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/white-balance-correction.html
[Demosaic IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/demosaic.html
[Histogram Statistics IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/histogram-statistics.html
[Color Space Converter IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/color-space-converter.html
[1D LUT]: https://www.altera.com/products/ip/a1jui000004r4gnmas/1d-lut-altera-fpga-ip
[1D LUT IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/1d-lut.html
[3D LUT]: https://www.altera.com/products/ip/a1jui000004r4gnmas/3d-lut-altera-fpga-ip
[3D LUT IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/3d-lut.html
[LUTCalc GitHub page]: https://github.com/cameramanben/LUTCalc
[Tone Mapping Operator]: https://www.altera.com/products/ip/a1jui000004r0hlmak/tone-mapping-operator-fpga-ip
[Tone Mapping Operator IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/tone-mapping-operator.html
[Unsharp Mask IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/unsharp-mask.html
[Warp]: https://www.altera.com/products/ip/a1jui000004rhk1mag/warp-fpga-ip
[Warp IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/warp.html
[Mixer IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/mixer.html
[Video Frame Writer IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/video-frame-writer-intel-fpga-ip.html
[Video Frame Reader IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/video-frame-reader-intel-fpga-ip.html
[Color Plane Manager IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/color-plane-manager.html
[Bits per Color Sample Adapter IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/bits-per-color-sample-adapter.html
[Protocol Converter IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/protocol-converter.html
[Pixels in Parallel Converter IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/pixels-in-parallel-converter.html
[Video and Vision Processing Suite Altera® FPGA IP User Guide]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/about-the-video-and-vision-processing-suite.html
[Altera® FPGA Streaming Video Protocol Specification]: https://www.intel.com/content/www/us/en/docs/programmable/683397/current/about-the-intel-fpga-streaming-video.html
[AMBA 4 AXI4-Stream Protocol Specification]: https://developer.arm.com/documentation/ihi0051/a/
[Avalon® Interface Specifications – Avalon® Streaming Interfaces]: https://www.intel.com/content/www/us/en/docs/programmable/683091/20-1/streaming-interfaces.html
[KAS]: https://kas.readthedocs.io/en/latest/
[EMIF]: https://www.altera.com/design/guidance/emif-support
[Scaler IP]: https://www.intel.com/content/www/us/en/docs/programmable/683329/25-1/scaler.html
[MSGDMA IP]: https://www.intel.com/content/www/us/en/docs/programmable/683130/25-1-1/modular-scatter-gather-dma-core.html

