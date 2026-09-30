# Drive-On-Chip with Functional Safety Design Example for Agilex™ 5 Devices

## Safety IP Input and Output Signals

The signals connect various blocks in the Drive-On-Chip for Functional Safety
Design Example for Agilex™ 5 devices.

<br>

<center>

### Drive-on-chip Safety Interface Signals

| Port name | Polarity | Description     |
| :-------- |:--------:| :-------------- |
| clk                         | Input    | Clock. Asynchronous to any other clock                                      |
| reset_n                     | Input    | Active low reset. Asynchronous to any other resets.                         |
| reset_safety_n_i            | Input    | Reset to get out of the safe state                                          |
| reset_safety_n_o            | Output   | Reset to get out of the safe state                                          |
| reset_safety_mem_n_o        | Output   | Extension of `reset_safety_n` for memory safe state clearance               |
| qep_count [31 : 0]          | Input    | Quadrature encoder pulse IP counter input                                   |
| timer_pulse                 | Input    | Time-out signal from the Interval timer block                               |
| quad_error (_p, _n)         | Output   | Quadrature encoder pulse error feed to the external safety logic.           |
| fpga_is_safe (_p, _n)       | Output   | Over-speed detection. Traduced to safe status.                              |
| fpga_compare_good_p(_p, _n) | Output   | Result of comparison of HPS and FPGA payloads                               |
| compare_timeout             | Output   | FPGA finite state machine timeout asserted                                  |
| heartbeat_fusa              | Output   | The heartbeat signal of FuSa block 1 toggle once every <br> safety cycle period to indicate correct functionality. |
| heartbeat_timer             | Output   | The heartbeat signal of interval time toggle once every <br> safety cycle period to indicate correct functionality. |
| AXI Lite Interface          | -        | -                                                                           |
| APB Interface               | -        | -                                                                           |

</center>

<br>

<center>

### Drive-on-chip Safety Function Interface Signals

| Port name            | Polarity | Description                                                                 |
|----------------------|----------|-----------------------------------------------------------------------------|
| clk                  | Input    | Clock. Asynchronous to any other clock                                      |
| reset_n              | Input    | Active low reset. Asynchronous to any other resets.                         |
| reset_safety_n       | Input    | Reset to get out of the safe state                                          |
| generate_bit         | Input    | Enable the heartbeat generation                                             |
| timeout_pulse        | Input    | Time-out signal from the Interval timer block                               |
| qep_count [31 : 0]   | Input    | Quadrature encoder pulse IP counter input                                   |
| qep_error            | Input    | Error input. Assert when you detect a quadrature decode <br> error (over-speed). If A and B both change during the same <br> clock cycle or if the encoder error input (E) is asserted. |
| quad_error (_p, _n)  | Output   | Quadrature encoder pulse Error feed to the external safety logic.           |
| fpga_is_safe (_p, _n)| Output   | Overs-peed detection: traduced to safe status.                               |
| over_speed           | Output   | Asserted if the calculated speed in the speed estimator is over the threshold|
| over_speed_led       | Output   | `over_speed` negated, routed to a board LED                                 |
| heartbeat_fusa       | Output   | The heartbeat signal of FUSA block 1 toggle once every <br> safety cycle period to indicate correct functionality. |
| heartbeat_timer      | Output   | The heartbeat signal of timer block 1 toggle once every <br> safety cycle period to indicate functionality. |
| payload [31 : 0]     | Output   | Type `t_safety_payload` defined in `pkg_doc_safety.sv`                      |
| AXI Lite Interface   | -        |-                                                                            |

</center>

<br>

<center>

### AXI to APB block Interface Signals (Platform Designer Block)

| <div style="width:100px">Port name</div>| Polarity | <div style="width:100px">Description</div>|
|-------------------|----------|-----------------------------------------------------------------------------|
| s_axi_aclk        | Input    | Clock. Asynchronous to any other clock                                      |
| s_axi_aresetn     | Input    | Active low reset. Asynchronous to any other resets.                         |
| reset_safety_n    | Input    | Reset to get out of the safe state                                          |
| AXI Lite Interface| -        | -                                                                           |
| APB Interface     | -        | -                                                                           |

</center>

<br>

<center>

### Heartbeat Generator Interface Signals

| Port name   | Polarity | Description                                                                    |
|-------------|----------|--------------------------------------------------------------------------------|
| clk         | Input    | Clock                                                                          |
| generateBit | Input    | Control signal to toggle the state of heartbeat output. Input may be <br> derived from comparison function output or timeout pulse. |
| heartbeat   | Output   | Singular bit to indicate the heartbeat. Indicates overall block functionality. |

