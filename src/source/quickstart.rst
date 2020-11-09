Quick Start
===========

TODO:

- Show how to open the bottom and connect the batteries (illustartions)
- Review First boot / first steps

**Brendan questions/comments:** are there details about unboxing process to include? can we link to or include DIY assembly instructions? will the circle key shortcut guide be part of the shipping firmware...if so should mention here. for completeness, should list all the Circle commands in the handbook as well. I also think we should include networking setup details before mentioning using apt.

Thank you for acquiring **MNT Reform**, a portable, open-source computer system.

Reform can be powered either by the internal LiFePo4 batteries or by the 24V wall adapter.  The wall adapter will automatically charge the battery when plugged into the port on Reform's left hand side.  

For safety reasons, the battery cables are not connected . To use the batteries, unscrew the bottom lid and plug the battery cable plugs into the battery connectors on the motherboard. Then reattach the bottom lid.

To turn the system on and off (hard power enable/disable) press Circle+1 or Circle+0 (zero),
respectively. Circle+1 also does a hard reset of the main SoC if the system is already on.

To display battery state of charge information, press Circle+V.

Circle+F1 and Circle+F2 decrease and increase the keyboard backlight brightness when system power is on.

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

Your MNT computer is now ready to be used! If you are new to the Debian GNU/Linux operating system, please refer to the Linux Basics section to learn more. 
