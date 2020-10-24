Reference: Mechanical
+++++++++++++++++++++

The Case
========

The black-anodized and sand-blasted aluminum case, designed by industrial designer Ana Dantas, is one of the aspects of Reform we’re the most proud of. We made one more iteration to improve haptics and assembly ergonomics/speed and ended up with 5 CNC milled parts:

**Screen back:** housing the display and upper half of hinges
**Screen front:** housing speakers and providing display bezel
**Main box:** to which all PCBs (printed circuit boards) are attached via M2 screws: The keyboard from the top and motherboard, trackball/trackpad, and battery boards from the bottom. The lower half of the hinges and the system controller OLED PCB are mounted from the top as well.
**Main box top:** a thin part that provides a bezel for the keyboard and the system controller OLED
**Main box bottom:** the bottom lid that is either milled from clear acrylic or aluminum

For easy (dis)assembly, Reform uses only M2 screws with Phillips-head everywhere (with one exception: M4 on the hinges).

When closed, the case is held shut by 8 little neodymium bar magnets which are located in the front edge of the screen enclosure and in the front of the main box.


Main Box
--------

.. image:: ports.pdf
           
The main box contains most of the electronics:

- Reform Motherboard, exposing ports through openings on the left
- Power switch/cable assembly, connecting to motherboard header J22
- LiFePo4 battery, connecting to header J33
- Reform Keyboard, connecting to header J12 (internal USB)
- Reform Trackball, connecting to header J9 (internal USB)

Main Box Top
------------

.. image:: mainbox_top.pdf

The main box top is pressed onto the main box to close it from the top. It acts as a palm rest and bezel for the keyboard and trackball. The keyboard is slided into this part's keyboard slot from the right.

Screen Back
-----------

.. image:: screen_back.pdf

The display is mounted on the screen back with M2x4 screws. The left and right hinges are mounted in the bottom left and right corners with M4x5 screws.

Screen Front
------------

.. image:: screen_front.pdf
           
This part serves as a bezel for the display and holds the case closing strap. It also has a magnet attached to it on the lower left that is sensed by the lid sensor. The screen front is mounted to the back with M3x6 screws.

Screen Support
--------------

.. image:: screen_support.pdf
           
The screen support connects the main box to the screen via the hinges. The display's LVDS (motherboard header J14) and power cable (motherboard header J26) is passed through this part, as well as the lid sensor cable (J34).

Screen Support Lid
------------------

.. image:: screen_support_lid.pdf
           
This is a thin part covering the screen support's top. On the left, it contains a pocket for the hall effect sensor that detects the magnet on the screen front. The sensor signals opening and closing of the lid.

Keyboard Closure
----------------

This part is inserted into the main box top after the keyboard to secure it in place.

Grid Plate
----------

This lasercut acrylic part is sandwiched between the main box' inner top and the motherboard. It has the mounting holes for the motherboard and other internal devices and isolates the motherboard from the keyboard.

Bottom Plate
------------

The bottom plate closes the main box from the bottom. It contains mounting holes for the fan and vent holes for the fan's air intake. The fan is connected to motherboard header J15 before screwing in the plate.

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

The Trackball
=============

The trackball has five buttons. The top two buttons function as left and right mouse buttons, the
lower center button maps to the middle mouse button. Holding either the lower left or right buttons
activates wheel mode, where vertical movement of the ball is translated into vertical mouse wheel
events. The lower left button also generates a left click, but this will probably change in future
versions.

The trackball is optical. We noticed that in direct bright sunlight, the optical sensor can be
overwhelmed and works only if you block the sunlight with your other hand. This will be fixed by
changing the trackball holder to a non-translucent material.

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