</center>

<br>

<center>

### Speed Estimator block Interface Signals

| Port name              | Polarity | Description                                                                 |
|------------------------|----------|-----------------------------------------------------------------------------|
| clk                    | Input    | Clock                                                                       |
| reset                  | Input    | Reset                                                                       |
| qep_count [31 : 0]     | Input    | Quadrature encoder pulse IP counter input                                   |
| qep_error              | Input    | Error input. Asserted when a quadrature decode error (over-speed) <br> is detected. If A and B both change during the same clock cycle <br> or if the encoder error input (E) is asserted. |
| over_speed             | Output   | Singular bit to indicate whether the current estimated speed <br> is beyond a parameterizable threshold. |
| led_signal             | Output   | Singular bit to be sent to an active low LED to represent the <br> status of `over_speed`. |
| motor_speed_filtered   | Output   | Custom variable type, `t_speed`.                                            |
| quad_error (_p, _n)    | Output   | Complementary bits (p = 1'b0, n = 1'b1) to represent whether <br> a quadrature error is detected. Entirely based of the input <br> `qep_error`. |
| fpga_is_safe (_p, _n)  | Output   | Complementary bits (p = 1'b1, n = 1'b0) to represent that FPGA <br> is overall safe, in respect to `over_speed`. |
| APB Interface          | -        | -                                                                           |

</center>

<br>

<center>

### Payload Generator block Interface Signals

| Port name        | Polarity | Description                                                                 |
|------------------|----------|-----------------------------------------------------------------------------|
| clk              | Input    | Clock                                                                       |
| reset_n          | Input    | Reset                                                                       |
| reset_safety_n   | Input    | Reset to get out of the safe state                                          |
| speed_rpm        | Input    | Incoming signal from the speed estimator module, which indicates <br> the current estimated speed of the motor. Type `t_speed` |
| over_speed       | Input    | Singular bit to indicate whether the current estimated speed <br> is beyond a threshold. |
| generate_pulse   | Input    | Control signal to create a valid payload and increment an <br> internal sequence counter when asserted. |
| fpga_payload     | Output   | Created using a custom defined `struct`, `t_safety_payload`, <br> which has the properties over-speed, speed and sequence. <br> The design assigns these properties. |

</center>

<br>

<center>

### Cross-comparison Function block Interface Signals

| Port name              | Polarity | Description                                                                 |
|------------------------|----------|-----------------------------------------------------------------------------|
| clk                    | Input    | Clock                                                                       |
| reset_n                | Input    | Reset                                                                       |
| reset_safety_n         | Input    | Reset to get out of the safe state                                          |
| start                  | Input    | Assert to start the FPGA safe channel cycle by the Interval timer <br> every safety response time. |
| fpga_payload           | Input    | Type `t_safety_payload`<br>Over-speed, speed in rpm, sequence number.        |
| generate_fpga          | Output   | Indicates to the safety function block to return a valid payload <br> from the speed estimation. |
| compare_good(_p, _n)   | Output   | Output asserted if the HPS payload and FPGA payload <br> in memory are consistent. |
| compare_timeout        | Output   | FPGA finite state machine timeout asserted                                  |
| APB Interface          | -        | -                                                                           |

</center>

<br>

<center>

### Quadrature Encoder Pulse block Interface Signals

| Port name        | Polarity | Description                                                                 |
|------------------|----------|-----------------------------------------------------------------------------|
| clk              | Input    | Clock                                                                       |
| reset_n          | Input    | Reset                                                                       |
| QEP_A            | Input    | Quadrature pulse from motor (model)                                         |
| QEP_B            | Input    | Quadrature pulse from motor (model)                                         |
| QEP_I            | Input    | Index pulse, per complete revolution                                        |
| QEP_E            | Input    | Encoder Error input. 1 indicates that the motor's encoder detects <br> a fault and the design cannot rely on the quadrature signals. |
| QEP_error        | Output   | Error output. Asserted when a quadrature decode error (over-speed) <br> is detected. If A and B both change during the same clock cycle or <br> if the encoder error input (E) is asserted.<br>Only de-asserted when you write a 1 to the `reset_quad_error` <br> bit in the control register via the Avalon bus. |
| QEP_count [31 : 0] | Output | Quadrature encoder pulse IP counter output                                  |
| Avalon Interface | -        | Avalon bus byte addressing but only full word accesses supported.           |

