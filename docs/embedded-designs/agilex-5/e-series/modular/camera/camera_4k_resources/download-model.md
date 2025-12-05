### **Download and Compile the AI Models**

The Altera® FPGA AI Suite IP in the Camera with AI Inference Solution System
Example Design, is optimized to run both the ultralytics YOLOv8 nano detection
and pose inference models, switching between them at runtime. The End User must
go to ultralytics website to review and accept licensing and copyright
information, before downloading the YOLOv8 nano models. The models must then be
compiled for the FPGA AI Suite IP. This will only need to be done once:

* Visit the [ultralytics YOLO] website.
* Review and accept the licensing and copyright terms.
* Download the YOLOv8 nano detection inference model `yolov8n.pt`
* Download the YOLOv8 nano pose inference model `yolov8n-pose.pt`
* Download the [model_compiler] to your `<workspace>` directory
* Compile the models for FPGA AI Suite IP:

!!! NOTE "Note"
    The downloaded YOLOv8 nano models must be placed in the directory specified

  ```bash
  mkdir -p <workspace>
  cd <workspace>
  git clone [https://github.com/altera-fpga/agilex-ed-camera-ai] .
  cd yolo_cnn
  ```

  ```bash
  echo "Download the YOLOv8 nano inference models from ultralytics website into directory yolo_cnn"
  wget <url>
  ```

  ```bash
  mkdir -p compile
  cd compile
  echo "This step can take some time to extract Altera® FPGA AI Suite"
  cmake -G Ninja ..
  echo "This step can take some time to generate a python virtual environment"
  ninja
  cd output
  tree
  ```

  ```bash
  .
  ├── generated_arch.arch
  │   ├── yolov8n-pose_dla_m2m_compiled_640_384.bin
  │   └── yolov8n_dla_m2m_compiled_640_384.bin
  ├── yolov8n-pose_categories.txt
  └── yolov8n_categories.txt

  1 directory, 4 files
  ```

The model_compiler generates the following YOLOv8 nano inference model binaries:

* Detection `generated_arch.arch/yolov8n_dla_m2m_compiled_640_384.bin`
* Pose `generated_arch.arch/yolov8n-pose_dla_m2m_compiled_640_384.bin`

Additionally, the model_compiler generates the following category identifier files:
* Detection `yolov8n_categories.txt`
* Pose `yolov8n-pose_categories.txt`


<br/>

