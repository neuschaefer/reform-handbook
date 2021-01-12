Advanced Topics
===============

Sub-Topics TODO:

- Encrypted SSD Setup
- SD vs eMMC Boot
- Loading other OSes

Debugging
---------

Power
+++++

To troubleshoot power, disconnect the internal battery and all internal and external peripherals, and connect the wall power adapter.

The i.MX8M processor module has a green LED. It has to light up to signal good power. The processor module only needs power on the main 5V rail to work, but with only 5V power it cannot talk to the SD card (which requires both 3V3 and 1V8 rails to work). Thus, you have to toggle the small DIP switch on the i.MX8M module to boot the from eMMC flash.

TODO: graph of power tree?

Reform can accept ~7V-32V of DC power on barrel jack J1. The nominal input voltage is 24V. If you can't measure the input voltage on R49, check if fuse F1 is blown.

Either input or battery power will be output by the buck-boost regulator/charger LTC4020 to the main system regulators. U14 is the always-on 3V3 regulator that powers critical chips like the System Controller (U18). Confirm input voltage on R1. Confirm LPC_VCC power with 3.3V on J22 pin 15. System Controller (TODO link to its chapter) has to have working firmware. If it is not responding to Keyboard commands, use a UART adapter on SYSCTL header J23 to talk to the System Controller directly (57600 baud 8N1).

Serial Console
++++++++++++++

The motherboard connector labelled SER1 is a serial port (UART) to which U-Boot and the Linux kernel output diagnostic information on startup. The baud rate is 115200.

Wire up a generic USB-to-UART adapter to the following pins of connector J18:

- **1** UART1_TXD, connect to RX of your adapter
- **2** UART1_RXD, connect to TX of your adapter
- **3** GND, connect to GND of your adapter

Then, use a terminal program such as screen on your host computer:

.. code-block:: none

   screen /dev/ttyUSB0 115200

If you then switch on Reform with a prepared SD card inserted, you should see the U-Boot console in *screen*.
  
System Boot (i.MX8M)
--------------------

U-Boot is a mini operating system and shell that allows you to inspect parts of the system (like PCIe, USB devices and Harddisks) and set up parameters to be passed to a "big" operating system kernel such as Linux, and start such an operating system.

U-Boot itself has to be compiled with the board support files for Reform. This is done by the ``mkuboot.sh`` script. The resulting file, processed to be in the correct format loadable by the i.MX8M processor is ``flash.bin``. This file has to be written to the boot medium at an offset of 33kB (33792 bytes).

U-Boot needs 2 files to boot Linux:

- The Linux kernel itself, named ``Image``.
- The device tree blob (DTB), called ``imx8mq-mnt-reform2.dtb``. This is a tree structure that lists the addresses of and parameters for all the devices in the system that Linux needs to initialize. The source for this file is ``imx8mq-mnt-reform2.dts``.

Booting the Linux Kernel
------------------------

Theoretically, you can boot other operating systems besides Linux, such as FreeBSD, NetBSD, OpenBSD or anything else that supports the i.MX8MQ SoC. This handbook covers only the Linux operating system.

TODO: explain boot process (load DTB and kernel)
