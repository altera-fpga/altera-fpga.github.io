# **Intel HSSI configurable ethernet phy driver**

**Upstream Status**: Not Upstreamed

**Devices supported**: Stratix 10

## **Introduction**

This is the Intel HSSI configurable ethernet phy driver. It provides the ability to view and change some of the transceiver tuner parameters for a QSFP interface on legacy D5005 designs.

|Driver|Mapping|Source(s)|Required for DFL|
|---|---|---|---|
|intel-s10-phy.ko|Intel HSSI configurable ethernet phy driver|drivers/net/phy/intel-s10-phy.c|N|

## **Driver Sources**

The GitHub source code for this driver can be found at [https://github.com/OFS/linux-dfl/blob/fpga-ofs-dev-6.1-lts/drivers/net/phy/intel-s10-phy.c](https://github.com/OFS/linux-dfl/blob/fpga-ofs-dev-6.1-lts/drivers/net/phy/intel-s10-phy.c).

## **Driver Capabilities**

* Read and write XCVR status and statistics

## **Kernel Configurations**

INTEL_S10_PHY

![](./images/intel_s10_phy_menuconfig.PNG)

## **Known Issues**

None known

## **Example Designs**

N/A

