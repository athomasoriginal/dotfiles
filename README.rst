********
DOTFILES
********

Welcome to my dotfiles.  You are very welcome to use them, but I recommend reading through each file before you try to setup your mac based on this setup.  What works for me, might not work for you.

Housekeeping
============

Before you run the install script, please make sure you complete the following steps:

**1.  Update macOS**

**2.  Install Xcode Command Line Tools**
```bash
xcode-select --install
```

Quickstart
==========

**1.  move into your home directory**
```bash
cd ~/
```

**2.  clone this repo**
```bash
git clone https://github.com/tkjone/dotfiles
```

**3.  run the setup script**
```bash
source setup.sh
```

Setup Examined
==============

The `setup.sh` file is going to do all the heavy lifting and automate as many things as we can.  In order, it will:

- Install Brew
- Brew install everything in the Brewfile - https://robots.thoughtbot.com/brewfile-a-gemfile-but-for-homebrew
-

Notes
=====

- make sure that you install diff-fancy and update the path to gits diff-highlighter - in `.gitconfig`



