


[Release Tag]: https://github.com/altera-fpga/agilex-ed-robotics/releases/tag/rel-camera-26.1
[wic.gz]: https://github.com/altera-fpga/agilex-ed-robotics/releases/download/rel-camera-26.1/core-image-minimal-agilex5_mk_a5e065bb32aea.rootfs.wic.gz
[wic.bmap]: https://github.com/altera-fpga/agilex-ed-robotics/releases/download/rel-camera-26.1/core-image-minimal-agilex5_mk_a5e065bb32aea.rootfs.wic.bmap
[top.hps.jic]: https://github.com/altera-fpga/agilex-ed-robotics/releases/download/rel-camera-26.1/top.hps.jic
[top.core.rbf]: https://github.com/altera-fpga/agilex-ed-robotics/releases/download/rel-camera-26.1/top.core.rbf
[u-boot-spl-dtb.hex]: https://github.com/altera-fpga/agilex-ed-robotics/releases/download/rel-camera-26.1/u-boot-spl-dtb.hex
[ROBOTICS_ISP_CAMERA.qar]: https://github.com/altera-fpga/agilex-ed-robotics/releases/download/rel-camera-26.1/ROBOTICS_ISP_CAMERA.qar
[top.sof]: https://github.com/altera-fpga/agilex-ed-robotics/releases/download/rel-camera-26.1/top.sof

[HPS_ISP_CAM_ROBOTICS]: https://github.com/altera-fpga/agilex-ed-robotics/tree/rel/26.1/HPS_ISP_CAM_ROBOTICS
[AGX_5E_Modular_Devkit_HPS_ISP_CAM_ROB.xml]: https://github.com/altera-fpga/agilex-ed-robotics/blob/rel/26.1/HPS_ISP_CAM_ROBOTICS/AGX_5E_Modular_Devkit_HPS_ISP_CAM_ROB.xml
[Creating and Building the Design based on Modular Design Toolkit (MDT).]: https://github.com/altera-fpga/agilex-ed-robotics/blob/rel/26.1/HPS_ISP_CAM_ROBOTICS/Readme.md
[Create SD card image (.wic) using YOCTO/KAS]: https://github.com/altera-fpga/agilex-ed-robotics/blob/rel/26.1/sw/README.md
[kas-camera.yml]: https://github.com/altera-fpga/agilex-ed-robotics/blob/rel/26.1/sw/kas-camera.yml

[robotics_camera package]: https://github.com/altera-fpga/altera-ros2


# Robotics Camera System Example Design — Software Functional Description

## Linux image

The Yocto/KAS configuration for this design is in [agilex-ed-robotics/sw](https://github.com/altera-fpga/agilex-ed-robotics/tree/rel/26.1/sw). Build with:

```bash
cd <workspace>/agilex-ed-robotics/sw
KAS_MACHINE=agilex5_mk_a5e065bb32aea kas build kas-camera.yml
```

The resulting `.wic.gz` image is written to the SD card. The FPGA bitstream is included in the Linux image and loaded by the first-stage bootloader on boot.

## Machine name

Use **`KAS_MACHINE=agilex5_mk_a5e065bb32aea`** for the Agilex™ 5 E-Series 065B Modular Development Kit (part number A5ED065BB32AE4S).

## Custom bitstream

To use a locally built `top.core.rbf`, follow the instructions in [Create SD card image (.wic) using YOCTO/KAS](https://github.com/altera-fpga/agilex-ed-robotics/blob/rel/26.1/sw/README.md) for `FPGA_BST_SRC_URI` in [kas-camera.yml](https://github.com/altera-fpga/agilex-ed-robotics/blob/rel/26.1/sw/kas-camera.yml).

<br>
