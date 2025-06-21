## Compiling and Building the NiosV application and BSP

Before rebuilding the BSP, ensure that the `settings.bsp` file correctly generates.
To generate BSP, use command line and `niosv-bsp` command.

The design includes an initial version of `settings.bsp` that contains parameters
to run the design. If you modify the Platform Designer's hardware, ensure you keep
the integrity of the `settings.bsp` file.

* After changing the `settings.bsp` file, compile the application and generate the BSP
  with the command:

  ```bash
    cd <project>/software/*niosv_subsystem*
    make
  ```

Running `make` takes an existing template `settings.bsp` file and creates a new
one based on it for the current project. It updates locations of project then
builds the `.bsp` and the NiosV application. See the provided `makefile`
and `CMakeList.txt` files for more details in about the software build.
The app.elf file is in `<project>/software/*niosv_subsystem*/build/bin`

If necessary, compile the hardware again to update the `.sof` file, so it
contains the new binaries (`.hex`) for memory initialization (`<project>/software/*niosv_subsystem*/build/bin/mem_init`).

<br>
