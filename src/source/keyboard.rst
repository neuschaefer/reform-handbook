The Keyboard
============

.. image:: keyboard.pdf
   :target: keyboard.pdf


The keyboard is a row/column matrix scanner with anti-ghosting diodes on each switch. Each row and column is connected to one pin of the ATMega32U4_ 8-bit microcontroller. This microcontroller runs a firmware based on LUFA_. This converts the scanned out keycodes to the USB HID protocol.

Firmware
--------

You can find the Reform keyboard firmware_ in the source folder "reform-keyboard-fw".

To modify the scancodes of the keyboard matrix, edit the file Keyboard.c and rebuild the firmware by typing the following command in a terminal:

.. code-block:: none
                
   make
   
To be able to flash the firmware to the keyboard, the ATMega has to be in a special mode where it identifies as an "Atmega DFU bootloader" USB device. This is achieved by shorting the pins HWB and GND with a jumper and then briefly shorting the RESET pin to ground.

The RESET pin is pin 2 of J1, pin 1 is GND.

HWB and GND are pins 3 and 4 of J3, respectively. Start counting at the "J3" label. 

The keyboard will reappear as a Atmel DFU bootloader USB device. You can then upload your new firmware by executing:

.. code-block:: none
                
   ./flash.sh

Replacing a Keycap
------------------

The keycaps of the Reform beta units are printed with Clear Resin on Formlabs Form2 printers and then sanded by hand. Small irregularities are normal and a result of this process. The stems of the square 1x1 keycaps are slightly wider than the stems of other keycaps to make them more stable. This makes them harder to remove without breaking a stem. If a stem breaks inside of the keyswitch, you'll have to replace the keyswitch (see the following section).

To pull out bigger keycaps, use pincers and try to push them between the top of the switch and the cap and wiggle very carefully and evenly until you can pull out the cap.

There are some companies who produce "standard" Cherry ML keycaps, such as GMK_.

Replacing a Keyswitch
---------------------

Only 2 of the 4 Cherry ML switch pins are soldered in to make it easier to swap switches with just a soldering iron. Set your iron/station to 380 degrees and dissolve the solder of one pin. Try to pull out the corresponding side of the switch from the top while continuing to heat the pin. Repeat the same for the other pin and go back and forth until you can remove the switch.

Replace with model Cherry ML1A-11JW.

.. _LUFA: http://www.fourwalledcubicle.com/files/LUFA/Doc/170418/html/
.. _ATMega32U4: http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7766-8-bit-AVR-ATmega16U4-32U4_Datasheet.pdf
.. _GMK: https://www.gmk-electronic-design.de/en.html
.. _firmware: https://github.com/mntmn/reform/reform-keyboard-fw

Keyboard Schematics (Matrix)
----------------------------

.. image:: reform-keyboard-page-1b.pdf
   :target: reform-keyboard-page-1.pdf

Keyboard Schematics (Controller)
--------------------------------

.. image:: reform-keyboard-page-2b.pdf
   :target: reform-keyboard-page-2.pdf