</center>

<br>

<center>

### External Safety Logic Interface Signals

| Port name| Polarity | Description |
|------------------------|----------|-----------------------------------------------------------------------------|
| esl_clk                | Input    | Clock. Asynchronous to any other clock                                      |
| esl_reset              | Input    | Reset. Independent to any other reset                                       |
| clk_hps                | Input    | HPS clock                                                                   |
| clk_fpga               | Input    | FPGA clock                                                                  |
| Heartbeat_timer        | Input    | Heartbeat signal of the timer that toggles once every <br> safety cycle period to indicate correct behavior |
| Heartbeat_fusa         | Input    | Heartbeat signal of FUSA block 1 that toggles once <br> every safety cycle period to indicate correct behavior |
| Quad_error (_p, _n)    | Input    | Indicates that the quadrature encoder pulse detects <br> a quadrature error.<br>(`p`=0, `n`=1) |
| FPGA_safe (_p, _n)     | Input    | Indicates that the FPGA detects the motor speed <br> as safe (`p`=1, `n`=0)      |
| FPGA_compare (_p, _n)  | Input    | Indicates that the FPGA cross comparison function <br> detects the FPGA and HPS payloads as the same <br> (`p`=1, `n`=0) |
| HPS_safe (_p, _n)      | Input    | Indicates that the HPS detects the motor speed <br> as safe (`p`=1, `n`=0)       |
| HPS_compare (_p, _n)   | Input    | Indicates that the HPS cross comparison function detects <br> the FPGA and HPS payloads as the same (`p`=1, `n`=0) |
| compare_timeout        | Input    | FPGA finite state machine timeout asserted                                  |
| CRAM_good (_p, _n)     | Input    | Indicates that no fault is detected in the FPGA's <br> CRAM (`p`=1, `n`=0)       |
| power_good (_p, _n)    | Input    | Indicates that the voltage monitor block measures <br> the power rails within the acceptable <br> range (`p`=1, `n`=0) |
| current_rp_temp        | Input    | Variable of parameterizable bits that indicates the <br> current temperature measured by the hardware block. |
| safe_state (_p, _n)    | Output   | Control signal from the external safety logic to the <br> power control to the motor to put the motor into a <br> safe state (`p`=1, `n`=0) |
| APB Interface          | -        | -                                                                           |

</center>

<br>

<center>

### Hardware block Interface Signals

The following table details the Hardware Subsystem's I/O and a description of the
signal.<br>
All I/O signals are asynchronous to the input clock, to avoid meta-stability
these are synchronized.

| Port name          | Polarity | Description                                                                         |
|--------------------|----------|-------------------------------------------------------------------------------------|
| hw_clk             | Input    | Clock. Asynchronous to any other clock                                              |
| hw_reset           | Input    | Reset. Independent to any other reset                                               |
| pwr_good (_p, _n)  | Output   | Complementary bits to represent that power is functional <br> as intended, all voltages measured are within safe limits. |
| temp_good (_p, _n) | Output   | Complementary bits to represent measured temperatures <br> are safe, within limits. |
| cram_good (_p, _n) | Output   | Complementary bits to represent measured temperatures <br> are safe, within limits. |

</center>

<br>

## Safety IP Registers

The Drive-on-Chip with Functional Safety Design Example for Agilex™ 5 devices
contain registers that you can set.

<br>

<center>

### Speed Estimator Block Registers.

| Address | Access | Register                                                                                  |
|---------|--------|-------------------------------------------------------------------------------------------|
| 0x00    | R/W    | Control.<br>Bit 0 `overspeed_error_reset`. <br>* Writing 1 clears the over-speed bit in the status register.<br> * This bit is self-clearing. <br><br> Bit 1 `quadrature_error_reset`.<br> * Writing 1 clears the quadrature  error bit in the status register. <br>* This bit is self-clearing. <br> Bit 31 `sw_reset`.<br>*  Resets all registers in the safety function. |
| 0x04    | RO     | Clock frequency in Hz.                                                                    |
| 0x08    | R/W    | Speed estimation frequency. Default to 4 kHz.                                             |
| 0x0C    | R/W    | Over-speed threshold (rpm). Speed at which the <br> over-speed signal and register is asserted. Default is 3000 rpm. |
| 0x10    | RO     | Status.<br>Bit 0 `overspeed`.<br>Bit 1 `quadrature_error`                                 |

</center>

[Back to Documentation](../doc-funct-safety.md#example-design-documentation){ .md-button }
