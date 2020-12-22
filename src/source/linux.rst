Linux Basics
============

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

You can log out by pressing *CTRL+D* one or more times. You may also
use the ``exit`` command, or the ``logout`` command.

When you log out or start the computer, you should see a login
prompt. Enter the username that you added with ``useradd``. Then it
asks for your password, so enter the password that you selected with
``passwd`` (again, this is invisible). You will be logged in to your
home directory.

Sudo
----

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

Commands like ``ls`` have many options. To learn about them, you can read the built-in manual pages:

.. code-block:: none

 man ls

With ``man`` you can learn more about any command. You should make yourself familiar with the most important commands like ``cp`` (copy), ``mv`` (move), ``rm`` (remove), ``mkdir`` (make directory), ``mount`` and ``ln`` (link). Armed with this knowledge, you will be able to navigate any UNIX-like system, not only Linux.

If you want to free up some disk space by finding large files, you can
use ``ncdu``, which scans your disk for filesizes and allows you to
traverse the filesystem and delete the files you don't want.

.. code-block:: none

 ncdu

View / Edit Text Files
----------------------

Most system configuration is done via text files.

The two most common text editors among Linux users are ``vim`` and ``emacs``. Both of them have a steep learning curve, which can be rewarding to climb -- but the standard Reform system also ships with a simpler editor more suited for beginners. This editor is called ``micro``.

You can create, view, and edit files using the ``micro`` text
editor. To edit a file in the current directory named ``file.txt``, use:

.. code-block:: none

 micro file.txt

While in micro, you can use *CTRL+S* to save, *CTRL+Q* to quit,
and *CTRL+G* to display a help menu.

What Is My Computer Doing?
--------------------------

You can check your RAM usage, CPU usage, and processes
currently running by using ``htop``:

.. code-block:: none

 htop

Hit F1 to display the built-in help screen.

You will see that there are a few processes running that you didn't start yourself. These are background processes, also called services, daemons, or units. They are controlled by ``systemd``, the so-called "init system". It is the first program started by the Linux kernel, and it spawns all other programs including services. You can learn more about systemd by reading the manual page:

.. code-block:: none

 man systemd

The most important commands to manage systemd are ``systemctl`` and ``journalctl``. Their manual pages are worth a look, too. To see the list of known units and their status, you can use (press q to quit):

.. code-block:: none

 systemctl

To inspect a unit in more detail, you can pass its name to systemctl, for example:

.. code-block:: none

 systemctl status ssh

Instead of ``status``, you can use verbs like ``start``, ``stop`` or ``restart`` to control units.

The Linux kernel itself outputs a lot of diagnostic information at boot and when hardware changes (e.g. new devices are plugged in). To see the kernel log, you can (as superuser) use:

.. code-block:: none

 sudo dmesg -H

Choose a Desktop
----------------

MNT Reform ships with two graphical environments ("desktops") on the SD card. The Debian distribution, which the system on the SD card is based on, has a number of additional desktops in its package manager (See "Install/Remove Software").

1. The GNOME desktop features classic overlapping windows and a modern look. It is generally easy to learn and use, but requires more system resources and mouse / trackball / trackpad pointing and clicking.

2. The Sway compositor emphasizes the concept of "tiling". This means that normally, windows don't overlap, but instead the screen space is automatically divided to make space for new windows. You can arrange windows in horizontal and vertical splits and shuffle them around a number of virtual workspaces. Sway consumes very little system resources and relies heavily on keyboard shortcuts.

Sway
----

You may start sway from the command line by running the
``sway`` command:

.. code-block:: none

 sway

From now on, you can start a new terminal window by holding down the *MNT* key and pressing the *ENTER* key once (*MNT+ENTER*).

Tiling
++++++

When you press *MNT+ENTER* multiple times to open several
terminals, you'll notice that your currently open windows will be
resized to accomodate for the new window. You can switch between
these windows by holding the MNT key and pressing the cursor (arrow) keys in the desired direction.

If you keep adding windows, they will continuously shrink
horizontally, but if you would rather have a window split vertically,
you can. Use these shortcuts for deciding:

======= =========================
*MNT+H* Split window horizontally
*MNT+V* Split window vertically
======= =========================

Note that the window is not split instantaneously. You're just telling
Sway "The next time I create a window, put it below/beside my current
window."

You may also use *MNT+W* to tell Sway to use tabs. You can
switch your tab using the same shortcuts for switching between windows.

You can use *MNT+ESC* to close the currently selected window.

Workspaces
++++++++++

You can change your active workspace with the number keys, for example:

============= ======================================
*MNT+2*       Go to workspace 2
*MNT+1*       Go back to workspace 1
*MNT+SHIFT+5* Move the current window to workspace 5
============= ======================================

You can open different spaces for different programs. For example, you
might want to put your code-editing programs in workspace 1, a web
browser in workspace 2, and some instant messaging programs in
workspace 3.

Launching Applications
++++++++++++++++++++++

Reform's sway configuration includes "rofi", a popup menu for launching an application by typing a part of its name. Press *MNT+D* to open the menu. Over time, rofi will remember the applications you regularly launch and list them in the initial menu.

Config File
+++++++++++

The file ``~/.config/sway/config`` is the configuration file, which you can
use to map your own keybindings and customize the look and feel.

To open the config file:

.. code-block:: none

 micro ~/.config/sway/config

You can learn more about the Sway configuration options at the `Sway Wiki <https://github.com/swaywm/sway/wiki>`_

Display Brightness
++++++++++++++++++

======== ===========================
*MNT+F1* Decrease display brightness
*MNT+F2* Increase display brightness
======== ===========================

Waybar
++++++

TODO: Network, CPU/IO Meter, Memory, Audio, Clock

GNOME
-----

In the top-left corner of the screen, you can see the label "Activities". Click this label to reveal the Activities overview. Alternatively, you can press the MNT key to open this overview. From here, you can launch applications by typing (a part of) their name. You can drag and drop applications that you commonly use to the bar on the left (also called a "dock"). Applications that are already running are displayed in the dock, too. Clicking on them will bring them to the foreground.

GNOME supports a range of keyboard shortcuts to speed up working with the desktop:

=============== ===========================
*MNT*           Open Activities
*MNT+TAB*       Go to next window
*MNT+SHIFT+TAB* Go to previous window
*CTRL+ALT+T*    Launch a terminal
*MNT+PGUP*      Workspace above
*MNT+PGDN*      Workspace below
=============== ===========================

Install and Remove Software
---------------------------

The Debian GNU/Linux distribution consists of a large number of software packages. These are centrally managed by "apt", the package manager. As a rule of thumb, on a Linux system you rarely download executables from the internet and launch them. Instead, you can cleanly install and remove software packages by using the package manager. Apt also has the ability to search for keywords (or regular expression patterns):

.. code-block:: none

   apt search browser

This will list all packages in the apt cache that contain the keyword "browser". To refresh apt's cache of what is available in the Debian repositories, use (this requires an internet connection):

.. code-block:: none

   sudo apt update

If you have found a package you would like to install:

.. code-block:: none

   sudo apt install firefox

To remove (uninstall) the package from your system, do:

.. code-block:: none

   sudo apt remove firefox

To explore all of apt's functionality, read the man pages for ``apt`` and ``apt-cache``. If you are more comfortable with a graphical user interface for managing apt packages, you can install ``synaptic``:

.. code-block:: none

   sudo apt install synaptic
