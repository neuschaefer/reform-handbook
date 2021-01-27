Advanced Topics
===============

Troubleshooting
---------------

Here are some things you can try if MNT Reform should stop booting (in order of increasing difficulty):

- Press *Circle*, then *0* (zero), then *1* (one) to power cycle the system and wait at least 30 seconds.
- Remove the Bottom Plate and press the LPC_RST button on the motherboard to reset the System Controller.
- Download the MNT Reform System Image from the MNT Research website and flash it to a fresh SD Card. Then try to boot from this SD Card.
- Try to boot from the backup system on eMMC (see *System Boot* below).
- Strip MNT Reform down to a minimal system (remove all peripherals) and check for output on the serial/UART console.
- Measure individual power rails (only for advanced users with electronics knowledge).

As always, before working with MNT Reform internals, first disconnect the internal battery and external power and peripherals.

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

Reform will accept 9-32V of DC power on barrel jack J1. The nominal input voltage is 24V. If you can't measure the input voltage on R49, check if fuse F1 is blown.

Either wall or battery power will be regulated to ~29V by the buck-boost regulator/charger LTC4020 and output to the main system regulators. U14 is the always-on 3V3 regulator that powers critical chips like the System Controller (LPC11U24, U18). You can confirm LPC_VCC power with 3.3V on J22 pin 15.

Two white indicator LEDs on the motherboard, D11 and D12, signal that 3.3V and 5V rails are turned on, respectively.
The i.MX8M processor module has a green LED that signals 5V power arriving at the module. Because of the level shifters U28 and U8, booting from the SD card requires both 3.3V and 1.8V rails to work. You can measure 1.8V on C130, for example. Booting from eMMC requires only 5V power to go into the CPU module.

The USB hub U9 and the MIPI to eDP converter U10 also need 1.2V power to work (measure on C37). The display itself requires the 3V3_PWR_AUX (3.3V) and USB_PWR (5V) rails to be switched on by the System Controller.

SYSCTL
++++++

The System Controller has to have working firmware to turn on the main power rails. If it is not responding to OLED menu / Circle Key commands, you can use a UART adapter on SYSCTL header J23 to talk to the System Controller directly (57600 baud 8N1). To do this, you'll need to solder/crimp an adapter cable with a JST-PH plug.

System Boot
-----------

i.MX8MQ will try to load boot code from either the eMMC flash on the module or from the SD card (default), depending on the setting of the DIP switch on the Nitrogen8M_SOM module. MNT Reform comes with the U-Boot bootloader on both the eMMC and on the SD Card.

U-Boot is a mini operating system and shell that allows you to inspect parts of the system (like PCIe, USB devices or Ethernet) and set up parameters to be passed to the real operating system kernel such as Linux, and start it.

U-Boot itself has to be compiled with the board support files for Reform. This is done by the ``mkuboot.sh`` script that is part of the ``reform-system-image`` repository. The resulting file, processed to be in the correct format loadable by the i.MX8MQ processor is ``flash.bin``. This file has to be written to the boot medium at an offset of 33kB (33792 bytes).

The build process combines the following files into ``flash.bin``:

- Synopsys DDR4 calibration firmware ``lpddr4_pmu_train_*.bin`` (no source available)
- Cadence HDMI controller firmare ``signed_hdmi_imx8m.bin`` (no source available, optional)
- ARM trusted firmware "TF-A" ``bl31-iMX8MQ.bin`` (open source)
- The u-boot binary (open source)

U-Boot needs 2 files to boot Linux:

- The Linux kernel itself, named ``Image``.
- The device tree blob (DTB), which depends on the CPU module. For i.MX8MQ, this is called ``imx8mq-mnt-reform2.dtb``. The device tree is a data structure that lists the addresses of and parameters for all the devices in the system that Linux needs to initialize drivers for. The source for this file is ``imx8mq-mnt-reform2.dts``, and it is compiled to the DTB as part of the Linux kernel tree (where it resides in (``arch/arm64/boot``).

Theoretically, you can boot other operating systems besides Linux, such as FreeBSD, NetBSD, OpenBSD or anything else that supports the i.MX8MQ SoC. This handbook covers only the Linux operating system, but you can---if drivers exist---boot any of these operating systems from U-Boot.

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

To make this process more convenient for you, you can use the provided interactive script ``reform-migrate`` to migrate your MNT Reform operating system and files to a different disk:

.. code-block:: none

   sudo /sbin/reform-migrate
