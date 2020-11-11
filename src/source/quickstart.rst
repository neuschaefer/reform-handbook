Quick Start
===========

TODO:

- Show how to open the bottom and connect the batteries (illustartions)
- Review First boot / first steps

Thank you for acquiring **MNT Reform**, a portable, open-source computer system.

Step 1: Connect Batteries
-------------------------
For safety reasons, the battery cables are not connected by default. 

Remove the bottom lid and attach the battery cable plugs to the battery connectors on the motherboard, then reinstall the bottom lid.

Step 2: Turn On
---------------
Insert the included SD card into the slot on the left hand side of the device.

To turn Reform on, press **Circle+1**. The Circle button is used for many system commands. Press and hold **Circle** to see a list of functions on Reform's OLED screen.

Step 3: Boot the Operating System
---------------------------------
When powered on, Reform will boot the operating system on the included SD card. The kernel will show diagnostic information as it activates all the devices in the system, and you'll end up at the login prompt if everything is OK.

To log in, enter *root* as the username at the prompt. There is no default password. To set a password, execute the following:

.. code-block:: none

   passwd

After the first login, enter the *reform-help* command. This will guide you through selecting a time zone, keyboard layout, and network configuration.

To start the Sway graphical environment, type:

.. code-block:: none

   sway

From here, you can begin installing software and using Reform. If you are new to the Debian GNU/Linux operating system, or Sway, please refer to the Linux Basics section to learn more. 
