# DOTFILES

Welcome to my dotfiles.  You are very welcome to use them.

I try to keep my dotfiles in a very basic and generalized state, thus attempting to avoid making anything overly specific to my own idiosyncrasies.


If you decide to follow my [Quickstart](#quickstart) it will guide you through the setup of a new mac.  You can also use this on your current mac, but if you run the `setup.sh` script it will overwrite a lot of your current settings.

* [Quickstart](#quickstart)
* [Post Setup](#post-setup)
* [Setup Explained](#setup-explained)
* [Customization](#customization)
  * [vim](#vim)
  * [Dev Environments](#dev-environments)
    * [python](#python)
    * [node](#node)
    * [clojure](#clojure)
  * [Dev Tools](#dev-tools)
    * [Atom](#atom)
    * [iterm2](#iterm2)
    * [duti](#duti)


##  Quickstart

This setup is tested on:

* macOS 10.12.x Sierra

The following will provide a quick outline / checklist of tasks you should complete before using these dotfiles.  The following guide assume you have
some understanding of the terminal.  Any command prefixed with `$` means to run it in the terminal.

**1.  Update macOS**

> Just making sure everything is up-to-date :)


**2.  Install Xcode Command Line Tools**

```bash
$ xcode-select --install
```


**3.  move into your home directory**

```bash
$ cd ~/
```

**4.  clone this repo**

```bash
$ git clone https://github.com/tkjone/dotfiles
```


**5.  Setup diff-highlighter**

`diff-highlight` is going to make your diffs look pretty, but based on the version of git you have, you will have to perform these steps:

> 1.  Find diff-highlight

```bash
$ find -L /usr -name diff-highlight -type f
```

> 2.  Choose the path with the highest git version

```bash
/usr/local/Cellar/git/2.11.0/share/git-core/contrib/diff-highlight/diff-highlight
```

The number your looking for in the above path is right after `git` --> `2.11.0`


> 5.  Open `.gitconfig`

```bash
vim ~/dotfiles/git/.gitconfig
```


> 6.  Replace the path on line 13 in the `.gitconfig` with the path from `step 2`.

```bash
pager = /usr/local/Cellar/git/2.11.0/share/git-core/contrib/diff-highlight/diff-highlight | diff-so-fancy | less -r
```


**6.  .macOS paths**

please take a look at `~dotfiles/.macOS`. This file has preferences that I prefer to use to configure my mac. Based on my own preferences, you may want to take a look at the following and decided if they are good for you or not:

* section - iterm2
  * This is going to tell iterm2 to use the preferences I have setup in these dotfiles.  If you do not want them, comment this line out.

* section - screen:
  * where the screenshots are stored


**7.  run the setup script**

```bash
$ source ~/dotfiles/setup.sh
```


## Post Setup

Once the above is complete, I like to perform the following tasks:

* restart computer
* setup default browser
* set the items that you want to appear in your dock
* set the capslock key to be the modifier key
* setup your screensave/lock to occur after 2 min
* setup nice [screen savers](https://github.com/JohnCoates/Aerial)
* turn off spotlight suggestions
* password storage
* setup [nvm](https://github.com/creationix/nvm)
* [git ssh keys](https://help.github.com/articles/connecting-to-github-with-ssh/)


## Setup Explained

The `setup.sh` file is going to do all the heavy lifting and automate as many things as we can.  In order, it will:

* Install Brew
* Brew install everything in the [Brewfile](https://robots.thoughtbot.com/brewfile-a-gemfile-but-for-homebrew)
* Symlink dotfiles
* Set the default shell environment to zsh
* Setup Sublime Text - Specifically, setup `subl` and replace the default icon
* Setup preferred macOS settings

## Customization

### vim

There may be `.zshrc` aliases or configurations that you may want to keep private, you can create a file called `.extras` in the `zsh` directory and this will be picked up by `.zsh_profile`.

### Dev Environments

This section will outline different development languages / environments that this setup supports.  These are the languages that I tend to work with.  However, you will notice that the setups are usually package managers.  This is because I use vagrant or docker and do not need specific versions of the following languages installed.

#### Python

* virtualenvwrapper

#### Node

* nvm

#### Clojure

* jenv
* basic java setup

### Atom

* make sure to install package.sync to be able to make use of `package.cson`

### iterm2

* I activate scroll functionality so you can just use the trackpad for long pieces of text - e.g. `man defaults`
* solarized color scheme - well thought out color scheme
* `command + d` will bring up iterm2 when in the background - very handy when you are an active terminal user - something I picked up from linux, quake terminal

### duti

- duti is a program built to make it easier to configure which filetypes are opened by which application.  For example, lets say you want all `.html` files to be opened by `Atom` and not the default browser, we can configure this in Duti.  For more info, see the .duti` file.
