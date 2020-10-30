Tutorial
========

This section describes how to create programs using audio, video, and 
keyboard/mouse inputs (for example, video games).

For this we'll use Interscheme - MNT's all-in-one utility for building 
such programs.

Setup
-----

Open the Interscheme scripting file:

.. code-block:: none

 micro ~/interscheme/init.scm

This file may already be populated with code, demonstrating an 
Interscheme program that displays a white box on the upper-left hand 
corner of the window. The ``(main)`` procedure does the actual drawing 
and is always being updated.

Run the code::

 ./interscheme main.scm

At this point you should see the default white box (or whatever you 
may have programmed in ``init.scm``)

Draw a pixel
------------

To draw a red pixel at ``30,30``:

.. code-block:: none

 (pixel 30 30 #f00)

Draw a line
-----------

To draw a green line from ``30,30`` to ``40,80``:

.. code-block:: none

 (stroke-line 30 30 40 80 #x0f0)

Draw a shape
------------

To fill a blue rectangle from ``20,20`` to ``60,30``:

.. code-block:: none

 (fill-rect 20 20 60 30 #x00f)

To fill a yellow ellipse from ``20,20`` to ``60,30``:

.. code-block:: none

 (fill-ellipse 20 20 60 30 #ff0)

Draw a shape with the mouse
---------------------------

To fill a purple circle, with a radius of ``10``, at the mouse cursor:

.. code-block:: none

 (on-mouse-down
   (fill-circle mouse-x mouse-y 10 #0ff))

Draw a sprite
-------------

Animate a sprite
----------------

Move a sprite with the keyboard
-------------------------------

Move a sprite with the mouse
----------------------------

Play a sound
------------

Share your project
------------------

