## Managing Secure L3 Registers on Stratix® 10, Agilex™ and N5X®

On Stratix® 10, Agilex™ 7 and N5X® HPS there are specific peripherals which are critical for system operation which can only be accessed from software running at EL3.

The following HPS software components run at EL3 on these devices and can access Secure L3 registers:

* U-Boot SPL: initial values for the secure L3 registers are set here through the device tree 'secreg' entries. The user can customize them as needed by editing the device tree.
* Arm Trusted Firmware (ATF): Both U-Boot and Linux call the ATF SMC (Secure Monitor Call) handler to access a restricted subset of secure L3 registers needed for routine system operation.

This section presents the following:

* How to use the 'secreg' device tree entries to customize initial secure L3 registers values set by U-Boot SPL
* How to access registers from the restricted subset from U-Boot, for debug purposes.
* How to access other secure EL3 register from U-Boot, by by changing the ATF source code to add add them to the restricted subset.

### Setting Initial Values of Secure L3 Registers

The initial values for the Secure L3 registes are set from U-Boot SPL. The register values are specified in secreg entries in the U-Boot device tree file.

Refer to [u-boot-socfpga/blob/HEAD/doc/device-tree-bindings/misc/socfpga_secreg.txt](https://github.com/altera-opensource/u-boot-socfpga/blob/HEAD/doc/device-tree-bindings/misc/socfpga_secreg.txt) for documentation the **secreg**. The  socfpga_v2021.04 version shows the following:
  ```
  * Firewall and privilege register settings in device tree

  Required properties:
  --------------------
  - compatible: should contain "intel,socfpga-secreg"
  - intel,offset-settings: 32-bit offset address of block register, and then
						 followed by 32-bit value settings.
  Example:
  --------
		socfpga_secreg: socfpga-secreg {
			compatible = "intel,socfpga-secreg";
			#address-cells = <1>;
			#size-cells = <1>;
			u-boot,dm-pre-reloc;

			i_sys_mgr@ffd12000 {
				reg = <0xffd12000 0x00000228>;
				intel,offset-settings =
					<0x00000020 0xff010000>,
					<0x00000024 0xffffffff>;
				u-boot,dm-pre-reloc;
			};
		};
  ```
Notes about the example:

* The u-boot,dm-pre-reloc; statement in the example informs U-Boot the driver will be loaded in SPL.
* The i_sys_mgr@ffd12000 statement in the example is informative only to enable readers to quickly see what IP is being set up, it is not actually used by the code.
* The reg =<0xffd12000 0x00000228> entry specifies the IP module base address 0xffd12000 and span of 0x00000228 bytes.
* The <0x00000020 0xff010000>, specifies that the register at offset 0x00000020 from the IP module base address will be set to value 0xff010000.

These are the files which currently define the initial value of the Secure L3 registers:

* Common: u-boot-socfpga/arch/arm/dts/socfpga_soc64_u-boot.dtsi.
* Stratix® 10: u-boot-socfpga/arch/arm/dts/socfpga_stratix10-u-boot.dtsi.
* Agilex™ 7: arch/arm/dts/socfpga_agilex-u-boot.dtsi
* N5X®: u-boot-socfpga/arch/arm/dts/socfpga_n5x-u-boot.dtsi

You can edit the above files accordingly to change the default values, or set the initial value of more registers.

### Accessing Secure L3 Registers from U-Boot Command Line

A small subset of critical EL3 restricted access registers are made visible through the ATF SMC handler. The current list of registers is defined in [arm-trusted-firmware/blob/HEAD/plat/intel/soc/common/socfpga_sip_svc.c.](https://github.com/altera-opensource/arm-trusted-firmware/blob/HEAD/plat/intel/soc/common/socfpga_sip_svc.c).

The secure L3 registers accessible through the ATF SMC handler can also optionally be accessed from U-Boot command line for debug purposes. The feature can be enabled by setting **CONFIG_CMD_SMC=y** in the U-Boot configuration file.

Once the feature is enabled, the following command will be avaible from U-Boot command line interface:

  ```
  SOCFPGA # smc
  smc - Issue a Secure Monitor Call

  Usage:
  smc  [arg1 … arg6] [id]
    - fid Function ID
    - arg SMC arguments, passed to X1-X6 (default to zero)
    - id  Secure OS ID / Session ID, passed to W7 (defaults to zero)
  ```
The U-Boot environment already includes predefined ids to facilitate the usage of the command:
  ```
  smc_fid_rd=0xC2000007
  smc_fid_upd=0xC2000009
  smc_fid_wr=0xC2000008
  ```
The command can be used as follows:
  ```
  smc ${smc_fid_rd} <address>
  smc ${smc_fid_wr} <address> <value>
  smc ${smc_fid_upd} <address> <mask> <value>
  ```
See below using the new command to access the BOOT_SCRATCH_COLD0 register (note there is no need to access that register, this is just an example):

1.- Read the register:
  ```
  SOCFPGA_STRATIX10 # smc ${smc_fid_rd} 0xffd12200
  Res:  0 400000 4291895808 0
  ```
Note:

* First value from Res is the return code, 0 means operation succesfull.
* Second value represents the read register value in decimal 400000=0x00061a80.
* Third value is the address in decimal 4291895808=0xffd12200.

2.- Write the register with a new value:
  ```
  SOCFPGA_STRATIX10 # smc ${smc_fid_wr} 0xffd12200 0x00061a81
  Res:  0 400001 4291895808 0
  ```

3.-  Read back the register to confirm it has been updated:
  ```
  SOCFPGA_STRATIX10 # smc ${smc_fid_rd} 0xffd12200
  Res:  0 400001 4291895808 0
  ```
### Enabling Access to more Secure L3 Registers for Debug Purposes

By default, only a small subset of critical EL3 restricted access registers are made visible through the ATF SMC handler. The current list of registers is defined in [arm-trusted-firmware/blob/HEAD/plat/intel/soc/common/socfpga_sip_svc.c](https://github.com/altera-opensource/arm-trusted-firmware/blob/HEAD/plat/intel/soc/common/socfpga_sip_svc.c). For debug purposes, you can add more registers to the restricted register list that can be accessed through the ATF SMC handler.

**Warning: Changing the list of EL3 restricted access registers in ATF is risky, and must be done only for debug purposes only! Do not forget to remove the code once debugging has completed!**

When trying to access a register which is not made visible by the ATF SMC handler, an error will be reported. See below example trying to read the noc_fw_soc2fpga_soc2fpga_scr register:
  ```
  SOCFPGA_STRATIX10 # smc ${smc_fid_rd} 0xffd21200
  Res:  4 0 4291957248 0
  ```
Note:

* The non-zero (4) return code means the operation was not succesfull.

After editing the file [arm-trusted-firmware/blob/HEAD/plat/intel/soc/common/socfpga_sip_svc.c](https://github.com/altera-opensource/arm-trusted-firmware/blob/HEAD/plat/intel/soc/common/socfpga_sip_svc.c) to add this register to the list, and recompiling ATF, the operation is succesfull:

  ```
  SOCFPGA_STRATIX10 # smc ${smc_fid_rd} 0xffd21200
  Res:  0 268304641 4291957248
  ```
Note:

* Return code is zero, operation was succesfull.
* Read value is decimal 268304641=0xFFE0101.
