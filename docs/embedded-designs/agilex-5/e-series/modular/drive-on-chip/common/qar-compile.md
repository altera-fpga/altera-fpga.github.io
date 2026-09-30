## Compiling the project using a MDT QAR file

* Download the relevant design `.qar` file for your development kit and power
   board from  link/repository.

* Double click in the .qar file or alternatively use Quartus® command line to
  open it:
  
    ```bash
      quartus <MDT_QAR_NAME>.qar
    ```

    The contents of the `.qar` file open into the working directory. The
    design example has the following directory structure.

    <br>

    ![qar-content](/rel-25.3/embedded-designs/agilex-5/e-series/modular/drive-on-chip/common/images/qar-content.png){:style="display:block; margin-left:auto; margin-right:auto"}
    <center>

    **QAR file content.**
    </center>
    <br>

    **Note:** This `QAR` file was generated using the "Modular Design Toolkit" flow.

    <br>

    <center>

     **QAR and Project Directory Structure.**

    | Directory     | Description  |
    | --------------| ---- |
    | assets        | Contains base files to run the example design derived from the hardware compilation. |
    | non_qpds_ip   | Contains the source code (RTL) of the design’s custom IP that is not part of Quartus® Prime. |
    | quartus       | Contains the base files for the Quartus® Project including the top.qpf, top.qsf. |
    | rtl           | Contains the sources files to build the project. |
    | scripts       | Contains a collection of TCL scripts from "Modular Design Toolkit" to build and compile the design software and hardware. |
    | sdc           | Contains the .sdc files for the subsystems to compile the project. |
    | software      | Contains all the files for building the application for the Nios V and/or HPS. Look for the app.elf binary or *_cpu_ram_cpu_ram.hex that is included in the SOF |

    </center>

<br>

* Navigate to `<project>/quartus/` and open the `top.qpf` file either by double
   clicking on it or using the command:

    ```bash
    quartus top.qpf
    ```

* To generate the `.sof` file, click on **"Processing -> Start Compilation Ctrl+L"**
  or simply press the **"Start Compilation"** icon in the Quartus® Prime Pro GUI.

<br>

![quartus-comp](/rel-25.3/embedded-designs/agilex-5/e-series/modular/drive-on-chip/common/images/quartus-comp.png){:style="display:block; margin-left:auto; margin-right:auto"}
<center>

**Quartus® Prime Pro compilation flow.**
</center>
<br>

  Wait for the compilation to finish. The `.sof` file should be located in the
  `<project>/quartus/output_files` directory. Follow the steps generate the
  `RBF/JIC` file using the `.sof` file and the `u-boot-spl-dtb.hex` file.

**Note:** it si recommended to generate any embedded software images that are
included in the `.sof` file before compiling, i.e NiosV software.
