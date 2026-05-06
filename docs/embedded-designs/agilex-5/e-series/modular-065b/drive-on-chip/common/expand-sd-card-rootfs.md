### **Expand the SD card Root File System Partition.**

The Root File System partition (`root`, Ext4) may require resizing to
accommodate larger files, such as example design applications. Users can select
their preferred tool to perform this task; however, the following steps
provide instructions using the `Disks` utility (based on `e2fsprogs`):

* Insert the SD card image in the Linux machine that has the `Disks` utility
  installed. You should be able to see the available storage devices.
* Select the `root` partition of the SD card and click the "gear" icon as shown in the
  figure below to display the menu. Navigate to `Resize...`

![disk-imager](./common/images/sd-root-part.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**Select the "root" partition for resizing.**
</center>

* Use the slider to increment the partition storage capacity (the maximum is
  recommended). Then, click the `Resize` button.

![disk-imager](./common/images/sd-root-resize.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**Resize the root partition to the maximum.**
</center>

* Eject the disk safely.
<br>
