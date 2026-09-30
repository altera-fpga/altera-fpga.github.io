### **Demonstrations**

The following examples applications are available to demonstrate the ${{ env_local.HSB_MIPI_10GBE_TITLE }}.

#### Set up host system
Set up the NVIDIA host system as per [instructions](hsb-mipi-1-10GbE.md#board-and-nvidia-host-system-setup).

#### Build the Demo Docker Container
Build the holoscan sensor bridge demonstration container. For systems with dGPU or DGX Spark,

```
cd <holoscan sensor bridge>
sh docker/build.sh --dgpu
```

For systems with iGPU,
```
cd <holoscan sensor bridge>
sh docker/build.sh --igpu
```

#### To run a demo application, start the demo container
```
cd <holoscan sensor bridge>
sh docker/demo.sh
```

#### From within the Demo container run one of the following demos:
  * Simple Playback Example
```
python examples/linux_agx5_player.py
```
* YOLOv8 Body Pose Example

[Follow instructions to download YOLOv8 ONNX Model](https://docs.nvidia.com/holoscan/sensor-bridge/latest/examples.html#running-the-imx274-body-pose-example)
```
python examples/linux_body_pose_estimation_agx5.py
```

* TAO PeopleNet Example

[Follow instructions to download tao peoplenet model](https://docs.nvidia.com/holoscan/sensor-bridge/latest/examples.html#running-the-imx274-tao-peoplenet-example)
```
python examples/linux_tao_peoplenet_agx5.py
```
