### **Connecting with a Web Browser**

* Power up the Modular Development Kit (if not already powered) and set up the
  serial terminal emulator (minicom, [TeraTerm], [PuTTY], etc.):
  * Select the correct `COMx` port. (The Modular Development Kit presents 4
    serial COM ports over a single connection and the Linux system uses the 3rd
    port in order). Set the port configuration as follows:
    * 115200 baud rate, 8 Data bits, 1 Stop bit, CRC and Hardware flow control
      disabled.
* The Linux OS will boot and the Camera Solution System Example Design Software
  Application should run automatically.
* A few seconds after Linux boots, the Software Application will detect the
  attached Monitor and the ISP processed output will be displayed using the
  best supported format.
* Take note of the Modular Development Kit's IP address.
  * The IP address can also be found using the terminal by logging in as `root`
    (no password required) and querying the Ethernet controller:

    ```bash
    root
    ifconfig
    ```

  * `eth0` provides the IPv4 or IPv6 address to connect to.
<br/>

![ed-conn](../camera_4k_resources/images/Setup/ifconfig-dhcp.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**An Example ifconfig Output for a DHCP Network**
</center>

<br/>

![ed-conn](../camera_4k_resources/images/Setup/ifconfig-direct.png){:style="display:block; margin-left:auto; margin-right:auto;"}

<center markdown="1">

**An Example ifconfig Output for a Network with no DHCP support or is using a direct connection**
</center>

<br/>

* Connect your web browser to the boards IP address so you can interact with
  the Camera Solution System Example Design using the GUI.
  * To connect using IPv6 in the example address shown above, you would use
    `http://[fe80::a8bb:ccff:fe55:6688]` (note the square brackets)
  * To connect using IPv4 for the DHCP example shown above, you would use
    `http://192.168.0.1`

<br/>

![ed-conn](../camera_4k_resources/images/Setup/Browser-IPv6.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**An Example Web Browser URL for an IPv6 Address**
</center>

<br/>

![ed-conn](../camera_4k_resources/images/Setup/Browser-IPv4.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**An Example Web Browser URL for an IPv4 address**
</center>

<br/>

* During connection, you will see the Altera® splash screen, after which you
  will be presented with the Web GUI.

<br/>

![ed-conn](../camera_4k_resources/images/Setup/UI-screen.png){:style="display:block; margin-left:auto; margin-right:auto;"}
<center markdown="1">

**An Example Camera Solution System Example Design GUI**
</center>

<br/>
