
## Alternate RBF Download

There are several methods to get your `.rbf` onto the Modular Development Kit.
You may want to use this method when developing your own design but do not
require the microSD Card to be rebuilt and updated:

* Copy your `.rbf` into the boot partition of the microSD Card:
  * Power down the Modular Development Kit and remove the microSD Card from the
    Modular Development Kit SOM Board.
  * Rename your `agilex5_modkit_vvpisp.hps_first.core.rbf` to `top.core.rbf`.
  * Connect the microSD Card to your Host computer and copy your `top.core.rbf`
    into the boot partition of the microSD Card.
  * Safely disconnect the microSD Card from your Host computer.
  * Insert the microSD Card back into the Modular Development Kit SOM Board and
    Power up Modular Development Kit. Your new `.rbf` will get loaded by the
    bootloader.
* `ssh` or `scp` your `.rbf` to the Modular Development Kit (using its
  `<ip address>`):
  * Power up the Modular Development Kit and wait until it fully boots.
  * Using a Linux terminal (or Windows equivalent like PowerShell) on your
    Host computer:

    ```bash
    scp agilex5_modkit_vvpisp.hps_first.core.rbf root@<ip address>:/mnt/boot/top.core.rbf
    ```

  * Using the Modular Development Kit serial terminal connection, login and
    sync any pending file writes:

    ```bash
    root
    sync
    ```

  * Power cycle the Modular Development Kit. Your new `.rbf` will get loaded by
    the bootloader.

