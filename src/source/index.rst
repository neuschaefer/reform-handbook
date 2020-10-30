Reform Handbook
===============

Mobile personal computers are becoming more and more opaque, vendor controlled, and hard to repair. Modern laptops have secret schematics, glued-in batteries, and components not under user control, like the Intel Management Engine or the Apple T2 security chip. Many people decide to tape over the built-in cameras of their laptops because they don’t know if they can trust the device or the software running on it.

Reform goes in the opposite direction. It is designed to be as open and transparent as possible, and to support a free and open source software stack from the ground up. It invites you to take a look under the hood, customize the documented electronics, and even repair it youself if you like. The Reform laptop has no built-in surveillance technologies, cameras, or microphones, so you can be confident that it will never spy on you. Built not around Intel technology, but NXP i.MX8M with 64-bit ARM Cortex-A53 cores, Reform has a much simpler architecture than conventional laptops. This simplicity also makes for a more pleasant developer experience.

A computer that is really yours
-------------------------------

Reform is designed to stay with you for a long time. From open hardware input devices to user-swappable 18650 battery cells, we designed it to be the most repairable and best documented portable computer. We selected its components to strike a good balance between open source and usability. Reform is not bound to any cloud services, contracts, user agreements, or tracking. You can extend it and customize it as you like.

A more private computer
-----------------------

Reform doesn’t have any microphones or cameras built in, and Wi-Fi is provided by a removable PCIe card. You can even install your operating system or sensitive work data on an SD card that you can simply eject before travelling. Full-disk encryption is easy to set up with LUKS, and the system has no "management engine" or other remote control features that could be used to attack you.

A great writing machine
-----------------------

Instead of following the trend of making ever thinner and smaller devices and sacrificing the typing experience, we decided to put a mechanical keyboard into Reform. Our open-hardware keyboard uses Kailh Choc Brown switches with 3 mm travel and 50 g operating force with n-key rollover and fully customizable firmware.
A mobile office

Reform runs a wealth of free productivity software like LibreOffice and Firefox, Inkscape, Scribus, and GIMP that have matured to easily rival the feature sets of their commercial counterparts while requiring significantly less system resources.
An industrial computer

The main SoC family of Reform (i.MX) is well known as an industrial and automotive workhorse that doesn’t easily give up in a bit warmer or colder environments. The modular design of the notebook and a trackball that can be used with gloves makes Reform adaptable to workflows on field sites or in factories.

An ARM 64-bit development tool
------------------------------

Emulation and cross-compiling are nice, but Reform has enough performance to be used for editing and compiling software on the "real thing", and is a more convenient all-in-one package than a Single Board Computer with a bunch of dongles.
An open-source digital art and audio playground

The GPU in Reform supports OpenGL ES 2.0 through the open-source etnaviv driver that is part of the Linux kernel, and high fidelity audio is delivered by a Wolfson DAC on the motherboard. Reform’s rugged construction and repairability makes it a good fit for live environments.

A teaching tool
---------------

Because Reform is designed to be taken apart, studied, and reassembled, and our production process is unusually open, it can be a useful prop for teaching electronics engineering (with KiCAD), applied computer science, or lean manufacturing.

Guide
^^^^^

.. toctree::
   :maxdepth: 2
   :caption: Contents:
   
   preface
   contactandreferences
   safety
   quickstart
   tutorial
   referenceelec
   referencemech
   boot
   credits
   cheatsheet

Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
