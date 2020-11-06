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

This file may already be populated with code, demonstrating the
different utilities Interscheme provides.  The ``(main)`` procedure
does the actual drawing and is updated 60 times per second.

Run the code::

 ./interscheme init.scm

At this point you should see the default example program (or whatever
you may have programmed in ``init.scm``)

Draw a pixel
------------

To draw a single red pixel at ``30,30``:

.. code-block:: none

 (pixel-put 30 30 #ff0000)

Drawing Lines
-----------

To draw a green line from ``30,30`` to ``40,80``:

.. code-block:: none

 (stroke-line 30 30 40 80 #x00ff00ff)

Drawing Shapes
--------------

To fill a blue rectangle from ``20,20`` to ``60,30``:

.. code-block:: none

 (fill-rect 20 20 60 30 #x00f)

To fill a yellow ellipse from ``20,20`` to ``60,30``:

.. code-block:: none

 (fill-ellipse 20 20 60 30 #ff0)

Drawing Shapes Using the Mouse
------------------------------

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

To play a ``.WAV`` file from Interscheme, you can use:

.. code-block:: none

  (load-wav "file.wav" 0)

In this example, ``file.wav`` is the name of the audio file we want to
load, and ``0`` tells Interscheme to play the audio once, then stop
(if you would rather loop the audio forever, use ``-1`` instead).

To generate a tone, you can use:

.. code-block:: none
		
  (generate-tone 440.0 0.5)

In this example, ``440.0`` is the frequency (in this case, the musical
key of A4), and ``0.5`` is how long the sound should play for in
seconds (half a second, in this case).

Share your project
------------------

