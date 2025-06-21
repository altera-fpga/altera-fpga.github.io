## Creating the QSPI Flash and SD card configuration bitstreams for the board

### Create phase 1 and phase 2 configuration bitstreams for "HPS First" Flow

Follow these steps if the "HPS init" property for the `hps_subsystem` in the `XML`
is set to `"HPS FIRST"`. You can check this property by executing the following
Quartus® command and the `"\*.sof"` file. For example:

``` bash
quartus_pfg -i top.sof
```

In the log, look for the property `"HPS/FPGA configuration order"` SET TO `"HPS_FIRST"`

<br>

![hps-first](/rel-25.1/embedded-designs/agilex-5/e-series/modular/drive-on-chip/common/images/hps-first.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**HPS First SOF file.**
</center>
<br>

**Important!** The following step depends on the output of u-boot compilation
specifically the file `u-boot-spl-dtb.hex`. To generate the pair `top.core.rbf`
and `top.hps.jic` for [Agilex™ 5 FPGA E-Series 065B Modular Development Kit](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a5e065b-modular.html)
execute:

```bash
quartus_pfg -c top.sof top.jic \
  -o device=MT25QU02G \
  -o flash_loader=A5ED065BB32AE6SR0 \
  -o hps_path=u-boot-spl-dtb.hex \
  -o mode=ASX4 \
  -o hps=1
```

### Create phase 1 and phase 2 configuration bitstream for "FPGA First" Flow

Follow these steps if the `"HPS init"` property for the hps_subsystem in the `XML`
is set to `"AFTER INIT_DONE"`. You can check this property by executing the following
Quartus® command and the `"\*.sof"` file. For example:

```bash
quartus_pfg -i top.sof
```

In the log, look for the property `"HPS/FPGA configuration order"` SET TO `"AFTER INIT_DONE"`

<br>

![fpga-first](/rel-25.1/embedded-designs/agilex-5/e-series/modular/drive-on-chip/common/images/fpga-first.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**FPGA First SOF file.**
</center>
<br>

**Important!** The following step depends on the output of u-boot compilation
specifically the file `u-boot-spl-dtb.hex`. To generate the `top.jic` for
[Agilex™ 5 FPGA E-Series 065B Modular Development Kit](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a5e065b-modular.html)
execute:

```bash
quartus_pfg -c top.sof top.jic \
  -o device=MT25QU02G \
  -o flash_loader=A5ED065BB32AE6SR0 
  -o hps_path=u-boot-spl-dtb.hex \
  -o mode=ASX4 \
```
