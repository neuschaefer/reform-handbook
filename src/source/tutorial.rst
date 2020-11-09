Programming Tutorial
====================

In this section we'll demonstrate how to create your own computer
programs using the Scheme programming language.

What is Scheme?
---------------

Scheme is a programming language that looks like this:

.. code-block:: none

 (define (square x)
   (* x x))
 
 (square 5)

This code can be read like "Define a new function named 'square',
which takes a single argument, x. Multiply x by itself."

After defining the function, ``(square 5)`` is called to test out the
function. When our function ``(square x)`` is applied to our argument
(``5``), we get the output ``25``, because 5 * 5 is 25.

One thing that you may notice right away is that the math is performed
like ``(* 5 5)`` instead of ``(5 * 5)`` as you may expect. This is
called "Prefix Notation" and can be very helpful. For example, if we
wanted to add a lot of numbers, we conventionally do ``2 + 3 + 4 + 6 +
11``, but in Scheme it's ``(+ 2 3 4 6 11)``, which is much more
concise.

More Scheme Resources
---------------------

Now that you have a simple understanding of how Scheme works, feel
free to dive further into the language with this list of works (feel
free to finish this tutorial now and check these links out later):

..
 I'd like for the names themselves to be hyperlinks, but I can't
 figure out how to do that properly in RST. This will work for now.

- The Little Schemer:
  <https://mitpress.mit.edu/books/little-schemer-fourth-edition>
  
- Structure and Interpretation of Computer Programs:
  <https://mitpress.mit.edu/sites/default/files/sicp/index.html>
  
- Land of Lisp:
  <http://landoflisp.com/>
  



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

