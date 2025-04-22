The following examples are demonstrated using 2 units of the Agilex 5 platform.  Please take note of the notation "[Board A or B]". The following steps assumes both platforms are connected to each other via an Ethernet connection.

1\. Boot to Linux

2\. Navigate to the `tsn` directory

```bash
cd tsn
```

<h5>Configuration for Both Boards</h5>

<h6>Step I: Setup Environment Path on Both Boards</h6>

3\. Board A

   ```bash
   export LIBXDP_OBJECT_PATH=/usr/lib/bpf
   export LD_LIBRARY_PATH=/usr/lib/custom_bpf/lib 
   ```

4\. Board B

   ```bash
   export LIBXDP_OBJECT_PATH=/usr/lib/bpf
   export LD_LIBRARY_PATH=/usr/lib/custom_bpf/lib 
   ```

<h5>TXRX-TSN App</h5>

<h6>Step II: Run Configuration Script</h6>

5\. Board A: Run the configuration script and wait for it to configure the IP and MAC address, start clock synchronization, and set up TAPRIO qdisc.

   ```bash
   ./run.sh agilex5 eth0 vs1a setup
   ```

6\. Board B: Run the configuration script and wait for it to configure the IP and MAC address, start clock synchronization, and set up ingress qdiscs.

   ```bash
   ./run.sh agilex5 eth0 vs1b setup
   ```

<h6>Step III: Start the Application</h6>

7\. Board B: Run the application.

   ```bash
   ./run.sh agilex5 eth0 vs1b run
   ```

8\. Board A: Immediately after starting the application on Board B, run the application on Board A.

   ```bash
   ./run.sh agilex5 eth0 vs1a run
   ```

<h5>Post-Test Procedure</h5>
Once the test is completed, copy the following files from Board B (listener) to the host machine:

- afpkt-rxtstamps.txt
- afxdp-rxtstamps.txt

<h5>Generating Latency Plot Using Excel</h5>

Import 'afpkt-rxtstamps.txt' and 'afxdp-rxtstamps.txt' to excel in 2 seperate sheets.

<img src="https://altera-fpga.github.io/rel-25.1/embedded-designs/doc_modules/tsn/images/1_excelview.png" alt="Import.txt File"  width="800">

Plot Column 1 for each sheets using Scatter chart,

<img src="https://altera-fpga.github.io/rel-25.1/embedded-designs/doc_modules/tsn/images/2_excelview.png" alt="Plot Scatter Chart"  width="800">


This will generate plot for AFPKT and AFXDP with latency(on Y-axis) against packet count (on X-axis).
  