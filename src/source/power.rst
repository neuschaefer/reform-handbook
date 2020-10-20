The Battery/Lid Controller
==========================

Introduction
------------

The Atmel ATTiny841 (U16) is a 8-bit microcontroller that uses very little power and is always on when there is battery power in the system.
Its job is to keep track of how much current is going in and out of the battery and what voltage the battery has. It does this with the help of the voltage/current monitor chip INA260 that is connected to the ATTiny via I2C.

The ATTiny works as:

- Battery voltage and current monitor/gauge
- System current monitor
- Lid sensor

Communication
-------------

The ATTiny is permanently connected to the i.MX6 UART2 (/dev/ttymxc1 in Linux). If you want to interrupt this connection, you can desolder resistors R48 and R50.

The ATTiny firmware configures its serial port to 9600 baud 8N1. You can talk to it using the program screen (or another serial terminal):

.. code-block:: none
                
   screen /dev/ttymxc1 2400

It accepts commands in the form of a single letter followed by return. The current commands are:

- *p*: Get battery power information (estimated capacity in amp hours, voltage, current)
- *l*: Get lid state (0: open, 1: closed)
- *h*: Get hall sensor raw analog value

In addition, these commands can be prefixed with a decimal number (up to four digits):

- *600c*: Reset the battery capacity counter to 10Ah (600 Amp minutes)
- *500t*: Set the lid sensor open/closed threshold to the value 500
- *10w*: Set the lid sensor open/closed hysteresis to 10

Undervoltage Protection (UVLO)
------------------------------

The microcontroller is supposed to detect a dangerously low voltage on the battery and switch the 5V boost converter off via its PWRON output when the voltage is below 2.8V. This way, the system will not draw power from the battery until it is charged to a reasonable level again. This functionality is still being tested and not activated in the beta boards.

Lid Sensor
----------

The ATTiny senses if the lid is open or closed using the hall effect sensor (Honeywell SS495A). The lid is considered closed when a magnet is close to the sensor. The ATTiny outputs the string "wake" via its serial port which can wake the i.MX6 up from sleep.

Flashing the Firmware
---------------------

You can find the source code of the firmware_ in the folder "reform-attiny-fw" of the Reform source repository.

To change (flash) the firmware of the ATTiny, you need an Atmel ISP (In System Programmer) compatible programmer/cable. An easy way is to use an Arduino to emulate_ an ISP.

The relevant pins of J34 on the Reform motherboard for connecting the ISP cable are as follows:

Upper row (left to right):

+-----+------+------+------+
| 7   | 5    | 3    | 1    |
+=====+======+======+======+
| GND | MOSI | MISO | SCK  |
+-----+------+------+------+

Lower row (left to right):

+-------+------+------+------+
| 8     | 6    | 4    | 2    |
+=======+======+======+======+
| RESET | None | None | None |
+-------+------+------+------+

.. _emulate: https://www.arduino.cc/en/Tutorial/ArduinoISP
.. _firmware: https://github.com/mntmn/reform/reform-attiny-fw
