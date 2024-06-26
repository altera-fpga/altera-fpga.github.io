# fpgainfo #

## SYNOPSIS ##
```console
   fpgainfo [-h] [-S <segment>] [-B <bus>] [-D <device>] [-F <function>] [PCI_ADDR]
            {errors,power,temp,fme,port,bmc,mac,phy,security}

```



## DESCRIPTION ##
fpgainfo displays FPGA information derived from sysfs files. The command argument is one of the following:
`errors`, `power`, `temp`, `port`, `fme`, `bmc`, `phy` or `mac`,`security`,`events`.
Some commands may also have other arguments or options that control their behavior.

For systems with multiple FPGA devices, you can specify the BDF to limit the output to the FPGA resource
with the corresponding PCIe configuration. If not specified, information displays for all resources for
the given command.

### FPGAINFO COMMANDS ##
`errors`

Show/clear errors of an FPGA resource that the first argument specifies.
`fpgainfo` displays information in human readable form.

`power`

Show total the power in watts that the FPGA hardware consumes.

`temp`

 Show FPGA temperature values in degrees Celcius.

`port`

Show information about the port such as the AFU ID of currently loaded AFU.

`fme`

Show information about the FPGA platform including the partial reconfiguration (PR) Interface ID, the OPAE version,
and the FPGA Interface Manager (FIM) ID.

`bmc`

Show all Board Management Controller sensor values for the FPGA resource, if available.

`phy`

Show information about the PHY integrated in the FPGA, if available.

`mac`

Show information about the MAC address in ROM attached to the FPGA, if available.

`security`

Show information about the security keys, hashs and flash count, if available.

`events`

Show information about events and sensors, if available.

## OPTIONAL ARGUMENTS ##
`--help, -h`

Prints help information and exit.

`--version, -v`

Prints version information and exit.

## COMMON ARGUMENTS ##
The following arguments are common to all commands and are optional.

`-S, --segment`

PCIe segment number of resource.

`-B, --bus`

PCIe bus number of resource.

`-D, --device`

PCIe device number of resource.

`-F, --function`

PCIe function number of resource.

### ERRORS ARGUMENTS ###
The first argument to the `errors` command specifies the resource type. It must be one of the following:
   `fme`,`port`,`all`

`fme`

 Show/clear FME errors. 

`port`

 Show/clear PORT errors.

`all`

Show/clear errors for all resources.

The optional `<command-args>` arguments are:

`--clear, -c`

Clear errors for the given FPGA resource.


### PHY ARGUMENTS ###
The optional `<command-args>` argument is:

`--group, -G`

Select which PHY group(s) information to show.


### EVENTS ARGUMENTS ###
The optional `<command-args>` argument is:

`--list,-l`

List boots (implies --all).

`--boot,-b`

Boot index to use, i.e:
&nbsp;&nbsp;&nbsp;&nbsp;0 for current boot (default).
&nbsp;&nbsp;&nbsp;&nbsp;1 for previous boot, etc.

`--count,-c`

Number of events to print.

`--all,-a`

Print all events.

`--sensors,-s`

Print sensor data too.

`--bits,-i`

Print bit values too.

`--help,-h`

Print this help.

## EXAMPLES ##
This command shows the current power telemetry:
```console
./fpgainfo power
```

This command shows the current temperature readings:
```console
./fpgainfo temp
```

This command shows FME resource errors:
```console
./fpgainfo errors fme
```
This command clears all errors on all resources:
```console
./fpgainfo errors all -c
```
This command shows information of the FME on bus 0x5e
```console
./fpgainfo fme -B 0x5e
```
This command shows information of the FPGA security on bus 0x5e
```console
./fpgainfo security -B 0x5e
```
This command shows all events and sensors information including sensor bits:
```console
./fpgainfo events -asi
```
