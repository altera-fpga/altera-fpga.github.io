

# 4Kp30 Multi-Sensor Camera with AI Inference Solution System Example Design for Agilex™ 5 Devices - Features

* Inputs:
  * Two MIPI D-PHY interfaces connected to two Framos FSM:GO IMX678 color
  camera modules with Sony Starvis2 8MP IMX678 sensor and Framos PixelMate MIPI
  CSI-2 interface.
  * Optional Framos GMSL3 5m Link extender 
  * Internal frontend Test Pattern Generator (TPG) supporting color bars
  and solid colors.

* Input selection switch

* Frontend video pipeline (CFA image):
  * Clipper IP.
  * ISP IP: Black Level Statistics (BLS), Defective Pixel Correction (DPC),
  Adaptive Noise Reduction (ANR), Black Level Correction (BLC), Vignette
  Correction (VC), White Balance Statistics (WBS), White Balance Correction
  (WBC), and Demosaic (DMS).

* AI inference engine:
  * Supports YOLOv8 nano detection and pose inference models.
  * 640x384 size input images with high accuracy and fast 30FPS inference rate.
  * Inference result overlay.
  
* Backend video pipeline (RGB image):
  * Histogram Statistics (HS) IP.
  * 3D LUT IP.
  * Tone Mapping Operator (TMO) IP.
  * Un-Sharp Mask (USM) IP.
  * Mixer IP:
    * TPG for uniform background (also supports color bars).
    * ISP Output overlay.
    * AI Inference Result overlay.
    * Logo overlay.
  * 1D LUT IP – for OETF operations such as Gamma, HLG, and PQ.

* Up to 4Kp30 10-bit Multi-rate DisplayPort output:
  * Selects best resolution and color depth supported by the connected Monitor. Supported modes:
    * 720p30, 1080p30, 4Kp30, 8-bit and 10-bit color depth.

* Video frame capture (3 color plane 16-bit color depth, 48-bit lossless TIFF image):
  * Sensor Raw Output (Grayscale RGB).
  * ISP Output (RGB).

!!! note "Grayscale RGB"

    The single color plane of the sensor CFA image is copied into all 3 color planes on a per-pixel basis to produce an RGB image.


* Software stack running on HPS (quad-core ARM Cortex CPU):
  * Based on Poky Linux with additional Yocto layers supporting Altera® FPGAs.
  * Uses the Yocto build system.

<br>

<br>
[Back](../camera_4k_ai/camera_4k_ai.md#documentation){ .md-button }
<br>




[User flow 1]: ../camera_4k_ai/camera_4k_ai.md#pre-requisites
[User flow 2]: ../camera_4k_ai/flow2-sof-mdt.md
[User flow 3]: ../camera_4k_ai/flow3-rbf-mdt.md



[https://github.com/altera-fpga/agilex-ed-camera-ai]: https://github.com/altera-fpga/agilex-ed-camera-ai
[https://github.com/altera-fpga/modular-design-toolkit]: https://github.com/altera-fpga/modular-design-toolkit
[meta-altera-fpga]: https://github.com/altera-fpga/agilex-ed-camera-ai/tree/rel-25.1/sw/meta-altera-fpga
[meta-altera-fpga-ocs]: https://github.com/altera-fpga/agilex-ed-camera-ai/tree/rel-25.1/sw/meta-altera-fpga-ocs
[meta-vvp-isp-demo]: https://github.com/altera-fpga/agilex-ed-camera-ai/tree/rel-25.1/sw/meta-vvp-isp-demo
[agilex-ed-camera-ai/sw]: https://github.com/altera-fpga/agilex-ed-camera-ai/tree/rel-25.1/sw



[Release Tag]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/tag/rel-25.1
[https://github.com/altera-fpga/agilex-ed-camera-ai/releases/tag/rel-25.1]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/tag/rel-25.1
[hps-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/download/rel-25.1/hps-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz
[fpga-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/download/rel-25.1/fpga-first-vvp-isp-demo-image-agilex5_mk_a5e065bb32aes1.wic.gz
[fsbl_agilex5_modkit_vvpisp_time_limited.sof]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/download/rel-25.1/fsbl_agilex5_modkit_vvpisp_time_limited.sof
[top.core.jic]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/download/rel-25.1/top.core.jic
[top.core.rbf]: https://github.com/altera-fpga/agilex-ed-camera-ai/releases/download/rel-25.1/top.core.rbf
[model_compiler]: https://github.com/altera-fpga/agilex-ed-camera-ai/tree/rel-25.1/yolo_cnn



[AGX_5E_Modular_Devkit_ISP_AI_FF_RD.xml]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/AGX_5E_Altera_Modular_Dk_ISP_designs/AGX_5E_Modular_Devkit_ISP_AI_FF_RD.xml
[AGX_5E_Modular_Devkit_ISP_AI_RD.xml]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/AGX_5E_Altera_Modular_Dk_ISP_designs/AGX_5E_Modular_Devkit_ISP_AI_RD.xml
[Create microSD card image (.wic.gz) using YOCTO/KAS]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/sw/README.md
[<g>&check;</g><span hidden="true"> YOCTO/KAS </span>]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/sw/README.md

[SOF Modular Design Toolkit (MDT) Flow]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt
[RBF Modular Design Toolkit (MDT) Flow]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt
[<g>&check;</g><span hidden="true"> SOF MDT Flow </span>]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt
[<g>&check;</g><span hidden="true"> RBF MDT Flow </span>]: https://github.com/altera-fpga/agilex-ed-camera-ai/blob/rel-25.1/README.md#create-the-design-using-the-modular-design-toolkit-mdt




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


<br>
