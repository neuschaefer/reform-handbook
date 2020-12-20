Quick Start
===========

Step 1: Connect Batteries
-------------------------
.. image:: _static/illustrations/2t-callouts.png

To prevent discharge during shipment, the battery cables are not connected by default. Unscrew the 10 bottom screws and remove the bottom lid. Attach the two battery cable plugs to the battery connectors on the motherboard, then reinstall the bottom lid.

Step 2: Turn On
---------------
Insert the included SD card into the slot on the left hand side of the device.

.. image:: _static/illustrations/5t-callouts.png

To turn Reform on, press **Circle** and **1**. The **Circle** key is used for system control commands. Press and hold **Circle** to see a list of functions on the OLED screen embedded in the keyboard.

Step 3: Log In
--------------
When powered on, the main processor will boot the operating system on the included SD card. The kernel will show diagnostic information as it activates all the devices in the system, and you will end up at the login prompt if everything is OK. To log in, enter *root* as the username at the prompt. There is no default password. To set a password, execute the following:

.. code-block:: none

   passwd

From here, you can begin installing software and using MNT Reform. If you are new to the Debian GNU/Linux operating system, please refer to the :ref:`Linux Basics` section to learn more.
