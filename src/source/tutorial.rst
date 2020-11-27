Programming Tutorial
====================

In this section we'll demonstrate how to create your own computer
programs using the Scheme programming language.

Setting Up Interscheme
----------------------

Let's start working with graphics now! Open the Interscheme scripting
file:

.. code-block:: none

  micro ~/interscheme/init.scm

This file may already be populated with code, demonstrating the
different utilities Interscheme provides.  The ``(main)`` procedure
does the actual drawing and is updated 60 times per second.

Run the code::

  ./interscheme init.scm

At this point you should see the default example program (or whatever
you may have programmed in ``init.scm``)

What is Scheme?
---------------

Scheme is a programming language that looks like this:

.. code-block:: none

  (define (greet name)
    (string-append "Hello " name "!"))

  (greet "Reform")

The previous code defines a new function named 'greet', which takes a single
argument called ``name``. After defining the function, ``(greet "Reform")`` is 
called to test out the function and the result of the function is the 
text ``Hello Reform!``.

In Scheme, a pair of parentheses indicates one step of calculation. A function 
name comes after the open parenthesis followed by arguments. Tokens are 
reparated by spaces, tabs and newlines.

.. code-block:: none

  (define (square x)
   (* x x))

  (square 5)

Scheme follows the "Prefix Notation", where operations use the format 
``(* 5 5)`` instead of ``(5 * 5)``. For example, if we wanted to add a lot of 
numbers together, we conventionally do ``2 + 3 + 4 + 6 + 11``, in Scheme we 
would instead write ``(+ 2 3 4 6 11)``, which is much more concise.

Variables
^^^^^^^^^

To define a variable, use ``define``, followed by a **name** and a **value**. 

.. code-block:: none

  (define red #xff0000)

To draw a pixel at the location ``20,30`` with the color we just defined, we will use ``put-pixel`` followed by **x**, **y** and our **color**. 

.. code-block:: none

  (put-pixel 20 30 red)

A complete interscheme project that will draw 4 pixels to the screen might look something like: 

.. code-block:: none

  (define red #xff0000)
  (define yellow #xffff00)
  (define green #x00ff00)
  (define cyan #x00ffff)

  (define (main)
    (put-pixel 20 20 red)
    (put-pixel 21 20 yellow)
    (put-pixel 22 20 green)
    (put-pixel 23 20 cyan)
  )

Functions
^^^^^^^^^

To define a function, use ``define`` again, but followed by an expression to name and define parameters, and a second to define the operation. Here we will define a function to help us draw rectangles.

A rectangle is made up of 4 lines, our function is named ``stroke-rect``, followed by the **x,y** position, the **w,h** size and the color of the rectangle.

The ``stroke-line`` function is something that comes with interscheme to help us draw lines.

.. code-block:: none

  (define (stroke-rect x y w h color)
    (begin 
      (stroke-line x y (+ x w) y color)
      (stroke-line (+ x w) y (+ x w) (+ y h) color)
      (stroke-line (+ x w) (+ y h) x (+ y h) color)
      (stroke-line x (+ y h) x y color)))

We can use our newly created function like so:

.. code-block:: none

  (define red #xff0000)
  (define yellow #xffff00)
  (define green #x00ff00)
  (define cyan #x00ffff)

  (define (stroke-rect x y w h color)
    (begin 
      (stroke-line x y (+ x w) y color)
      (stroke-line (+ x w) y (+ x w) (+ y h) color)
      (stroke-line (+ x w) (+ y h) x (+ y h) color)
      (stroke-line x (+ y h) x y color)))

  (define (main)
    (stroke-rect 20 20 20 20 red)
    (stroke-rect 22 22 20 20 yellow)
    (stroke-rect 24 24 20 20 green)
    (stroke-rect 26 26 20 20 cyan)
  )

Loops
^^^^^

Let's say we wanted to draw many rectangles, but didn't want to individually write them into the loop one after the other. 


Logic
^^^^^

Logic operations are in the format of ``(if true this that)`` where 
the result of the operation will be ``this`` if the second parameter is ``true``
, otherwise will be ``that``. In Scheme, true is indicated as ``#t``, and false
is indicated as ``#f``.

.. code-block:: none

 (define (min a b) 
   (if (< a b) a b))

Draw a pixel
------------

To draw a single red pixel at ``30,30``:

.. code-block:: none

 (pixel-put 30 30 #ff0000)

You may also use a loop to draw a series of pixels. For example,
here's one way to put 50 pixels down in random positions:
 
.. code-block:: none

 (import (srfi 27))
 (define (put-pixels? #t)
 (define (pixels-everywhere n)
   ;; Set i to 0, and increase by 1 on every loop.
   (do ((i 0 (1+ i)))
     ;; If i is equal to the input (n), stop. We are done.
     ((eq? i n)
      (set! put-pixels? #f))
     ;; If i < n, put a pixel at a random position.
     (pixel-put (random-integer 300)
                (random-integer 300) 
                #x00ff00)))
  (set! put-pixels? #f)))

  (define (main)
   (if put-pixels?
    (pixels-everywhere 50)))
 
Drawing Lines
-------------

To draw a green line from ``30,30`` to ``40,80``:

.. code-block:: none

 (stroke-line 30 30 40 80 #x00ff00ff)

Drawing Shapes
--------------

To fill a blue rectangle from ``20,20`` to ``60,30``:

.. code-block:: none

 (fill-rect 20 20 60 30 #x00f)

To fill a yellow ellipse, with the center at ``20,20`` with a width of
``60`` and a height of ``30``:

.. code-block:: none

 (pixel-fill-ellipse 20 20 60 30 #xffff00ff)

Drawing Shapes Using the Mouse
------------------------------

To fill a purple circle, with a radius of ``10``, at the mouse cursor:

.. code-block:: none

 (on-mouse-down
   (pixel-fill-ellipse mouse-x mouse-y 10 10 #xffff00ff))

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


More Scheme Resources
---------------------

Now that you have a simple understanding of how Scheme works, feel
free to dive further into the language with this list of works (feel
free to finish this tutorial now and check these links out later):

- `The Little Schemer <https://mitpress.mit.edu/books/little-schemer-fourth-edition>`_
- `Structure and Interpretation of Computer Programs <https://mitpress.mit.edu/sites/default/files/sicp/index.html>`_
- `Land of Lisp <http://landoflisp.com/>`_
