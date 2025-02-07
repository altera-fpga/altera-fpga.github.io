## Overview

This page demonstrates how to use the [baremetal drivers](https://altera-fpga.github.io/rel-24.3.1/driver-list_baremetal/) for a simple hello world program, running from SDRAM, and booting from QSPI, on the [Agilex 5 E-Series Premium Development Kit](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a5e065b-premium.html)

ATF (Arm Trusted Firmware) is used, composed of the following two components:

* ATF bl22: First stage bootloader. Part of the bitstream. Initializes hardware, including SDRAM, and loads FIP image.
* ATF bl31: Secure Monitor Handler. Can perform services for the baremetal application for certain scenarios, such as configuring the FPGA fabric.

The layout of the QSPI flash is as follows:

| Address | Description |
| -- | -- |
| 0x0000_0000 | Bitstream, including ATF bl2 |
| 0x03C0_0000 | FIP image, including ATF bl31 and baremetal image |

## Build Flow

The build flow is depicted in the following diagram:

![](images/baremetal-build-flow.svg)

The following inputs are used:
 
| Item | Link |
| -- | -- |
| Baremetal Drivers Source | [baremetal-drivers](https://github.com/altera-fpga/baremetal-drivers/tree/24.3.1) |
| Baremetal CMake Project File | [CMakeLists.txt](https://altera-fpga.github.io/rel-24.3.1/baremetal-embedded/agilex-5/e-series/premium/collateral/CMakeLists.txt)|
| Programming File Generator File | [flash_image.pfg](https://altera-fpga.github.io/rel-24.3.1/baremetal-embedded/agilex-5/e-series/premium/collateral/flash_image.pfg) |
| Arm Trusted Firmware Source | [arm-trusted-firmware](https://github.com/altera-opensource/arm-trusted-firmware/tree/QPDS24.3.1_REL_GSRD_PR) |
| Precompiled GHRD SOF | [ghrd_a5ed065bb32ae6sr0_hps_debug.sof](https://releases.rocketboards.org/2025.01/gsrd/agilex5_dk_a5e065bb32aes1_gsrd/ghrd_a5ed065bb32ae6sr0_hps_debug.sof) |

Note that for the GHRD SOF we are using the SOF which has the debug FSBL inside as it was more convenient to download with an existing direct file link. However, the debug FSBL inside is overwritten with the ATF bl2 when the output QSPI flash JIC image is created.

## Build Instructions


1\. Create the top folder to store this example:



```bash
rm -rf bm_example.agilex5
mkdir bm_example.agilex5
cd bm_example.agilex5
export TOP_FOLDER=`pwd`
```


2\. Set up the toolchain required to build the example:


```bash
cd $TOP_FOLDER
wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-elf.tar.xz
tar xf arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-elf.tar.xz
rm -f arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-elf.tar.xz
export PATH=`pwd`/arm-gnu-toolchain-13.2.Rel1-x86_64-aarch64-none-elf/bin/:$PATH
export CROSS_COMPILE=aarch64-none-elf-
```


3\. Add Quartus tools to the PATH - only the Quartus Programmer tools are actually used:


```bash
export QUARTUS_ROOTDIR=~/intelFPGA_pro/24.3/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```



4\. Build ATF


```bash
cd $TOP_FOLDER
git clone -b QPDS24.3.1_REL_GSRD_PR https://github.com/altera-opensource/arm-trusted-firmware atf
make -C atf fiptool
make -C atf bl2 bl31 PLAT=agilex5 DEBUG=1 SOCFPGA_BOOT_SOURCE_QSPI=1 LOG_LEVEL=50
```



5\. Retrieve the baremetal library sources:



```bash
cd $TOP_FOLDER
rm -rf baremetal-drivers*
git clone -b 24.3.1 https://github.com/altera-fpga/baremetal-drivers
```




6\. Create the sample application folder:


```bash
cd $TOP_FOLDER
rm -rf baremetal-example
mkdir baremetal-example
cd baremetal-example
```


7\. Bring in the hello world source code:


```bash
cp $TOP_FOLDER/baremetal-drivers/test/simics/hello-world/printf_hello_world.c hello_world.c
```


8\. Bring in the cmake file for the project:


```bash
wget https://altera-fpga.github.io/rel-24.3.1/baremetal-embedded/agilex-5/e-series/premium/collateral/CMakeLists.txt
```


The file looks like this:
```bash
cmake_minimum_required(VERSION 3.5...3.28)

# disable building tests
set(BUILD_TESTS OFF)

# library dir
get_filename_component(LIBRARY_DIR "../baremetal-drivers" ABSOLUTE)

# library project
add_subdirectory(${LIBRARY_DIR} alterametal)

# linker script
set(ALTERAMETAL_LINKER_SCRIPT "${LIBRARY_DIR}/build/aarch64/core0.ld")

# project
project(bm_hello_world C CXX ASM)

# target
add_executable(hello_world.elf)

# sources
target_sources(hello_world.elf
    PRIVATE
        hello_world.c
)

# link to the baremetal library
target_link_libraries(hello_world.elf PRIVATE
    alterametal
)

# specify linker script
target_link_options(hello_world.elf PRIVATE
    -T${ALTERAMETAL_LINKER_SCRIPT}
)
```

9\. Setup the build using cmake, build the executable and create the bin file


```bash
mkdir build
cd build
cmake -GNinja ..
ninja hello_world.elf
${CROSS_COMPILE}objcopy -O binary hello_world.elf hello_world.bin
```




10\. Build FIP file, containing ATF bl31 and the hello application


```bash
$TOP_FOLDER/atf/tools/fiptool/fiptool create --soc-fw $TOP_FOLDER/atf/build/agilex5/debug/bl31.bin --nt-fw hello_world.bin fip.bin
```




11\. Bring the Programming File Generator file, used to instruct Quartus Programmer how to create the flash image:

```bash
wget https://altera-fpga.github.io/rel-24.3.1/baremetal-embedded/agilex-5/e-series/premium/collateral/flash_image.pfg
```


The file looks like this:

```xml
<pfg version="1">
    <settings custom_db_dir="./" mode="ASX4"/>
    <output_files>
        <output_file name="flash_image" hps="1" directory="./" type="PERIPH_JIC">
            <file_options/>
            <secondary_file type="MAP" name="flash_image_jic">
                <file_options/>
            </secondary_file>
            <secondary_file type="SEC_RPD" name="flash_image_jic">
                <file_options bitswap="1"/>
            </secondary_file>
            <flash_device_id>Flash_Device_1</flash_device_id>
        </output_file>
    </output_files>
    <bitstreams>
        <bitstream id="Bitstream_1">
            <path signing="OFF" finalize_encryption="0" hps_path="bl2.hex">design.sof</path>
        </bitstream>
    </bitstreams>
    <raw_files>
        <raw_file bitswap="1" type="RBF" id="Raw_File_1">fip.bin</raw_file>
    </raw_files>
    <flash_devices>
        <flash_device type="MT25QU512" id="Flash_Device_1">
            <partition reserved="1" fixed_s_addr="1" s_addr="0x00000000" e_addr="0x001FFFFF" fixed_e_addr="1" id="BOOT_INFO" size="0"/>
            <partition reserved="0" fixed_s_addr="0" s_addr="auto" e_addr="auto" fixed_e_addr="0" id="P1" size="0"/>
            <partition reserved="0" fixed_s_addr="0" s_addr="0x03C00000" e_addr="auto" fixed_e_addr="0" id="fip" size="0"/>
        </flash_device>
        <flash_loader>a5ed065bb32ae5sr0</flash_loader>
    </flash_devices>
    <assignments>
        <assignment page="0" partition_id="P1">
            <bitstream_id>Bitstream_1</bitstream_id>
        </assignment>
        <assignment page="0" partition_id="fip">
            <raw_file_id>Raw_File_1</raw_file_id>
        </assignment>
    </assignments>
</pfg>
```
12\. Convert bl2 to hex format to be used by Programming File Generator:


```bash
${CROSS_COMPILE}objcopy -v -I binary -O ihex --change-addresses 0x0 $TOP_FOLDER/atf/build/agilex5/debug/bl2.bin bl2.hex
```


13\. Create JIC File, using the prebuilt hardware SOF file from GSRD release:


```bash
wget -O design.sof https://releases.rocketboards.org/2025.01/gsrd/agilex5_dk_a5e065bb32aes1_gsrd/ghrd_a5ed065bb32ae6sr0_hps_debug.sof
quartus_pfg -c flash_image.pfg
```




## Run Example

1\. Set up the board as described in the GSRD [Configure Board](https://altera-fpga.github.io/rel-24.3.1embedded-designs/agilex-5/e-series/premium/gsrd/ug-gsrd-agx5e-premium/#configure-board).

2\. Power down board

3\. Set up MSEL dipswitch SW27 for JTAG boot: OFF-OFF-OFF-OFF

4\. Power up board

5\. Program the QSPI flash with the JIC file:

```bash
quartus_pgm -c 1 -m jtag -o "pvi;$TOP_FOLDER/baremetal-example/build/flash_image.hps.jic"
```

6\. Power down board

7\. Set up MSEL dipswitch SW27 for QSPI boot:OFF-ON-ON-OFF

8\. Power up board

9\. Observe on the HPS serial console how bl31 is ran, then it loads the FIP image, and runs the baremetal application which prints the hello world message.


## Notices & Disclaimers

Altera<sup>&reg;</sup> Corporation technologies may require enabled hardware, software or service activation.
No product or component can be absolutely secure. 
Performance varies by use, configuration and other factors.
Your costs and results may vary. 
You may not use or facilitate the use of this document in connection with any infringement or other legal analysis concerning Altera or Intel products described herein. You agree to grant Altera Corporation a non-exclusive, royalty-free license to any patent claim thereafter drafted which includes subject matter disclosed herein.
No license (express or implied, by estoppel or otherwise) to any intellectual property rights is granted by this document, with the sole exception that you may publish an unmodified copy. You may create software implementations based on this document and in compliance with the foregoing that are intended to execute on the Altera or Intel product(s) referenced in this document. No rights are granted to create modifications or derivatives of this document.
The products described may contain design defects or errors known as errata which may cause the product to deviate from published specifications.  Current characterized errata are available on request.
Altera disclaims all express and implied warranties, including without limitation, the implied warranties of merchantability, fitness for a particular purpose, and non-infringement, as well as any warranty arising from course of performance, course of dealing, or usage in trade.
You are responsible for safety of the overall system, including compliance with applicable safety-related requirements or standards. 
<sup>&copy;</sup> Altera Corporation.  Altera, the Altera logo, and other Altera marks are trademarks of Altera Corporation.  Other names and brands may be claimed as the property of others. 

OpenCL* and the OpenCL* logo are trademarks of Apple Inc. used by permission of the Khronos Group™. 