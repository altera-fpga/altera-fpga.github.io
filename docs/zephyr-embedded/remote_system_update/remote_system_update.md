# Remote OS update for Hard Processor System 

**Upstream Status**: [Upstreamed](https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/+/refs/heads/master/plat/intel/soc/common/socfpga_ros.c)

**Devices supported**: Agilex 5

## **Introduction**

Remote OS update is an optional companion feature along with Remote system update. Usually, we want to keep a 1:1 map of all the components in a stack during a device update. But RSU only updates the fabric and the First stage boot loader. So, to provide customer option to update the Secondary stage boot loader (SSBL)/OS image ROS will use RSU meta data to select the appropriate SSBL/OS during an RSU boot.
For more info: [Using multiple SSBLs with qspi](https://www.intel.com/content/www/us/en/docs/programmable/683021/21-4/using-multiple-ssbls-with-qspi-s10-fm.html)

## **Driver Sources**

The ATF source code for this driver can be found at : [https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/+/refs/heads/master/plat/intel/soc/common/socfpga_ros.c](https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/+/refs/heads/master/plat/intel/soc/common/socfpga_ros.c)

## **Sub System Capabilities**

* Uses RSU framework to provide a mechanism to update the SSBL/OS image on RSU-based booting.
* Currently implemented for QSPI boot of Zephyr.


## **Kernel Configurations**
None
## **Device Tree**

None

## **Known Issues**

None known
