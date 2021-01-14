Advanced Topics
===============

Troubleshooting
---------------

If MNT Reform should stop booting, the recommended strategy is to strip it down to a minimal system and check for output on the serial/UART console.

First, disconnect the internal battery and all external peripherals.

Serial Console
++++++++++++++

The motherboard connector labelled SER1 is a serial port (UART) to which U-Boot and the Linux kernel output diagnostic information on startup. The baud rate is 115200, 8N1.

Wire up a generic USB-to-UART adapter to the following pins of connector J18:

=== ========================================
Pin Function
=== ========================================
1   UART1_TXD, connect to RX of your adapter
2   UART1_RXD, connect to TX of your adapter
3   GND, connect to GND of your adapter
=== ========================================

Then, use a terminal program such as ``screen`` on your host computer:

.. code-block:: none

   screen /dev/ttyUSB0 115200

If you then switch on Reform (powered by the wall adapter) with the provided SD card inserted, you should see the U-Boot console in ``screen``.

Power Rails
+++++++++++

Reform can accept ~7V-32V of DC power on barrel jack J1. The nominal input voltage is 24V. If you can't measure the input voltage on R49, check if fuse F1 is blown.

The i.MX8M processor module has a green LED. It has to light up to signal good power (5V rail). The processor module only needs power on the main 5V rail to work, but with only 5V power it cannot talk to the SD card (which requires both 3V3 and 1V8 rails to work). Thus, you can toggle the DIP switch on the i.MX8M module to try booting from the eMMC flash.

Either wall or battery power will be regulated to ~28V by the buck-boost regulator/charger LTC4020 and output to the main system regulators. U14 is the always-on 3V3 regulator that powers critical chips like the System Controller (LPC11U24, U18). Confirm input voltage on R1. Confirm LPC_VCC power with 3.3V on J22 pin 15.

TODO: improve this section

SYSCTL
++++++

The System Controller has to have working firmware to turn on the main power rails. If it is not responding to OLED menu / Circle Key commands, you can use a UART adapter on SYSCTL header J23 to talk to the System Controller directly (57600 baud 8N1). To do this, you'll need to solder/crimp an adapter cable with a JST-PH plug.

System Boot
-----------

i.MX8MQ will try to load boot code from either the eMMC flash on the module or from the SD card (default), depending on the setting of the DIP switch on the Nitrogen8M_SOM module. MNT Reform comes with the U-Boot bootloader on both the eMMC and on the SD Card.

U-Boot is a mini operating system and shell that allows you to inspect parts of the system (like PCIe, USB devices or Ethernet) and set up parameters to be passed to the real operating system kernel such as Linux, and start it.

U-Boot itself has to be compiled with the board support files for Reform. This is done by the ``mkuboot.sh`` script that is part of the ``reform-system-image`` repository. The resulting file, processed to be in the correct format loadable by the i.MX8MQ processor is ``flash.bin``. This file has to be written to the boot medium at an offset of 33kB (33792 bytes).

U-Boot needs 2 files to boot Linux:

- The Linux kernel itself, named ``Image``.
- The device tree blob (DTB), which depends on the CPU module. For i.MX8MQ, this is called ``imx8mq-mnt-reform2.dtb``. The device tree is a data structure that lists the addresses of and parameters for all the devices in the system that Linux needs to initialize drivers for. The source for this file is ``imx8mq-mnt-reform2.dts``, and it is compiled to the DTB as part of the Linux kernel tree (where it resides in (``arch/arm64/boot``).

Theoretically, you can boot other operating systems besides Linux, such as FreeBSD, NetBSD, OpenBSD or anything else that supports the i.MX8MQ SoC. This handbook covers only the Linux operating system, but you can -- if drivers exist -- boot any of these operating systems from U-Boot.

The default boot script will load the DTB and Kernel Image from the SD card using the following command:

.. code-block:: none

   ext4load mmc 1 ${loadaddr} /Image
   ext4load mmc 1 ${fdt_addr} /imx8mq-mnt-reform2.dtb
   booti ${loadaddr} - ${fdt_addr}

This means that the Kernel and DTB files reside in the root directory of the boot medium, which has to be the first partition, Ext4 formatted.

You can interrupt this script within the first second of boot by sending a character (key press) via the SER1 UART and type ``help`` to get a list of supported commands. You can inspect all environment variables with the ``printenv`` command.

The Linux kernel parameters are passed via the ``bootargs`` U-Boot environment variable:

.. code-block:: none

   noinitrd root=/dev/mmcblk1p1 rootwait rw
     console=ttymxc0,115200 console=tty1 cma=512M
     pci=nomsi

This tells the kernel to mount the root filesystem from the ``mmcblk1p1`` device, which is the first partition on the SD card. To boot from the second partition, for example, you would change this to ``mmcblk1p2``. ``mmcblk0...`` is the eMMC flash. ``ttymxc0`` is the serial UART SER1. ``cma=512M`` sets up a memory area for contiguous allocation for the GPU. ``pci=nomsi`` turns off message-signaled interrupts (MSI) for the PCIe controller, which helps with some WiFi cards.

Operating System on NVMe
------------------------

If you want to mount your root filesystem from an NVMe disk, you only need to partition it and copy the Linux filesystem to it. One way to do this is to copy the existing Linux system from the SD card to an NVMe disk.

First mount the target disk at ``/mnt`` (as root):

.. code-block:: none

   mount /dev/nvme0n1p1 /mnt/

Then, copy the operating system and all your files (as root):

.. code-block:: none

   rsync -axHAWXS --numeric-ids --info=progress2 / /mnt/
   umount /mnt

Encrypted NVMe
++++++++++++++

If you want to protect the data on your NVMe disk in case you lose your MNT Reform, you can encrypt it with LUKS. You can do that manually or use the ``gnome-disks`` tool.

Copy your filesystem to the encrypted disk like above, but substituting ``nvme0n1p1`` for the corresponding LUKS device mapper name.

To let Linux load your root filesystem from your encrypted disk, you need a way to enter the decryption passphrase at boot time. The provided script ``/sbin/reform-init`` (on the SD card or eMMC) can handle this for you. Edit it to your liking and then change the kernel parameters in U-Boot:

.. code-block:: none

   setenv bootargs noinitrd root=/dev/mmcblk1p1 rootwait
     rw console=ttymxc0,115200 console=tty1 cma=512M
     pci=nomsi init=/sbin/reform-init
   saveenv
   boot

TODO: Provide an easier/automated way of doing this.
