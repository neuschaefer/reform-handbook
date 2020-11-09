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
administrator privileges, but logging out of your user account just to
log back in as root is a bit of a hassle, so you can give a user
"sudo" access, which allows you to use a command as root by using
``sudo <COMMAND>``. Log in as root and edit the file ``/etc/sudoers``:

.. code-block:: none

 micro /etc/sudoers

In this file find a line that says:

.. code-block:: none

 root    ALL=(ALL:ALL) ALL

And add a file right below it that looks like:

.. code-block:: none

 bob    ALL=(ALL:ALL) ALL

(Again, "bob" here should be replaced by your username).

