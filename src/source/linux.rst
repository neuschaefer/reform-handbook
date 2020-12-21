Linux Basics
============

TODO

- Provide links/refs to advanced reading on Linux system administration
- Display Brightness
- Reform Waybar
- Network, CPU/IO Meter, Memory, Audio, Clock
- Reform Launcher
- Install/remove software

The Console
-----------

With the provided SD card, MNT Reform will boot to a Linux console, which is a pure text interface (opposed to graphical windowing environments). This is so that you have a chance to learn about the lowest level of interaction with the operating system before moving on to more featureful desktops. If something goes wrong, you can always go back to this level and fix things -- if you know a few basics of Linux administration.

Create a New User and Password
------------------------------

In order to add a new user (such as yourself) to the system, log in as
root and run the following command (this will add a new user named
"kim", and add a new home directory for kim at ``/home/kim``):

.. code-block:: none

 useradd --create-home kim

In order to create or change the password for the user kim, you can
use the ``passwd`` command:

.. code-block:: none

 passwd kim

Now you should be prompted to input a password (your input for this is
invisible).

Logging In and Out
------------------

You can log out by pressing ``Ctrl+D`` one or more times. You may also
use the ``exit`` command, or the ``logout`` command.

When you log out or start the computer, you should see a login
prompt. Enter the username that you added with ``useradd``. Then it
asks for your password, so enter the password that you selected with
``passwd`` (again, this is invisible). You will be logged in to your
home directory.

Giving Sudo Access to a User
----------------------------

Often you will want to use a command that requires superuser
(root) privileges, but logging out of your user account just to log
back in as root is a bit of a hassle, so you can give a user ``sudo``
(meaning: "do something as superuser"). Sudo allows you to use a
command as root by using ``sudo <COMMAND>``. You can add a user to the
``sudo`` group with:

.. code-block:: none

 usermod -a -G sudo kim

(Again, ``kim`` here should be replaced by your username).

The ``-a`` flag means "Append the user to a group list", and the
``-G`` option is the name of the group you want to add the user to, in
this case it's the ``sudo`` group.

From now on you can use commands as root. For example, the command
``shutdown now`` (to shut down your computer safely) requires root privileges, so you can run:

.. code-block:: none

 sudo shutdown now

Which asks you for your password, then shuts down the computer.

File System
-----------

Your system's file storage is organized in a tree of directories. To move around in it, you use the ``cd`` command to change the current directory. The top of the hierarchy is called root (not to be confused with the superuser of the same name), but spelled out as the symbol ``/``. To go to the root directory, enter:

.. code-block:: none
 cd /

To see what's here, use the ``ls`` (list) command:

.. code-block:: none
 ls

If you want to know more details, such as the modification times and permissions of files, use:

.. code-block:: none
 ls -l

There are two special files that appear to be in every directory, called `..` and `.`. The dot `.` means "the current directory", and you can use it if you ever want to point at the current directory explicitly, like ``ls .``. To go to the parent directory, use:

.. code-block:: none
 cd ..

Commands like ``ls`` have many options. To learn about them, you can read the built-in manual pages like so:

.. code-block:: none
 man ls

With ``man`` you can learn more about any command. You should make yourself familiar with the most important commands like ``cp`` (copy), ``mv`` (move), ``rm`` (remove), ``mkdir`` (make directory), ``mount`` and ``ln`` (link). Armed with this knowledge, you will be able to navigate any UNIX-like system, not only Linux.

View / Edit Text Files
----------------------

Most system configuration is done via text files.

The two most common text editors among Linux users are ``vim`` and ``emacs``. Both of them have a steep learning curve, which can be rewarding to climb -- but the standard Reform system also ships with a simpler editor more suited for beginners. This editor is called ``micro``.

You can create, view, and edit files using the ``micro`` text
editor. To edit a file in the current directory called ``file.txt`, use:

.. code-block:: none

 micro file.txt

While in micro, you can use ``Ctrl-s`` to save, ``Ctrl-q`` to quit,
and ``Ctrl-g`` to display a help menu.

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

 dmesg | less

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
to select a Command key. This is the key you press in order to perform
most tasks in Sway. Many people like to use the "MNT" key, as most
programs do not utilize it, so it does not get in the way.

From now on, you can start a new terminal window by using the command:

.. code-block:: none

 MNT + Return

Tiling
------

When you press ``MNT + Return`` multiple times to open several
terminals, you'll notice that your currently open windows will be
resized to accomidate for the new window.. You can switch between
these tabs using the shortcuts:

.. code-block:: none

 MNT + j   - Move to the left
 MNT + k   - Move down
 MNT + l   - Move up
 MNT + ;   - Move to the right

These shortcuts may be familiar to you if you have used the ``vi``
text editor.

If you keep adding windows, they will continuously shrink
horizontally, but if you would rather have a window split vertically,
you can. Use these shortcuts for deciding:

.. code-block:: none

 MNT + h   - Split window horizontally
 MNT + v   - Split window vertically

Note that the window is not split instantaneously. You're just telling
Sway "The next time I create a window, put it below/beside my current
window.

You may also use ``MNT + w`` to tell Sway to use tabs. You can
switch your tab using the same shortcuts for windows (``jkl;``).

You can use ``MNT + ESC`` to kill your currently selected window.

Workspaces
----------

You can change your workspace with the number keys, for example:

.. code-block:: none

 MNT + 2      - Move to workspace #2
 MNT + 1      - Move back to workspace #1
 MNT + 5      - Move to workspace #5

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

There are a few keyboard shortcuts that might come in handy while
working:

.. code-block:: none

 MNT             - Open app menu
 Ctrl+Alt+t      - Launch terminal
 MNT+PageUp      - Workspace above
 MNT+PageDown    - Workspace below
 Ctrl+Alt+Delete - Log out





Install/remove software
-----------------------
