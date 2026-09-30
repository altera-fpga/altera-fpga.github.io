### **Copying the Compiled AI Models to the microSD Card**

The compiled models must be copied onto the microSD card for the Application
Software to use at runtime:

* `scp` and `ssh` the compiled models directly to the Development Kit (using its
  `<ip address>`):
  * Power up the Modular Development Kit (if not already powered) and set up the
    serial terminal emulator (minicom, [TeraTerm], [PuTTY], etc.):
    * Select the correct `COMx` port. (The Modular Development Kit presents 4
      serial COM ports over a single connection and the Linux system uses the 3rd
      port in order). Set the port configuration as follows:
      * 115200 baud rate, 8 Data bits, 1 Stop bit, CRC and Hardware flow control
        disabled.
    * The Linux OS will boot.
    * Take note of the Modular Development Kit IP address.
      * The IP address can also be found using the terminal by logging in as `root`
      (no password required) and querying the Ethernet controller:

      ```bash
      root
      ifconfig
      ```

      * `eth0` provides the IPv4 or IPv6 address to connect to.
 
  * Using a Linux terminal (or Windows equivalent like PowerShell) on your Host,
    copy the files from the output directory to the Development Kit:

    ```bash
    cd compile/output
    scp -r * root@<ip address>:
    ```
  * Ensure sdcard has stored the files
    ```bash
    ssh root@<ip address>
    sync
    ls *_categories.txt *.arch
    ```
    Outputs:
    ```bash
    yolov8n-pose_categories.txt yolov8n_categories.txt

    generated_arch.arch:
    yolov8n-pose_dla_m2m_compiled_640_384.bin yolov8n_dla_m2m_compiled_640_384.bin
    ```
  * The Development Kit can be powered down, and restarted to load the models.


<br/>

