# DOTFILES

Welcome to my dotfiles; You are very welcome to use them :smile:

I try to focus my dotfiles on the basics, thus attempting to avoid making anything overly specific to my own idiosyncrasies.

You can take what you like from these dotfiles a la carte, or feel free to use my [Quickstart](#quickstart) which will walk you through how I setup a new mac for development.

- [Quickstart](#quickstart)
- [Post Setup](#post-setup)
- [Setup Explained](#setup-explained)
- [Gotchas](#Gotchas)
- [Customization](#customization)
  - [vim](#vim)
  - [Dev Environments](#dev-environments)
    - [python](#python)
    - [node](#node)
    - [clojure](#clojure)
  - [Dev Tools](#dev-tools)
    - [Atom](#atom)
    - [iterm2](#iterm2)
    - [duti](#duti)
  - [macos]
- [Extras]
  - [Aliases]

## Quickstart

This setup has been tested on:

- macOS 10.12.x Sierra and up

**Housekeeping**

These instructions are very detailed and should be followed in order. I also assume that if you are working through this you have some understanding of the terminal. Any command prefixed with `$` means to run it in the terminal.

**1. Update macOS**

Nothing special here, just the [run-of-the-mill upgrade process](https://support.apple.com/en-ca/HT201541)

> The reasoning here: we are making sure everything on your system is good to go :smile:

**2. Install Xcode Command Line Tools**

```bash
$ xcode-select --install
```

> Xcode is needed to perform future development setup related tasks

**3. move into your home directory**

```bash
$ cd ~/
```

> This is where you will install your dotfiles

**4. clone this repo**

```bash
$ git clone https://github.com/tkjone/dotfiles
```

> This is you installing your dotfiles

**5. create private files**

```bash
$ touch dotfiles/git/.gitconfig.local
$ touch dotfiles/zsh/.extras
```

> These are called "private" files because they are where you will put code specific to your setup. you will see what `.gitconfig.local` does in the next step. For more info on `.extras` see the [zsh customization](#zsh) section further down.

**6. Setup diff-highlighter**

`diff-highlight` is going to make your git diffs look pretty, but there is a little bit of a manual process involved in setting this up:

> 1.  Find diff-highlight

```bash
$ find -L /usr -name diff-highlight -type f
```

The above command may respond with a `permission denied` and if it does try running this: `sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local`.

> 2.  Choose the path with the highest git version

```bash
/usr/local/Cellar/git/2.30.1/share/git-core/contrib/diff-highlight/diff-highlight
```

The segment of the above path that matters is `2.30.1` as this is the version of git you are using locally.

> 3.  Open `.gitconfig`

```bash
vim ~/dotfiles/git/.gitconfig
```

> 4.  Replace the path on line 13 in the `.gitconfig` with the path from `step 2`.

```bash
pager = /usr/local/Cellar/git/2.30.0/share/git-core/contrib/diff-highlight/diff-highlight | diff-so-fancy | less -r
```

**7. Install zsh-highlight**

```bash
see https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
```

**8. open .gitconfig.local in your favourite editor**

```bash
$ vim git/.gitconfig.local
```

> You can swap out `vim` for your fav' editor. For example, if you use atom the above would become `atom git/.gitconfig.local`

**9. update .gitconfig.local**

```bash
[user]
  name = <your-username>
  email = <your-email>
```

> More details can be found [here](https://coderwall.com/p/wkqf9q/local-global-git-config)

**10. .macOS paths**

Please take a look at `~dotfiles/.macOS`. This is a file that configures your mac. Not sure what this means? Well, you know how when you get a mac you have to make decisions like the sensitivty level of your trackpad, or your display settings? Turns out you can automate this setup. This file is going to automate these things for you.

With this in mind, these are preferences for how I like to work with my mac. Most are pretty good, but I feel that you want to specifically decide if the following are good for you:

- section - iterm2

  - This is going to tell iterm2 to use the preferences I have setup in these dotfiles. If you do not want them, comment this line out.

- section - screen:
  - where the screenshots are stored

**11. Before you run setup scripts**

Take a gander through the `brewfile`, this dotfiles sub dirs and make sure that what you setup is applicable. Its easy to go back and fix things, but this is a good time to remove things that might not be useful to you.

**12. run the setup script**

```bash
$ source ~/dotfiles/setup.sh
```

> Please note that you will be prompted to enter your computer password while the brew apps are being installed. To see what this is doing, checkout the [Setup Explained](#setup-explained) section

## Post Setup

Once the above is complete, I like to perform the following tasks:

- restart computer
- setup default browser
- set the items that you want to appear in your dock
- set the [capslock key to be the modifier key](https://coderwall.com/p/cq_lkg/remapping-caps-lock-key-to-something-more-natural-on-mac-os-x)
- [setup your screensave/lock](https://it.cornell.edu/device-security/set-your-macs-screen-lock-automatically) to occur after 2 min (security)
- setup custom [beautiful screen savers](https://github.com/JohnCoates/Aerial)
- turn off spotlight suggestions (security)
- password storage (lastpass/1password)
- update your screen resolution -> system preferences -> display -> scaled + "more space"
- install [nvm](https://github.com/creationix/nvm) (mainly for JS developers)
- setup [git ssh keys](https://help.github.com/articles/connecting-to-github-with-ssh/)
- [sync atom](https://evanhahn.com/atom-apm-install-list/)

## Setup Explained

The `setup.sh` file is going to do all the heavy lifting and automate as many things as we can. It will perform the following tasks in order:

- Install Brew
- Brew install everything in the [Brewfile](https://robots.thoughtbot.com/brewfile-a-gemfile-but-for-homebrew)
- Symlink dotfiles
- Set the default shell environment to zsh
- Setup Sublime Text - Specifically, setup `subl` and replace the default icon
- Setup preferred macOS settings

## Gotchas

**iterm 2 syntax highlighting not displaying correctly**

See [iterm2 launch with zsh](https://stackoverflow.com/questions/13476232/make-iterm2-launch-with-zsh)

## Customization

### zsh

The `zsh` setup that comes with these dotfiles are going to do the following things:

- setup oh-my-zsh
- A custom theme called "Thomas" (include my prompt setup)
- Ability to load custom zsh settings via a file called `.extras` (see below for more details)
- A few custom aliases that I find generally useful
- Python config setup - virtualenvwrapper
- Node - nvm setup
- Java - jenv

Aside from the above I keep it light because its my feeling that `.zshrc` is a personal thing

**Custom Zsh Settings**

There may be `.zshrc` aliases or configurations that you may want to keep private, you can create a file called `.extras` in the `zsh` directory and this will be picked up by `.zsh_profile`.

### Dev Environments

This section will outline different development languages / environments that this setup supports. These are the languages that I tend to work with. However, you will notice that the setups are usually package managers. This is because I use vagrant or docker and do not need specific versions of the following languages installed.

#### Python

- The preference of these dotfiles is `Python3` as such, after you have run these dotfiles, python can be accessed by typing `python3` in the terminal.
- You will have access to `pip` via `pip3`
- Inline with the above note, virtualenvwrapper is set to use python3 by default.

**Gotcha**

In the event you run into a message from virtualenvwrapper like this:

```bash
virtualenvwrapper.sh: There was a problem running the initialization hooks...
```

Try running

```bash
$ pip3 install virtualenvwrapper
```

> We run the above command during the install and the above issue occurs infrequently so there should not be too much worry here.

#### Node

- nvm

#### Clojure

- jenv
- basic java setup

### Atom

- make sure to install [package.sync](https://atom.io/packages/package-sync) to be able to make use of `package.cson` that I provide which is what I use to transfer my preferred atom settings from one computer to another.

### iterm2

- I activate scroll functionality so you can just use the trackpad for long pieces of text. For example, try typing `man defaults` into your terminal. When you have to scroll this kind of long document in your terminal, it can get janky. This helps to avoid that.
- solarized color scheme - especially amazing if you ever code outside or in a room with a lot of sunlight
- `command + d` will bring up iterm2 when in the background - very handy when you are an active terminal user - something I picked up from [guake terminal](https://github.com/Guake/guake)

### duti

- duti is a program built to make it easier to configure which filetypes are opened by which application. For example, lets say you want all `.html` files to be opened by `Atom` and not the default browser, we can configure this in Duti. For more info, see the `.duti` file.

### macos

- [Preferences by the commandline]

## Extras

These are some helpful extras which I figure could be helpful to just show people

### Aliases

- Count lines by file type
  ```bash
  alias repocount="git ls-files | grep '\.clj' | xargs wc -l"
  ```

[macos]: #macos
[Extras]: #extras
[Aliases]: #aliases
[Preferences by the commandline]: https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
