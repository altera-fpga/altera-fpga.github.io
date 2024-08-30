## Using Separate SSBL Per Bitstream Example

When using Remote System Update on Stratix 10, Agilex 7, Agilex 5 and N5X devices, each configuration bitstream from QSPI contains the HPS FSBL (First Stage Bootloader), specifically U-Boot SPL. In order to allow the most flexibility and compatibility, you must design your system so that each bitstream loads its own copy of the HPS SSBL, specifically U-Boot image.

This page presents details on how to achieve this for both the cases when U-Boot images are stored in QSPI flash, and when they are stored in SD card. 

Refer to the following documents for details about the Remote System Update.

* [Stratix® 10 Hard Processor System Remote System Update User Guide](https://www.intel.com/content/www/us/en/docs/programmable/683021/current/overview-s10-fm.html)
* [Agilex™ Hard Processor System Remote System Update User Guide](https://www.intel.com/content/www/us/en/docs/programmable/683184/current/overview-s10-fm.html) 

**Note:** In the scenario in which both SPTs tables are corrupted, U-Boot will fail to be launched because the FSBL won't be able to identify which SSBL needs to be launched since the partition information is kept in SPT tables.

### Configuring U-Boot for Separate U-Boot Images

In order to configure U-Boot to support one U-Boot image per bitstream, the following configuration option must be enabled.

```bash
CONFIG_SOCFPGA_RSU_MULTIBOOT=y
```

This configuration option is defined in https://github.com/altera-opensource/u-boot-socfpga/blob/socfpga_v2023.04/arch/arm/mach-socfpga/Kconfig as follows.

```bash
config SOCFPGA_RSU_MULTIBOOT
	bool "Enable RSU Multiboot Selection Feature"
	depends on TARGET_SOCFPGA_SOC64 && SPI_FLASH
	default n
	help
	 Multiboot u-boot proper image (SSBL) selection feature for RSU.
	 SPL will select the respective SSBL based on the partition it resides
	 inside RSU QSPI flash layout.
```

### Storing U-Boot Images on SD Card

When booting U-Boot from SD card, the effects of enabling **CONFIG_SOCFPGA_RSU_MULTIBOOT=y** are these.

* Instead of SPL loading the **u-boot.itb** or **u-boot.img** image, it loads the **u-boot_&lt;partition_name&gt;.itb** or **u-boot_&lt;partition_name&gt;.img** file.
* Instead of U-Boot using the environment stored in one location on SD card, it loads it from **uboot_&lt;partition_name&gt;.env** file

The **&lt;partition_name&gt;** is the partition name as defined in the Quartus Programming File Generator PFG file (using the **id** for the corresponding partition). For the factory image that is "**FACTORY_IMAGE**".

On the SD card, the following files will need to be stored, for each bitstream and the factory image.

* **u-boot_&lt;partition_name&gt;.itb** or **u-boot_&lt;partition_name&gt;.img** 
* **uboot_&lt;partition_name&gt;.env** 

Application image update procedure needs to be updated as follows.

1. Use LIBRSU or U-Boot to erase the application image partition. This also disables it, removing it from the CPB.
2. Replace the corresponding U-Boot image file on the FAT partition with the new version.
3. Replace the corresponding U-Boot environment file on the FAT partition with the new version
4. Use LIBRSU or U-Boot to write the new application image. This also enables it, putting it as the highest priority in the CPB.

**Notes:**

* If you do not need to have a modifiable environment, you will not need the **uboot_&lt;partition_name&gt;.env** files.
* You can ommit explicitly creating the **uboot_&lt;partition_name&gt;.env**  files. They will be created when  you run the **'saveenv'** command. If they are not present U-Boot will just use its default environment.

**Steps to Rebuild Binaries compared with regular RSU build flow**

1. GHRD, ATF, Linux, File System are built in the same way.
2. U-Boot is build adding **CONFIG_SOCFPGA_RSU_MULTIBOOT=y** to the **config-fragment-&lt;device&gt;** file. An independent U-Boot build is performed for each application. Name corresponding **u-boot.itb** as **u-boot_FACTORY_IMAGE.itb**, **u-boot_P1.itb**, **u-boot_P2.itb** and **u-boot_P3.itb**.
3. Modify **initial_image.pfg** to include the proper new FSBLs for Bitstream 1 (FACTORY_IMAGE application) and Bitstream 2 (P1 application). 
4. Generate the new **initial_image.jic** using the modified **initial_image.pfg** file.
5. Generate new *.rpd* applications using the new FSBLs created (application2, decision_firmware_update, factory_update and combined_application).
6. Generate the SD Card image copying to the **fat** partition the new **.itb** and **.rpd** files created. Also copy the new **.rpd** files to the **rootfs** partition at **home/root** directory. Adjust the size of the image to match the new size of the **fat** directory (**fat** partition will be larger as this includes now the SSBLs for each application).

### Storing U-Boot Images in QSPI 

When booting U-Boot from QSPI, the effects of enabling **CONFIG_SOCFPGA_RSU_MULTIBOOT=y** are these.

* Instead of SPL loading the U-Boot from a fixed address as defined by the **CONFIG_SYS_SPI_U_BOOT_OFFS** configuration option, it loads U-Boot from a partition called **SSBL.&lt;partition_name&gt;**.
* Instead of U-Boot loading the environment from a fixed location as defined by the **CONFIG_ENV_OFFSET** configuration option, it loads it from the last **CONFIG_ENV_SIZE** of the same partition called **SSBL.&lt;partition_name&gt;**.

On the QSPI PFG file, the following additional partition will need to be defined, for each bitstream and the factory image.

* **SSBL.&lt;partition_name&gt;**: containing the U-Boot image, and the environment at the end.

Application image update procedure needs to be updated as follows.

1. Use LIBRSU or U-Boot to erase the application image partition. This also disables it, removing it from the CPB.
2. Use LIBRSU or U-Boot to erase SSBL partition.
3. Use LIBRSU or U-Boot to write the new contents of the SSBL partition.
4. Use LIBRSU or U-Boot to write the new application image. This also enables it, putting it as highest priority in the CPB.

**Notes:**

* The total lenght of a partition name cannot exceed 15 characters, not including the zero line terminator. Because of that the SSBL partition names will have to be truncated to 15 characters. For example for factory image you will need to define it as "SSBL.FACTORY_IM".
* By default both U-Boot and Linux uses 64KB QSPI erase sectors. Make sure to configure your initial RSU QSPI flash image with SPT/CPB sizes=64KB, unless you change the default to 4KB for example, in which case you can leave the default of 32KB for SPT/CBP sizes
* The U-Boot environment must be stored in an individually erasable QSPI area. You need to define CONFIG_ENV_OFFSET=CONFIG_ENV_SECT_SIZE=qspi_erase_size, where that is either 64KB or 4KB depending on the above selection
* The partition will have to be large enough to contain both the U-Boot image (currently ~900KB) and the U-Boot environment (64KB or 4KB). It is reccomended it to set to at least 1.5MB to allow room for expansion in the future.
* Initially the environment part of the partition can be left empty, as the default U-Boot environment will be used by U-Boot. Then when you run 'saveenv' command, the updated environment will be saved and used.

**Steps to Rebuild Binaries compared with regular RSU build flow**

1. GHRD, ATF, Linux, File System are built in the same way.
2. U-Boot is build adding the following setting to the **config-fragment-&lt;device&gt;** file.
```bash
CONFIG_SOCFPGA_RSU_MULTIBOOT=y
CONFIG_ENV_OFFSET=0x10000
CONFIG_ENV_SECT_SIZE=0x10000
```
and updating **arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi** file to find the U-Boot FSBL in QSPI as indicated next.
```bash
sed -i 's/u-boot,spl-boot-order.*/u-boot\,spl-boot-order = \&flash0;/g' arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
```
For each application, a specific U-Boot is required to be built. Name corresponding **u-boot.itb** as **u-boot_FACTORY_IMAGE.bin**, **u-boot_P1.bin**, **u-boot_P2.bin** and **u-boot_P3.bin**.

3. Modify **initial_image.pfg** to create new partitions for each one of the SSBLs and loading the corresponding binary into this. An example of the new sections created in the file is shown next.
```bash
<pfg version="1">
   :
    <raw_files>
       <raw_file bitswap="1" type="RBF" id="Raw_File_1">u-boot_FACTORY_IMAGE.bin</raw_file>
       <raw_file bitswap="1" type="RBF" id="Raw_File_2">u-boot_P1.bin </raw_file>
       <raw_file bitswap="1" type="RBF" id="Raw_File_3">u-boot_P2.bin </raw_file>
       <raw_file bitswap="1" type="RBF" id="Raw_File_4">u-boot_P3.bin</raw_file>
    </raw_files>
    <flash_devices>
     :
       <partition reserved="0" fixed_s_addr="0" s_addr="0x04000000" e_addr="0x041FFFFF" fixed_e_addr="0" id="SSBL.FACTORY_IM" size="0"/>
       <partition reserved="0" fixed_s_addr="0" s_addr="0x04200000" e_addr="0x043FFFFF" fixed_e_addr="0" id="SSBL.P1" size="0"/>
       <partition reserved="0" fixed_s_addr="0" s_addr="0x04400000" e_addr="0x045FFFFF" fixed_e_addr="0" id="SSBL.P2" size="0"/>
       <partition reserved="0" fixed_s_addr="0" s_addr="0x04600000" e_addr="0x047FFFFF" fixed_e_addr="0" id="SSBL.P3" size="0"/>
    </flash_device>
    <assignments>
       <assignment partition_id="SSBL.FACTORY_IM">
             <raw_file_id>Raw_File_1 </raw_file_id>
       </assignment>
       <assignment partition_id="SSBL.P1">
             <raw_file_id>Raw_File_2 </raw_file_id>
       </assignment>
       <assignment partition_id="SSBL.P2">
             <raw_file_id>Raw_File_3 </raw_file_id>
       </assignment>
       <assignment partition_id="SSBL.P3">
             <raw_file_id>Raw_File_4 </raw_file_id>
       </assignment>
    </assignments>
 </pfg>
```

4. Generate the new **initial_image.jic** using the modified **initial_image.pfg** file.
5. Generate new **.rpd** applications using the new FSBLs created (application2, decision_firmware_update, factory_update and combined_application). 
6. Generate the SD Card image copying to the **fat** partition the new **.rpd** files created. The **.itb** in **fat** partition are not required anymore. Also, copy the new **.rpd** files to the **rootfs** partition at **home/root** directory.
