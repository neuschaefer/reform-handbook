Advanced Topics
===============

Sub-Topics TODO:

- Encrypted SSD Setup
- SD vs eMMC Boot
- Loading other OSes

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
