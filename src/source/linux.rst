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

Sway Basics
-----------

Tiling
------

Workspaces
----------

Config File
-----------

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
