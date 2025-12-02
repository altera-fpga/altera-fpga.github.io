# Secure Data Object Storage (SDOS) Tutorial Example User Guide



## Introduction 

Altera® Agilex™ 7 SoC devices support Secure Data Object Storage (SDOS) services. The Secure Device Manager (SDM) provides security services to HPS or logic runs on fabric. SDOS provides interfaces for secure data encryption and decryption along with signature generation and verification. 

The purpose of this tutorial is to demonstrate how to access SDOS services from SPL and U-Boot levels. The tests below are based on the Secure Boot Demo Design presented in this [Vendor Authorized Boot (HPS-First) Tutorial Example Design User Guide](https://altera-fpga.github.io/rel-25.3/embedded-designs/agilex-7/f-series/soc/security/vab/hps-first/ug-vab-hps-first-agx7f-soc/)

## Running SDOS Services from SPL 

From the Secure Boot Demo [here](https://altera-fpga.github.io/rel-25.3/security/demos/agilex7/vab/hps-first/ug-vab-hps-first-agx7f-soc/), you need to modify some of the SPL source codes to add the SDOS functions. The current SPL source code provides secure VAB for image authentication only. We can add the modifications below to enable SDOS tests for: 

1\. Open / Close SDOS session. 

2\. Create a dummy data buffer. 

3\. Send SDOS encryption command via mailbox, and retrieve the encrypted data in another buffer.

4\. Send back the encrypted data buffer with a decryption command via mailbox and retrieve the original data in a third buffer.

To achieve the test scenario above, navigate to the top directory, then to u-boot-socfpga. 

```bash 
cd $TOP_FOLDER/u-boot-socfpga/arch/arm/mach-socfpga 
```

In this directory, open the mailbox_s10.c in a text editor to modify it. The added code snippet can be pasted after line 108 [here ](https://github.com/altera-opensource/u-boot-socfpga/blob/socfpga_v2023.07/arch/arm/mach-socfpga/mailbox_s10.c). 

```C 
int secure_test() 
{ 
//Custom.. 
 
 unsigned char* inbuffer __attribute__ ((aligned (8))) = (unsigned char*)0x2000000; 
 unsigned char* enc_buffer __attribute__ ((aligned (8))) = (unsigned char*)0x3000000; 
 unsigned char* dec_buffer __attribute__ ((aligned (8))) = (unsigned char*)0x4000000; 
 
 unsigned int sdos_hdr[] = { 
 //Magic Word 
 0xACBDBDED, 
 //data size in bytes 
 0x00007FA0, 
 //AOI,key info - service root,padding length 
 0x160b0000, 
 //Owner ID 
 0x44332211, 
 0x88776655, 
 //Header Padding 
 0x01020304, 
 //IV 
 0x44332211, 
 0x88776655, 
 0x44332211, 
 0x88776655, 
 }; 
 memcpy(inbuffer, sdos_hdr, 40); 
 int i=0; 
for (i=0; i < 32712; i++){ 
 inbuffer[i+40] = i; 
 } 
 printf("Testing input buffer:\n"); 
 for (i=40; i < 80; i++){ 
 printf("%x ", inbuffer[i]); 
 } 
 
 unsigned int session_id, context_id =0; 
 int ret_code, command_length; 
 unsigned int argument[9]; 
 unsigned int response_length, cmd, argument_length; 
 unsigned int response_stored[4]; 
 
 argument[0] = 0; 
 cmd = 0xA0; 
 command_length = 0; 
 argument_length = 0; 
 response_length = 1; 
 
 printf("\nOpening SDM Session\n"); 
 ret_code = mbox_send_cmd(MBOX_ID_UBOOT, cmd, MBOX_CMD_DIRECT, argument_length, argument, 0, &response_length, response_stored); 
 if(ret_code != 0) { 
 printf("Open FCS error, return code: 0x%x\n", ret_code); 
 } 
 else { 
 session_id = response_stored[0]; 
 printf("SDM Session opened, ID= 0x%x -- ret_code= x%x \n", session_id,ret_code); 
 
 } 
 
 printf("SDOS ENC with Session ID = 0x%x\n",session_id); 
 cmd = 0x7E; 
 argument[0] = session_id; 
 argument[1] = context_id++; 
 argument[2] = (7 << 24); 
 argument[3] = (unsigned int)inbuffer; 
 argument[4] = 32712; 
 argument[5] = (unsigned int)enc_buffer; 
 argument[6] = 32760; 
 argument_length = 7; 
 command_length = 7; 
 response_length = 4; 
 
 unsigned long begin = timer_get_us(); 
 ret_code = mbox_send_cmd(MBOX_ID_UBOOT, cmd, MBOX_CMD_DIRECT, argument_length, argument, 0, &response_length, response_stored); 
 unsigned long end = timer_get_us(); 
 unsigned long time_spent = (unsigned long)(end - begin); 
 
 if(0 != ret_code) { 
 printf("SDOS Encryption error, return code: 0x%x\n", ret_code); 
 }else{ 
 printf("Time spent for SDOS Encryption (timer_get_us)= %d ms\n", time_spent/1000); 
 
 printf("Testing Encryption Buffer:\n"); 
 for (i=40; i < 80; i++){ 
 printf("%x ", enc_buffer[i]); 
 } 
 } 
 
 printf("\nSDOS Decryption with Session ID = 0x%x\n",session_id); 
 cmd = 0x7F; 
 argument[0] = session_id; 
 argument[1] = context_id++; 
 argument[2] = (7 << 24); 
 argument[3] = 0x44332211; 
 argument[4] = 0x88776655; 
 argument[5] = (unsigned int)enc_buffer; 
 argument[6] = 32760; 
 argument[7] = (unsigned int)dec_buffer; 
 argument[8] = 32712; 
 argument_length = 9; 
 command_length = 9; 
 response_length = 4; 
 
 begin = timer_get_us(); 
 ret_code = mbox_send_cmd(MBOX_ID_UBOOT, cmd, MBOX_CMD_DIRECT, argument_length, argument, 0, &response_length, response_stored); 
 end = timer_get_us(); 
 time_spent = (unsigned long)(end - begin); 
 if(0 != ret_code) { 
 printf("SDOS Decryption error, return code: 0x%x\n", ret_code); 
 }else{ 
 printf("Time spent for SDOS Decryption (timer_get_us)= %d ms\n", time_spent/1000); 
 printf("Testing Decryption Buffer:\n"); 
 for (i=40; i < 80; i++){ //16384 32672 
 printf("%x ", dec_buffer[i]); 
 } 
 } 
 
 argument[0] = 0; 
 cmd = 0xA1; 
 command_length = 1; 
 argument_length = 1; 
 response_length = 0; 
 
 printf("\nClosing SDM Session\n"); 
 ret_code = mbox_send_cmd(MBOX_ID_UBOOT, cmd, MBOX_CMD_DIRECT, argument_length, argument, 1, &response_length, response_stored); 
 if(ret_code != 0) { 
 printf("Close FCS error, return code: 0x%x\n", ret_code); 
 } 
 else { 
 printf("SDM Session closed, resp= 0x%x -- ret_code= x%x \n", response_stored[0], ret_code); 
 } 
 return 0; 
//Custom// 
} 
```

In the code above, secure_test() function contains all the necessary steps to add SDOS tests for the mailbox drive. First, we create the data buffers in the DDR region. Second, we create the SDOS header, make sure to add the proper size for the test data. In this demo, we used 0x00007FA0 for the maximum data size for AES encryption (32K-96 bytes). After that, we prepare the mailbox commands for opening an SDOS session, send an encryption command, send a decryption command, and finally, close the SDOS session. 

After adding this code snippet, we need to call the secure_test() function. This call can be set after initializing DDR and Mailbox, it can be placed in [spl_agilex.c](https://github.com/altera-opensource/u-boot-socfpga/blob/socfpga_v2023.07/arch/arm/mach-socfpga/spl_agilex.c) found inside mach-socfpga directory. After line 89, we can add the function call: 

```bash 
secure_test(); 
```

After saving both files, we need to re-generate u-boot: 

```bash 
cd $TOP_FOLDER/u-boot-socfpga/ 
make -j 24 u-boot u-boot.img u-boot.dtb spl/u-boot-spl-dtb.hex
cd ..
```

Start a Nios command shell to have all Quartus tools in the PATH:

```bash
~/altera_pro/25.3/quartus/niosv/bin/niosv-shell
```

Now, we have creared a newer version of u-boot-spl-dtb.hex, which must be included in the bitstream file. To do so, follow the steps below: 

```bash 
cd $TOP_FOLDER/bitstreams
cp ../agilex7f-ed-gsrd/agilex_soc_devkit_ghrd/output_files/ghrd_agfb014r24b2e2v.sof ghrd2.sof
quartus_pfg -c ghrd2.sof ghrd2.rbf \
-o hps_path=../u-boot-socfpga/spl/u-boot-spl-dtb.hex \
-o hps=1 \
-o sign_later=ON
quartus_sign --family=agilex7 --operation=sign --qky=../keys/qky/sign0_cancel1.qky \
--pem=../keys/privatekeys/private_sign0.pem ghrd2.hps.rbf signed_bitstream_hps2.rbf 
```

To run the test, we need to set MSEL to JTAG, qkey, service key, and signed_bitstream_hps.rbf are downloaded via JTAG: 

```bash 
cd $TOP_FOLDER/ 
quartus_pgm -c 1 -m jtag -o "pi;keys/qky/root0.qky" 
quartus_pgm -c 1 -m jtag --service_root_key 
quartus_pgm -c 1 -m jtag -o "p;bitstreams/signed_bitstream_hps2.rbf" 
```

Once the required files are configured on board, the HPS terminal prints out the SPL output, a sample of this output can be seen below: 

```
U-Boot SPL 2025.07-ge5f40a8ed1ec-dirty (Nov 10 2025 - 09:29:16 -0500)
Reset state: Cold
MPU          1200000 kHz
L4 Main       400000 kHz
L4 sys free   100000 kHz
L4 MP         200000 kHz
L4 SP         100000 kHz
SDMMC          50000 kHz
DDR: 8192 MiB
SDRAM-ECC: Initialized success with 1707 ms

Testing input buffer: 
0 1 2 3 4 5 6 7 8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27 
Opening SDM Session 
SDM Session opened, ID= 0x21000001 -- ret_code= x0 
SDOS ENC with Session ID = 0x21000001 
Time spent for SDOS Encryption (timer_get_us)= 13 ms 
Testing Encryption Buffer: 
12 42 42 53 a0 7f 0 0 0 0 b 16 11 22 33 44 55 66 77 88 4 3 2 1 0 0 0 0 64 90 32 66 22 2d ae 94 66 23 57 6c 71 ab 3d 54 f 32 2c 5 3b 35 
SDOS Decryption with Session ID = 0x21000001 
Time spent for SDOS Decryption (timer_get_us)= 1 ms 
Testing Decryption Buffer: 
0 1 2 3 4 5 6 7 8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27 

QSPI: Reference clock at 400000 kHz 
WDT: Started watchdog@ffd00200 with servicing every 1000ms (10s timeout) 
Trying to boot from MMC1 
...
```

The output colored in blue is coming from the added code to the SPL source code. We can notice a print snapshot of the dummy input buffer, SDOS session open, AES encryption, print of encrypted data, AES decryption, retrieve the original data, and close the SDOS session. 

## Running SDOS from U-Boot 

To run SDOS from U-Boot, we need to use smc command in U-Boot command line environment. Before proceeding with the tests, we need to prepare the dummy data file offline using a Linux machine. To prepare the dummy data file, we use the following command: 

```bash 
dd if=/dev/urandom of=random.bin bs=1 count=32672 
```

Once the randm.bin file is created, we need to modify this file to include the sdos header at the top of it. Any hex editor can help us on that task, as seen in the image below. 

![](images/584f4dbef15b20db2c24399ef27cd187.png) 

Once the bin file is ready, we can store it in the sdcard. Then, boot the system, and interrupt the boot at U-Boot stage to enter U-Boot command line. The following commands can be used to run the test: 

1\. Load the random.bin file from the SDCARD: 

```bash 
fatload mmc 0:1 0x2000000 random.bin 
```

2\. Open SDOS Session: 

```bash 
smc c200006e 
```

3\. Send encryption command: 

```bash 
smc c2000090 21000001 55aa 1 02000000 7fc8 03000000 7ff8 
```

where: 

| Parameter | Description | 
| -- | -- | 
| c2000090 | INTEL_SIP_SMC_FCS_CRYPTION_EXT | 
| 21000001 | session ID | 
| 55aa | context ID | 
| 1 | operating mode (1 for encryption and 0 for decryption) | 
| 02000000 | physical address of the stored input original data | 
| 7fc8 | size of input data | 
| 03000000 | physical address of the output encrypted data | 
| 7ff8 | size of output encrypted data | 

4\. Send decryption command: 

```bash 
smc c2000090 21000001 55aa 0 03000000 7ff8 04000000 7fc8 
```

where: 

| Parameter | Description | 
| -- | -- | 
| c2000090 | INTEL_SIP_SMC_FCS_CRYPTION_EXT | 
| 21000001 | session ID | 
| 55aa | context ID | 
| 0 | operating mode (1 for encryption and 0 for decryption) | 
| 03000000 | physical address of the stored encrypted input data | 
| 7ff8 | size of input data | 
| 04000000 | physical address of the output original data | 
| 7fc8 | size of output encrypted data | 

5\. Close SDOS session: 

```bash 
smc c200006f 21000001 
```

Note: you can use *md* command to verify the memory locations of the input buffer, encrypted buffer, and decrypted buffer as below: 

**Open an SDOS session** 

```bash
SOCFPGA_AGILEX # smc c200006e 
Res: 0x0 0x0 0x21000001 0x0 
```

**Load the random.bin file to DDR memory** 

```bash
SOCFPGA_AGILEX # fatload mmc 0:1 0x2000000 random.bin 
32672 bytes read in 4 ms (7.8 MiB/s) 
```

**Read data from the input buffer address, with size of 50 objects** 
```bash
SOCFPGA_AGILEX # md.b 0x2000000 50 
02000000: ed bd bd ac a0 7f 00 00 00 00 0b 16 11 22 33 44 ............."3D 
02000010: 55 66 77 88 04 03 02 01 11 22 33 44 55 66 77 88 Ufw......"3DUfw. 
02000020: 11 22 33 44 55 66 77 88 00 01 02 03 04 05 06 07 ."3DUfw......... 
02000030: 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 14 15 16 17 ................ 
02000040: 18 19 1a 1b 1c 1d 1e 1f 49 b0 dd d4 9c 37 f2 1b ........I....7.. 
```

**Send SDOS encrypt command** 

```bash
SOCFPGA_AGILEX # smc c2000090 21000001 55aa 1 02000000 7fc8 03000000 7ff8 
Res: 0x0 0x0 0x3000000 0x7ff8 
```

**Read data from the encrypted input buffer address, with size of 50 objects** 
```bash
SOCFPGA_AGILEX # md.b 0x3000000 50 
03000000: 12 42 42 53 a0 7f 00 00 00 00 0b 16 11 22 33 44 .BBS........."3D 
03000010: 55 66 77 88 04 03 02 01 00 00 00 00 2d 19 d6 24 Ufw.........-..$ 
03000020: 1b 94 5f 96 1c 22 5b d4 4a fd be 60 ba 62 19 41 .._.."[.J..`.b.A 
03000030: e2 8d f2 84 ba 58 3d ca 29 af 42 9c 7b 4e 3c df .....X=.).B.{N<. 
03000040: f3 ae 6b b0 66 e6 c5 42 b8 49 96 56 16 70 24 88 ..k.f..B.I.V.p$. 
```

**Send SDOS decrypt command** 

```bash
SOCFPGA_AGILEX # smc c2000090 21000001 55aa 0 03000000 7ff8 04000000 7fc8 
Res: 0x0 0x0 0x4000000 0x7fc8 
```

**Read data from the decrypted buffer address, with size of 50 objects** 

```bash
SOCFPGA_AGILEX # md.b 0x4000000 50 
04000000: ed bd bd ac a0 7f 00 00 00 00 0b 16 11 22 33 44 ............."3D 
04000010: 55 66 77 88 04 03 02 01 00 00 00 00 2d 19 d6 24 Ufw.........-..$ 
04000020: 1b 94 5f 96 1c 22 5b d4 00 01 02 03 04 05 06 07 .._.."[......... 
04000030: 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 14 15 16 17 ................ 
04000040: 18 19 1a 1b 1c 1d 1e 1f 49 b0 dd d4 9c 37 f2 1b ........I....7.. 
```

**Close the SDOS session**

```bash
SOCFPGA_AGILEX # smc c200006f 21000001 
Res: 0x0 0x0 0x0 0x0
```