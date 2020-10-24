Reference: Electronics
+++++++++++++++++


The Motherboard
===============
The motherboard spans the complete inner width of the device (around 27 cm) and ends with external ports on both sides. It has the following features:

**Power system:** includes a charger for LiFePO4 cells and seamlessly switches between wall and battery power.
**System controller:** coupled to the power system, an NXP LPC11U24 Cortex-M0 MCU controls an analog monitor chip for the eight battery cells as well as the charger. It is connected to the SoM via SPI, and has GPIO lines to the main power rail switchers in the system. It has a UART (serial port) that the keyboard can talk to directly for issuing power on/off commands and battery status queries.
**DSI to eDP converter:** it was an important goal for us to make the main display path for Reform blob-free, so we couldn't use the existing HDMI/DisplayPort block in i.MX8M to drive the internal display, because this needs a chunk of firmware related to content protection. Instead, we're using the MIPI DSI output and convert its signal to eDP using a Texas Instruments SN65DSI86 chip. All involved drivers are open and in mainline Linux.
**USB 3.0 hub:** i.MX8M has 2x USB 3.0 controllers. As we need two internal USB ports for the keyboard and trackball (or trackpad) and wanted to provide three external USB ports, we put a Texas Instruments TUSB8041 USB hub chip on the board that provides the extra ports. We have USB load switches on each external port to protect from too much current draw.
**Sound system:** the Reform motherboard features a Wolfson/Cirrus WM8960 audio DAC (digital-to-analog converter)/amplifier interfacing to the headphone/microphone jack and powering two speakers housed below the main display.
**M.2 slot:** a PCIe clock synthesizer on the board provides a reference clock for one or both PCIe 2.0 controllers in i.MX8M. We put one M.2 M-key slot on the board that can house a high-speed NVMe SSD.
**mPCIe slot:** the other PCIe controller drives an mPCIe connector that you can use for expansions like a Wi-Fi card (included in the Reform Max pledge level), an embedded graphics card or an FPGA board, for example.
The Reform motherboard is open source hardware designed with the free KiCAD EDA. You can find the sources here:

Reform Motherboard KiCAD Sources
Reform System Controller Firmware Sources

Schematics
----------

Power
-----

Storage
-------

Display
-------

PCIe
----

Ethernet
--------

USB
---

Audio
-----
