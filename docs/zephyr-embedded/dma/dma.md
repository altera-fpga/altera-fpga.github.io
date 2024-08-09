# **DMA Driver for Hard Processor System**

Last updated: **August 09, 2024** 

**Upstream Status**: No

**Devices supported**: Agilex 5

## **Introduction**

DMA Controller controls the transfer of data between I/O devices and memory without CPU involvement. DMA controller can access the memory directly for reading and writing. This helps to enhance the performance of the cores to do some other operations, as the data transfers are handled by the DMA controller.

The hard processor system (HPS) provides two DMA Controllers based on the Synopsis-Designware IP.

For more information please refer to the [Intel Agilex 5 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/814346).

## **Driver Sources**

The source code for this driver can be found at [https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/dma/dma_dw_axi.c](https://github.com/altera-opensource/zephyr-socfpga/blob/socfpga_rel_23.4/drivers/dma/dma_dw_axi.c).

## **Driver Capabilities**

* Driver supports scatter-gather list.
* Driver can be configured for one of the possible three use cases.
    * Memory to Memory Transfer
    * Device to Memory Transfer
    * Memory to Device Transfer
* Each DMA controller can support up to four channels for DMA transfer.
* Driver supports DMA transfer suspend.
* Driver supports DMA transfer resume.
* Driver supports to stop active DMA transfer.

## **Kernel Configurations**

![dma](images/dma-kernel-config.png)


## **Device Tree**

Device Tree location to configure DMA is

[https://github.com/zephyrproject-rtos/zephyr/blob/main/dts/arm64/intel/intel_socfpga_agilex5.dtsi](https://github.com/zephyrproject-rtos/zephyr/blob/main/dts/arm64/intel/intel_socfpga_agilex5.dtsi)

```dma0: dma@10DB0000 {
compatible = "snps,dw-axi-dma";
#dma-cells = <2>;
reg = <0x10DB0000 0x1000>;
interrupt-parent = <&gic>;
interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL
		 IRQ_DEFAULT_PRIORITY>,
	     <GIC_SPI 82 IRQ_TYPE_LEVEL
		 IRQ_DEFAULT_PRIORITY>,
	     <GIC_SPI 83 IRQ_TYPE_LEVEL
		 IRQ_DEFAULT_PRIORITY>,
	     <GIC_SPI 84 IRQ_TYPE_LEVEL
		 IRQ_DEFAULT_PRIORITY>;
dma-channels = <4>;
resets = <&reset RSTMGR_DMA_RSTLINE>;
status = "disabled";
};
```

## **Known Issues**

None Known. 
