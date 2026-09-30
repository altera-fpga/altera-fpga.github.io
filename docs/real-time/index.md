# Real-Time

Real-time operation for Altera&reg; devices can be implemented using two main approaches: the highly deterministic, low-latency capabilities of the hardware-programmable fabric, and the use of soft or hard processors running real-time operating systems (RTOS). Altera&reg; offers a variety of devices, which provide a flexible foundation for real-time applications.

## What is Real-Time

A real-time system is one in which correctness depends not only on what results are produced, but when they are produced. In real-time computing, meeting timing deadlines is as critical as functional correctness.

Real-time behavior is defined by deterministic and bounded response times, not by average performance or peak throughput. A system that is fast most of the time but occasionally misses a deadline is not real-time.

Real-time systems are commonly categorized as:

 * Hard real-time: Missing a deadline is a system failure (e.g., motor control, power conversion, safety systems).
 * Firm real-time: Occasional missed deadlines are tolerable but reduce system quality.
 * Soft real-time: Deadlines are best-effort and primarily affect user experience.

On modern SoCs, achieving real-time behavior requires careful control of latency and jitter across the entire system, including CPU scheduling, interrupts, caches, memory, interconnects, and power management. Multicore processors and shared resources introduce additional sources of non-determinism that must be understood and managed.

Real-time performance is therefore not a single feature or configuration option—it is the result of system-level design, tuning, and validation.

## Embedded Real-Time Solutions

For complex applications, Altera&reg; SoC FPGAs integrate a hard-processor subsystem (HPS) with the FPGA fabric, offering a balance between software flexibility and hardware acceleration. The following software options are available for the embedded processors:

* **Real-time operating systems (RTOS):** For soft real-time and complex control systems, developers can use a dedicated RTOS on the HPS.
Common RTOS options: Supported operating systems include FreeRTOS, Zephyr, and VxWorks.

* **Bare-metal software:** For the highest level of software determinism, bare-metal development runs software directly on the processor without an operating system. This is suitable for safety-critical systems with uncompromising requirements.

* **Embedded Linux:** For applications with softer real-time requirements that need rich software stacks and device drivers, embedded Linux is a viable option. Altera&reg; provides tools and partner ecosystems to facilitate this approach.

* **Soft-core processors:** For lower-cost FPGAs or when a custom CPU is needed within the programmable fabric, developers can instantiate soft-core processors like Nios V. This allows for flexible integration with other hardware blocks and can be combined with RTOS like FreeRTOS.


## Foundational Documents

This section presents an overview of the available documents.

[**Embedded Linux RT Tuning (KAS/Yocto)**](https://altera-fpga.github.io/rel-26.1/real-time/embedded-linux/yocto-kas). This document explains how to build and tune a deterministic, low-latency Embedded Linux system using Yocto Project and KAS for Altera&reg; SoC platforms. It focuses on PREEMPT_RT, kernel configuration, CPU isolation, interrupt handling, memory behavior, and build reproducibility. The goal is to achieve bounded latency suitable for hard and firm real-time workloads on heterogeneous Arm SoCs.


[**Agilex&trade; 5 HPS CPU Cluster Latency**](https://altera-fpga.github.io/rel-26.1/real-time/agilex5-hps-cpu-cluster-latency/agilex5_hps_cpu_cluster_latency). This document analyzes latency behavior in the Arm DynamIQ CPU cluster used in the Altera&reg; Agilex&trade; 5 HPS, focusing on how cache hierarchy, the DSU snoop filter, and system-level components interact under load. It demonstrates that even isolated, L1-resident workloads can experience large, non-deterministic latency excursions when other cores generate extreme coherency pressure—and shows how these effects can be mitigated to support hard real-time workloads (10–100 kHz range).