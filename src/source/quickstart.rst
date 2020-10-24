Quick Start
===========

Thank you for acquiring MNT Reform, a portable open-source computer system.

Reform can be powered either by the internal LiFePo4 batteries or by the 24V wall adapter. The wall adapter will automatically charge the battery if present. For safety reasons, the battery cables are not connected by default. To use the batteries, unscrew the bottom lid and plug the battery cable plugs into the battery connectors on the motherboard. Then reattach the bottom lid.

To turn the system on and off (hard power enable/disable) press Circle-1 or Circle-0 (zero),
respectively. Circle-1 also does a hard reset of the main SoC if the system is already on.
To display cell voltage information, press Circle-V.

Circle-F1 and Circle-F2 decrease and increase the keyboard backlight brightness (but only if the main
CPU/USB hub is powered).

Reform will boot into the Debian GNU/Linux operating system that is preinstalled on the SD card. The kernel will show diagnostic information as it activates all the devices in the system, and you'll end up at the login prompt if everything is OK.

To log in, enter *root* as the username. There is no default password, so you should secure the root account by setting a password. After completing the setup process, you can do this by executing:

.. code-block:: none

   passwd

After the first login, the *reform-help* script will run and guide you through a few steps like setting the timezone, keyboard layout, network settings and so on.

From the console environment, you can:

- Format a NVMe SSD drive (if you put one in the NVMe slot) and install an OS to it
- Create standard user accounts
- Inspect or repair the system

To start the sway graphical environment, type:

.. code-block:: none

   sway

You can install additional software and desktop environments by using *apt*, for example *apt install firefox*. You can find more information about using apt by reading its manual page. Manual pages are accessed by executing *man programname*, for example:

.. code-block:: none

   man apt

Enjoy your MNT Reform computer!
