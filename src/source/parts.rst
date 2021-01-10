Reference: Parts and Schematics
+++++++++++++++++++++++++++++++

Case Parts
==========

The case consists of the following 5 parts. All parts except the bottom plate are milled from sand-blasted and anodized 6061 aluminum.

1. **Screen Back:** housing the display and upper half of hinges
2. **Screen Front:** housing speakers and providing display bezel
3. **Main Box:** the chassis of MNT Reform. All PCBs (printed circuit boards) are attached to it via screws: The keyboard from the top and motherboard, trackball/trackpad, and battery boards from the bottom. The lower half of the hinges and the system controller OLED PCB are mounted from the top as well.
4. **Keyboard Frame:** a thin rectangle that covers the sides of the keyboard and the system controller OLED
5. **Bottom Plate:** the clear acrylic bottom lid

For easy (dis)assembly, Reform uses only M2 screws with Phillips-head everywhere -- with one exception: M4x5 on the top half of the hinges.

When closed, the case is held shut by 4 little neodymium bar magnets which are located in the front edge of the screen enclosure and in the front of the main box.

TODO: mention that hinges can be opened >180 degrees

Main Box
--------
.. image:: _static/illustrations/17t.png

The main box contains most of the electronics:

- Motherboard, exposing ports through openings on the left and right
- Two LiFePo4 battery packs, connecting to motherboard via Molex PicoLock cables
- Keyboard, connecting to the motherboard via two JST-PH cables
- OLED display, connecting to the keyboard via a 4-pin 1mm pitch flex cable
- Trackball or Trackpad, connecting to motherboard via one JST-PH cable

Keyboard Frame
--------------

.. image:: _static/illustrations/23t.png

The Keyboard Frame is inserted into the main box to close it from the top. It has four protruding ledges on the front that go first. The frame is mounted with six M2x6 flathead screws.

Screen Back
-----------

.. image:: _static/illustrations/14t.png

The eDP display panel rests in this case part. The left and right hinges are mounted in the bottom left and right corners with three M4x5 flathead screws each.

The stereo speakers are mounted below the display and secured with the speaker holders. Each holder is mounted with two M2x4 flathead screws.

Both speaker and display cable are fed through a hollow part in the hinge and into the main box.

Four little neodymium magnets are mounted along the top edge. These, together with their counterparts in the main box, hold the laptop shut when closed.

Screen Front
------------

.. image:: _static/illustrations/16t.png

This part serves as a bezel for the display. It is mounted with seven M2x6 flathead screws to the Screen Back.

Bottom Plate
------------

TODO: illustration

The bottom plate closes the main box from the bottom with ten M2x6 flathead screws.

Motherboard
===========

.. image:: _static/illustrations/3t.png

TODO: callouts of important parts and connectors.

The motherboard spans the complete inner width of the device (around 27 cm) and ends with external ports on both sides. It has the following features:

- **Power system:** includes a charger for LiFePO4 cells and seamlessly switches between wall and battery power.
- **System controller:** coupled to the power system, an NXP LPC11U24 Cortex-M0 MCU controls an analog monitor chip for the eight battery cells as well as the charger. It is connected to the SoM via SPI, and has GPIO lines to the main power rail switchers in the system. It has a UART (serial port) that the keyboard can talk to directly for issuing power on/off commands and battery status queries.
- **DSI to eDP converter:** it was an important goal for us to make the main display path for Reform blob-free, so we couldn't use the existing HDMI/DisplayPort block in i.MX8M to drive the internal display, because this needs a chunk of firmware related to content protection. Instead, we're using the MIPI DSI output and convert its signal to eDP using a Texas Instruments SN65DSI86 chip. All involved drivers are open and in mainline Linux.
- **USB 3.0 hub:** i.MX8M has 2x USB 3.0 controllers. As we need two internal USB ports for the keyboard and trackball (or trackpad) and wanted to provide three external USB ports, we put a Texas Instruments TUSB8041 USB hub chip on the board that provides the extra ports. We have USB load switches on each external port to protect from too much current draw.
- **Sound system:** the Reform motherboard features a Wolfson/Cirrus WM8960 audio DAC (digital-to-analog converter)/amplifier interfacing to the headphone/microphone jack and powering two speakers housed below the main display.
- **M.2 slot:** a PCIe clock synthesizer on the board provides a reference clock for one or both PCIe 2.0 controllers in i.MX8M. We put one M.2 M-key slot on the board that can house a high-speed NVMe SSD.
- **mPCIe slot:** the other PCIe controller drives an mPCIe connector that you can use for expansions like a Wi-Fi card (included in the Reform Max pledge level), an embedded graphics card or an FPGA board, for example.

System Controller
-----------------

Independent from the main processor module, a low-power processor sits on MNT Reform's motherboard. The NXP LPC11U24 is a 32-bit ARM Cortex-M0 CPU that uses very little power and is always on as long as there is battery or wall power in the system. We call this processor the System Controller.

The System Controller runs a bare metal program in an endless loop that has the following jobs:

- Powering the individual voltage rails of the system on and off (including the main processor's power and the mPCIe slot's power, to implement a WiFi-killswitch, for example)
- Hard resetting the main processor
- Monitoring the voltage of each battery cell
- Balancing battery cells. If a cell is overvolted, charging is halted and the overvolted cells are discharged until they are back to a nominal voltage
- Turning off the system if battery cells are undervolted
- Reporting total current flowing in and out of the batteries
- Turning charge current on or off

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

Install a mPCIe Card (WiFi)
---------------------------

TODO: illustration

Install an M.2 Card (SSD)
-------------------------

TODO: illustration

Exchange the CPU module
-----------------------

TODO: illustration
TODO: heatsink
  
Motherboard Schematics
----------------------

TODO: how do we insert a rendition of all of the schematics? (source is probably PDF)

TODO: link (QR code?) to IBOM

Keyboard
========

TODO: line-art render of the keyboard module with callouts of ports and buttons

The keyboard is a row/column matrix scanner with anti-ghosting diodes on each switch. Each row and column is connected to one pin of the ATMega32U4_ 8-bit microcontroller. This microcontroller runs a firmware based on LUFA_. This converts the scanned out keycodes to the USB HID protocol.

Keyboard Firmware
-----------------

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

Trackball
=========

.. image:: _static/illustrations/7t.png

TODO: callouts, screws are in random places

The trackball uses the same microcontroller and LUFA framework as the keyboard_, but instead of scanning a matrix of switches, it gets X and Y movement coordinates from the PAT9125EL-TKIT optical sensor that is connected via I2C.

The trackball has five buttons. The top two buttons function as left and right mouse buttons, the lower center button maps to the middle mouse button.

Holding either the lower left or right buttons activates wheel mode, where vertical movement of the ball is translated into vertical mouse wheel events.

Trackball Firmware
------------------

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

Trackball Schematics
--------------------

TODO

Trackpad
========

TODO: line-art render of trackpad with callouts

The trackpad uses the same microcontroller and LUFA framework as the keyboard_ and trackball_.

TODO: describe Azoteq captouch sensor

TODO: describe gestures for left/right/middle click and wheel

Trackpad Firmware
-----------------

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
.. _trackball: ../trackball/index.html

Trackpad Schematics
-------------------

TODO

Battery Packs
=============

Exchange Batteries
------------------

.. image:: _static/illustrations/13t.png

TODO: text. safety!

