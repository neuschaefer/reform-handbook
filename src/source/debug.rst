Debugging
=========

Power
-----

The TinyRex module has a red and a green LED. Both have to light up to signal good power.

To troubleshoot power, disconnect the internal battery and all internal and external peripherals, connect the 5V wall adapter. If you want to unplug the TinyRex module, you should take the motherboard out of the case first.

Turn the power switch on. Get a multimeter and find the following voltages in the system:

- **5V** The main input rail. Can be found on pin 1 of J25 or J29.
- **3.3V** The big regulator U4 (AP1501A-33) turns 5V into 3.3V. Check test point TP3 next to the big coil L2.
- **2.5V** Regulated by U11 (LP3962EMP-2.5). Check TP5 next to it.
- **1.5V** Regulated by U13. Check TP12. Needed for PCIe.
- **1.1V** Regulated by U5 near the USB hub U9. Check TP6.

If voltages are way off, there can be a short somewhere on the board which usually generates heat.
  
Serial Console
--------------

The motherboard connector labelled CONSOLE is a serial port (UART) to which U-Boot and the Linux kernel output diagnostic information on startup. The baud rate is 115200.

Wire up a generic USB-to-UART adapter to the following pins of J25 (pin 1 is next to the J25 label):

- **1** 5V, don't connect
- **2** UART1_TXD, connect to RX of your adapter
- **3** UART1_RXD, connect to TX of your adapter
- **4** UART1_RTS, don't connect
- **5** UART1_CTS, don't connect
- **6** GND, connect to GND of your adapter

Then, use a terminal program such as screen on your host computer:

.. code-block:: none

   screen /dev/ttyUSB0 115200

If you then switch on Reform with a prepared SD card inserted, you should see the U-Boot console in *screen*.
