Linux Basics
============

TODO

.. Things that are already done:
   - Create user and change password, log in and out
   - Navigate the filesystem: cd, ls
   - View/edit text files
   - What's the computer doing? htop, ncdu, systemctl

- Choose a desktop (sway or GNOME3)
- Sway Basics
- Tiling
- Workspaces
- Config File
- Display Brightness
- Reform Waybar
- Network, CPU/IO Meter, Memory, Audio, Clock
- Reform Launcher
- GNOME3 Basics
- Install/remove software


Create a New User and Password
------------------------------

In order to add a new user (such as yourself) to the system, log in as
root and run the following command (this will add a new user named
"bob", and add a new "home directory" for bob at ``/home/bob``):

.. code-block:: none

 useradd --create-home bob

In order to create or change the password for the user bob, you can
use the ``passwd`` command:

.. code-block:: none

 passwd bob

Now you should be prompted to input a password (your input for this is
invisible).

Logging In and Out
------------------

You can log out by pressing ``Ctrl+D`` one or more times. You may also
use the ``exit`` command, or the ``logout`` command.

When you log out or start the computer, you should see a login
prompt. Enter the username that you added with ``useradd``. Then it
asks for your password, so enter the password that you selected with
``passwd`` (again, this is invisible). You should be logged in to your
home directory.

Giving Sudo Access to a User
----------------------------

Often times you might want to use a command that requires
administrator (root) privileges, but logging out of your user account
just to log back in as root is a bit of a hassle, so you can give a
user "sudo" access, which allows you to use a command as root by using
``sudo <COMMAND>``. You can add a user to the ``sudo`` group with:

.. code-block:: none

 usermod -a -G sudo bob

(Again, "bob" here should be replaced by your username).

The ``-a`` flag means "Append the user to a group list", and the
``-G`` option is the name of the group you want to add the user to, in
this case it's the ``sudo`` group.

From now on you can use commands as root, for example, the command
``shutdown now`` requires root privileges, so you can run:

.. code-block:: none

 sudo shutdown now

Which asks you for your password, then shuts down the computer.

View / Edit Text Files
----------------------

You can create, view, and edit files using the ``micro`` text
editor. Simply use:

.. code-block:: none

 micro file.txt

While in micro, you can use ``Ctrl-s`` to save, ``Ctrl-q`` to quit,
and ``Ctrl-g`` to display a help menu that should help get you
started.

Micro has features like line numbers, code indentation, syntax
highlighting, intuitive commands, and a configuration file. Of course,
you can also install the text editor of your preference.

What's My Computer Doing?
-------------------------

You can check your RAM usage, CPU usage, and programs / processes
currently running by using ``htop``:

.. code-block:: none

 htop

In htop you can use the arrow keys to scroll down through the list of
processes.

If you want to free up some disk space by finding large files, you can
use ``ncdu``, which scans your disk for filesizes and allows you to
traverse the filesystem and delete the files you don't want, or quit
if you change your mind.

.. code-block:: none

 ncdu


If you want to see all the programs currently set to start on boot, you can check ``systemctl``:

.. code-block:: none

 systemctl status

If you want to see everything the kernel sees, you can check out the log with ``dmesg``:

.. code-block:: none

 dmseg | less

Choose a Desktop
----------------

GNOME is an intuitive, modern, and efficient graphical environment
with support for productive functionality such as workspaces and
custom keyboard bindings.

Sway is a highly configurable tiling window manager that is lighter on
resources, but comes with a steeper learning curve.

Sway Basics
-----------

You may start sway from the command line simply by running the
``sway`` command:

.. code-block:: none

 sway

If no errors occur, you should be presented with a message asking you
to select a Command key. This is the key you press in order to
perform most tasks in Sway. Many people like to use the "Super" key
("Windows key" or "Command key" on some keyboard models) as most
programs do not utilize it, so it does not get in the way.

From now on, you can start a new terminal window by using the command:

.. code-block:: none

 Super + Return

Tiling
------

When you press ``Super + Return`` multiple times to open several
terminals, you'll notice that your currently open windows will be
resized to accomidate for the new window.. You can switch between
these tabs using the shortcuts:

.. code-block:: none

 Super + j   - Move to the left
 Super + k   - Move down
 Super + l   - Move up
 Super + ;   - Move to the right

These shortcuts may be familiar to you if you have used the ``vi``
text editor.

If you keep adding windows, they will continuously shrink
horizontally, but if you would rather have a window split vertically,
you can. Use these shortcuts for deciding:

.. code-block:: none

 Super + h   - Split window horizontally
 Super + v   - Split window vertically

Note that the window is not split instantaneously. You're just telling
Sway "The next time I create a window, put it below/beside my current
window.

You may also use ``Super + w`` to tell Sway to use tabs. You can
switch your tab using the same shortcuts for windows (``jkl;``).

Workspaces
----------

You can change your workspace with the number keys, for example:

.. code-block:: none

 Super + 2      - Move to workspace #2
 Super + 1      - Move back to workspace #1
 Super + 5      - Move to workspace #5

You can open different spaces for different programs. For example, you
might want to put your code-editing programs in workspace 1, a web
browser in workspace 2, and some instant messaging programs in
workspace 3.

Config File
-----------

The file ``~/.config/sway`` is the configuration file, which you can
use to map your own keybindings and color themes.

Open the config file:

.. code-block:: none

 micro ~/.config/sway

You can learn about the different Sway configuration options at the `Sway Wiki <https://github.com/swaywm/sway/wiki>`_

Display Brightness
------------------

Reform Waybar
-------------

Network, CPU/IO Meter, Memory, Audio, Clock
-------------------------------------------

Reform Launcher
---------------

GNOME Basics
-------------

On the upper-right hand of the screen, you should see some text that
says "Activities". You can slide your mouse over this corner to open
your app menu.

(Screenshot of App Menu)

Using ``Super-Shift-Down`` / ``Super-Shift-Up`` will switch your
workspace.

Install/remove software
-----------------------
