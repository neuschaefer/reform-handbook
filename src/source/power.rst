The System Controller
=====================

Introduction
------------

Independent from the main processor module, a low-power processor sits on MNT Reform's motherboard. The NXP LPC11U24 is a 32-bit ARM Cortex-M0 CPU that uses very little power and is always on as long as there is battery or wall power in the system. We call this processor the System Controller.

The System Controller runs a bare metal program in an endless loop that has the following jobs:

- Powering the individual voltage rails of the system on and off (including the main processor's power and the mPCIe slot's power, to implement a WiFi-killswitch, for example)
- Hard resetting the main processor
- Monitoring the voltage of each battery cell
- Balancing battery cells. If a cell is overvolted, charging is halted and the overvolted cells are discharged until they are back to a nominal voltage
- Turning off the system if battery cells are undervolted
- Reporting total current flowing in and out of the batteries
- Turning charge current on or off

Communication
-------------

Your main way of talking to the System Controller is the Keyboard. The Keyboard has, aside from its USB connection to the main processor, a second serial (UART) connection/cable to the motherboard's SYSCTL port. A 57600 bps connection is always established between the Keyboard and the System Controller.

It accepts commands in the form of a single letter followed by return. A command can also be prefixed with a single argument, a positive integer of up to 4 digits. The most important commands are:

- *1p*: Turn the computer on
- *0p*: Turn the computer off
- *a*: Get current flowing into/out of batteries in mA
- *0v*: Get voltage of cell 0 (cells are numbered 0-7)
- *V*: Get system voltage at point of combined battery input/output
- *s*: Get System Controller state (a message string)
- *g*: Get estimated "fuel gauge" of batteries (percentage)

The individual cell voltages are measured by the Battery Monitor LTC6803IG-4#PBF and reported via SPI to the System Controller.

The total voltage and current are measured by the INA260 chip and reported via I2C to the System Controller.

To understand the available commands in more detail, you can take a look at the System Controller's handle_commands_ function.

TODO: Side note:
The System Controller is permanently connected to the main processor's UART2 (/dev/ttymxc1 in Linux). If you want to interrupt this connection for safety reasons, you can desolder resistors R48 and R50.

You can monitor the raw output of the System Controller going to the keyboard by connecting a terminal such as GNU Screen to the internal serial port UART2:

.. code-block:: none

   screen /dev/ttymxc1 57600

Flashing the Firmware
---------------------

You can find the source code of the firmware_ in the folder "reform2-lpc-fw" of the Reform source repository.

To change (flash) the firmware of the System Controller, you need another computer and a Micro-USB cable.

- TODO: drawing of where to connect the cable (Micro-USB connector on motherboard)

1. Set DIP switch LPCPROG to "ON"
2. Press button LPCRESET
3. Connect Micro-USB cable
4. System Controller's memory appears as virtual flash drive on secondary computer
5. Execute `flash.sh` and provide path to virtual flash drive
   TODO: Programming task: automatically find correct drive in flash script
6. Unplug cable
7. Set DIP switch LPCPROG to "OFF"
8. Press button LPCRESET

.. _firmware: https://source.mntmn.com/MNT/reform/reform2-lpc-fw
.. _handle_commands: https://source.mntmn.com/MNT/reform/reform2-lpc-fw/src/boards/reform2.c

Expansion Port
--------------

TODO: pinout and functions of "Hack the Planet" port.
