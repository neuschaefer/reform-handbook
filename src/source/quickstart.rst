Quick Start
===========

Thank you for acquiring MNT Reform, a portable open-source computer system.

Reform can be powered either by the internal LiFePo4 battery or by the 5V wall adapter. The wall adapter will automatically charge the battery if present. For safety reasons, the battery cable is not connected by default. To use the battery, unscrew the bottom lid and plug the white battery cable plug into the battery connector on the motherboard. Then reattach the bottom lid.

To switch the system on, push the power switch (located on the front of the device) to the right. The i.MX6 QuadPlus_ System-on-Chip will try to boot from the internal SD card.

You should be greeted by U-Boot and the MNT logo in the upper right corner of the display. If not interrupted by a keypress, Reform will boot into the Debian GNU/Linux operating system that is preinstalled on the SD card. The kernel will show diagnostic information as it activates all the devices in the system, and you'll end up at the login prompt if everything is OK.

To log in, enter *root* as the username. There is no default password, so you should secure the root account by setting a password. After completing the setup process, you can do this by executing:

.. code-block:: none

   passwd

After the first login, the *setup* script will run and guide you through a few steps like setting the timezone, keyboard layout, network settings and so on.

From the console environment, you can:

- Format an mSATA SSD drive (if you put one in the mSATA slot) and install an OS to it
- Create standard user accounts
- Inspect or repair the system

To start the X windowing system, type:

.. code-block:: none

   xinit

By default, when using the root account, this will start the OpenBox window manager. You can change this by editing the file */root/.xinitrc*.

You can install additional software and desktop environments by using *apt*, for example *apt install firefox*. You can find more information about using apt by reading its manual page. Manual pages are accessed by executing *man programname*, for example:

.. code-block:: none

   man apt

Enjoy your Reform computer!

.. _QuadPlus: https://www.nxp.com/products/processors-and-microcontrollers/arm-based-processors-and-mcus/i.mx-applications-processors/i.mx-6-processors/i.mx-6quadplus-processor-quad-core-high-performance-advanced-3d-graphics-hd-video-advanced-multimedia-arm-cortex-a9-core:i.MX6QP
