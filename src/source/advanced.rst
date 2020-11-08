Advanced Topics
===============

Sub-Topics TODO:

- Encrypted SSD Setup
- SD vs eMMC Boot
- Loading other OSes

i.MX8M Boot Process
-------------------

TODO: this section contains outdated i.MX6 info

Next, the i.MX6 chip will jump to internal boot ROM code at memory address *0x00000000*. The boot ROM looks for an SD card on port SD1 and reads the DCD (Device Configuration Data) table from physical address 0x400 (1024 decimal, or the second physical block) on the SD card. This means that you can only use the MBR partition scheme on the boot disk, as it only occupies the first disk block. The more modern GPT partition format could work in theory, but most GPT tools and parsers do not understand GPT structures where the second block is in an alternative location.

We recommend to use the SD card as a boot and rescue disk, and set up an mSATA SSD disk with your actual operating system and data. You can then use alternative partition schemes and encryption.

Reform ships with U-Boot. It is installed onto the SD card and includes the DCD block that configures the DDR memory parameters and clocks.

U-Boot
------

TODO: this section contains outdated i.MX6 info

U-Boot is a mini operating system and shell that allows you to inspect parts of the system (like PCIe, USB devices and Harddisks) and set up parameters to be passed to a "big" operating system kernel such as Linux, and start such an operating system.

U-Boot itself has to be compiled with the board support files for Reform. This is done by mkuboot.sh. The resulting file is u-boot.imx.

U-Boot is installed to the second block of the SD card using the "dd" utility by mkreform.sh.

U-Boot needs 2 files to boot Linux:

- The Linux kernel itself, normally called "zImage".
- The device tree blob (DTB), normally called "imx6qp-mntreform.dtb". It is a data structure that lists the addresses of and parameters for all the devices in the system that Linux needs to drive.

Both files are created when building Linux from source with the "imx6qp-mntreform.dts" source file included in the kernel tree. The helper script mkkernel.sh from https://github.com/mntmn/reform-bootstrap does it for you.

Booting the Linux Kernel
------------------------

TODO: this section contains outdated i.MX6 info

Theoretically, you could boot other operating systems besides Linux, such as FreeBSD, NetBSD, OpenBSD or anything else that supports the i.MX6QP SoC. So far, we didn't have the time to test them, though. We'll happily expand this guide with your contributions if you've managed to run an alternative OS on Reform.

The default boot commands for U-Boot are specified at https://github.com/mntmn/u-boot/blob/mntreform/include/configs/mntreform.h#L104

If you want to boot manually, these are the steps.

1. Configure the kernel command line to use no initial ram disk, use the first partition of the first SD card as the root volume (read/write), and wait for the root device. Also, set the continuous memory allocation (CMA) pool to 256MB and disable message signaled interrupts (MSI) for PCI express. The CMA pool is needed by the etnaviv GPU drivers. MSI has to be disabled for some expansions like ath9k-based WiFi cards.

.. code-block:: none
                
   setenv bootargs noinitrd root=/dev/mmcblk0p1 rw rootwait cma=256M pci=nomsi no_console_suspend=1

2. Set the maximum address/size for the device tree structure (called FDT in U-Boot, DTS/DTB in Linux). The kernel can fail to start without this.

.. code-block:: none
                
   setenv fdt_high 0xffffffff

3. Load the Kernel (zImage) to address 0x10008000 from the SD card (also called "MMC") device 0, partition 1 (there is no partition 0, 1 is the first). ext4load works for ext4 formatted partitions. For FAT, you would use fatload.

.. code-block:: none
                
   ext4load mmc 0:1 0x10008000 zImage

4. Load the device tree (FDT/DTB) to address 0x18000000 from the same partition.

.. code-block:: none
                
   ext4load mmc 0:1 0x18000000 imx6qp-mntreform.dtb

5. Tell U-Boot where you just loaded the FDT and to please resize it.

.. code-block:: none
                
   fdt addr 0x18000000
   fdt resize

6. Start Linux from the load address and pass the FDT address to it.

.. code-block:: none
                
   bootz 0x10008000 - 0x18000000
