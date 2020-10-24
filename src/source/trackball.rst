The Trackball
=============

TODO: line art of trackball with callouts

The trackball uses the same microcontroller and LUFA framework as the keyboard_, but instead of scanning a matrix of switches, it gets X and Y movement coordinates from the PAT9125EL-TKIT optical sensor that is connected via I2C.

The trackball has five buttons. The top two buttons function as left and right mouse buttons, the lower center button maps to the middle mouse button.

Holding either the lower left or right buttons activates wheel mode, where vertical movement of the ball is translated into vertical mouse wheel events.

Firmware
--------

You can find the Reform trackball firmware_ in the source folder "reform2-trackball-fw".

The trackball firmware is based on the LUFA USB device library and implements a USB HID Mouse. To modify the behaviour of the trackball, edit the file Mouse.c and rebuild the firmware by typing the following command in a terminal:

.. code-block:: none

   make

Same as the keyboard, the trackball's MCU has to be in "Atmega DFU bootloader" USB mode.

Toggle the programming DIP switch SW7 to "ON" and press the reset button SW6.

The trackball will reappear as a Atmel DFU bootloader USB device. You can then upload your new firmware by executing:

.. code-block:: none

   ./flash.sh

.. _firmware: https://source.mntmn.com/MNT/reform/reform2-trackball-fw
.. _keyboard: ../keyboard/index.html

Schematics
----------

TODO
