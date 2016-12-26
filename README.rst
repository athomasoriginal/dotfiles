********
DOTFILES
********

Welcome to my dotfiles.  You are very welcome to use them, but I recommend reading through each file before you try to setup your mac based on this setup.  What works for me, might not work for you.

Housekeeping
============

Before you run the install script, please make sure you complete the following steps:

**1.  Update macOS**

**2.  Install Xcode Command Line Tools**

.. code-block:: bash

    xcode-select --install

**3.  Setup diff-highlighter**

To use ``diff-highlighter`` you will have to reference the currently active global version of git.  This means, the path specified in the ``.gitconfig`` file may not be correct for your install of git.  To do this:

1.  Find diff-highlight

.. code-block:: bash

    find -L /usr -name diff-highlight -type f

2.  Choose the path with the larget git version

.. code-block:: bash

    /usr/local/Cellar/git/2.11.0/share/git-core/contrib/diff-highlight/diff-highlight

.. epigraph::

   You can tell by the number directly after git.  In the above path, it's `2.11.0`

3.  Replace the path on line 13 in the .gitconfig with the path from step 2.

.. code-block:: bash

    pager = /usr/local/Cellar/git/2.11.0/share/git-core/contrib/diff-highlight/diff-highlight | diff-so-fancy | less -r

Quickstart
==========

**1.  move into your home directory**

.. code-block:: bash

    cd ~/


**2.  clone this repo**

.. code-block:: bash

    git clone https://github.com/tkjone/dotfiles


**3.  run the setup script**

.. code-block:: bash

    source setup.sh


Setup Examined
==============

The `setup.sh` file is going to do all the heavy lifting and automate as many things as we can.  In order, it will:

- Install Brew
- Brew install everything in the Brewfile - https://robots.thoughtbot.com/brewfile-a-gemfile-but-for-homebrew
- Symlink dotfiles
- Set the default shell environment to zsh
- Setup Sublime Text - Specifically, setup ``subl`` and replace the default icon
- Setup preferred macOS settings

Notes
=====

...



