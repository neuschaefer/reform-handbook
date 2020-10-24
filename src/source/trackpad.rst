The Trackpad
============

TODO: line-art render of trackpad with callouts

The trackpad uses the same microcontroller and LUFA framework as the keyboard_ and trackball_.

TODO: describe Azoteq captouch sensor

TODO: describe gestures for left/right/middle click and wheel

Firmware
--------

You can find the Reform trackpad firmware_ in the source folder "reform2-trackpad-fw".

The trackpad firmware is based on the LUFA USB device library and implements a USB HID Mouse. To modify the behaviour of the trackpad, edit the file Mouse.c and rebuild the firmware by typing the following command in a terminal:

.. code-block:: none

   make

For flashing, the MCU has to be in "Atmega DFU bootloader" USB mode.

Toggle the programming DIP switch SW7 to "ON" and press the reset button SW6.

The trackpad will reappear as a Atmel DFU bootloader USB device. You can then upload your new firmware by executing:

.. code-block:: none

   ./flash.sh

.. _firmware: https://source.mntmn.com/MNT/reform/reform2-trackpad-fw
.. _keyboard: ../keyboard/index.html
.. _trackpad: ../trackpad/index.html

Schematics
----------

TODO
