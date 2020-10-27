Tutorial
====

Setup
----

To start the tutorial::

 micro ~/interscheme/tutorial

Run the code::

 interscheme main.scm

Draw a pixel
----

To draw a red pixel at ``30,30``::

 (pixel 30 30 "#f00")

Draw a line
----

To draw a green line from ``30,30`` to ``40,80``::

 (stroke-line 30 30 40 80 "#0f0")

Draw a shape
----

To fill a blue rectangle from ``20,20`` to ``60,30``::

 (fill-rect 20 20 60 30 "#00f")

To fill a yellow ellipse from ``20,20`` to ``60,30``::

 (fill-ellipse 20 20 60 30 "#ff0")

Draw a shape with the mouse
----

To fill a purple circle, with a radius of ``10``, at the mouse cursor::

 (on-mouse-down
   (fill-circle mouse-x mouse-y 10 "#0ff"))

Draw a sprite
----

Animate a sprite
----

Move a sprite with the keyboard
----

Move a sprite with the mouse
----

Play a sound
----

Share your project
----

