The Trackball
=============

.. image:: trackball.pdf
   :target: trackball.pdf

The trackball uses the same microcontroller and LUFA framework as the keyboard_, but instead of scanning a matrix of switches, it gets X and Y movement coordinates from the PMW3360DM-T2QU optical sensor that is connected via SPI.

Wheel Mode, Middle Click
------------------------

The trackball firmware has a special "wheel mode" that allows you to use it like a mouse wheel for scrolling or to perform a middle mouse click.

You can enter wheel mode by pressing the left button and then pressing the right button while keeping the left button pressed. Release both buttons. Rolling the ball up and down will send wheel up/down commands. Clicking the right button will perform a middle click. Clicking the left button will exit wheel mode.

Firmware
--------

You can find the Reform trackball firmware_ in the source folder "reform-trackball-fw".

The trackball firmware is based on the LUFA USB device library and implements a USB HID Mouse. To modify the behaviour of the trackball, edit the file Mouse.c and rebuild the firmware by typing the following command in a terminal:

.. code-block:: none
                
   make
   
As with the keyboard, the trackball's MCU has to be in "Atmega DFU bootloader" USB mode. This is achieved by shorting the pins HWB and GND with a jumper and then briefly shorting the RESET pin to ground. The pins are marked on the silkscreen of the main trackball PCB.

After a reset with HWB pulled to ground, The trackball will reappear as a Atmel DFU bootloader USB device. You can then upload your new firmware by executing:

.. code-block:: none
                
   ./flash.sh

.. _firmware: https://github.com/mntmn/reform/reform-trackball-fw
.. _keyboard: ../keyboard/index.html

Schematics
----------

.. image:: reform-trackballb.pdf
   :target: reform-trackbal
