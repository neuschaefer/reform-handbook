The Keyboard
============

TODO: line-art render of the keyboard module with callouts of ports and buttons

The keyboard is a row/column matrix scanner with anti-ghosting diodes on each switch. Each row and column is connected to one pin of the ATMega32U4_ 8-bit microcontroller. This microcontroller runs a firmware based on LUFA_. This converts the scanned out keycodes to the USB HID protocol.

Firmware
--------

You can find the Reform keyboard firmware_ in the source folder "reform2-keyboard-fw".

To modify the scancodes of the keyboard matrix, edit the file Keyboard.c and rebuild the firmware by typing the following command in a terminal:

.. code-block:: none

   make

To be able to flash the firmware to the keyboard, the ATMega has to be in a special mode where it identifies as an "Atmega DFU bootloader" USB device.

Toggle the programming DIP switch SW84 to "ON" and press the reset button SW83.

The keyboard will reappear as a Atmel DFU bootloader USB device. You can then upload your new firmware by executing:

.. code-block:: none

   ./flash.sh

Backlight
---------

TODO: describe how the backlight works and that it can be controlled by key combinations.

OLED
----

TODO: describe OLED functionality (this has a lot of cross links to System Controller, because the OLED together with the keyboard's Circle key is the front end to the System Controller).

Replacing a Keycap
------------------

.. image:: _static/illustrations/22t.png

You can easily pull out individual keycaps with your fingernails or better, using a keycap puller.

Replacing a Keyswitch
---------------------

Set your iron/station to ~380 degrees and dissolve the solder of one pin. Try to pull out the corresponding side of the switch from the top while continuing to heat the pin. Repeat the same for the other pin and go back and forth until you can remove the switch.

Replace with model Kailh Choc Brown, also known as CPG135001D02.

.. _LUFA: http://www.fourwalledcubicle.com/files/LUFA/Doc/170418/html/
.. _ATMega32U4: http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7766-8-bit-AVR-ATmega16U4-32U4_Datasheet.pdf
.. _firmware: https://source.mntmn.com/MNT/reform/reform2-keyboard-fw

Keyboard Schematics
-------------------

TODO
