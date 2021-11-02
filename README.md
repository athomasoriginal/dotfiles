# DOTFILES

Welcome to my dotfiles; You are very welcome to use them :smile:

You can take what you like from these dotfiles a la carte, or feel free to use
the [Quickstart] below which will walk you through how I setup a
new mac for development.

- [Quickstart]
- [Setup Explained]
- [Gotchas]
- [Customization]
  - [vim](#vim)
  - [Dev Environments](#dev-environments)
    - [node](#node)
    - [clojure](#clojure)
  - [Dev Tools](#dev-tools)
    - [Atom](#atom)
    - [nvim](#nvim)
    - [iterm2](#iterm2)
    - [duti](#duti)
  - [macos]
- [Zsh Performance]
- [Extras]
  - [Aliases]


## Quickstart

> This setup has been tested on macOS **10.12.x** Sierra and up.  Some of the
> commands belows might be specific to my tastes.  When this is the case I have
> added an "optional" label to the step.  You can ignore these if you like.
> Commands beginning with `$` are meant to be run in the terminal.

- Update macOS
  - [upgrade macos](https://support.apple.com/en-ca/HT201541)
  > rationale: we're making sure everything on your system is good to go :smile:
- Install Xcode Command Line Tools
  ```bash
  $ xcode-select --install
  ```
  > Xcode is needed to install dev tools
- move into your home directory
  ```bash
  $ cd ~/
  ```
  > We will install dotfiles here
- clone this repo
  ```bash
  $ git clone https://github.com/tkjone/dotfiles
  ```
  > This is you installing your dotfiles
- create your own private dotfiles
  ```bash
  $ touch dotfiles/git/.gitconfig.local
  $ touch dotfiles/zsh/.extras
  ```
  > Our dotfiles are generally public.  However, sometimes you will want to have
  > configurations which are specific to your local setup.  These files give
  > you the space to have yoru private configurations.
- Install zsh-highlight (optional)
  ```bash
  see https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
  ```
- Install [nvm] (optional)
- open `.gitconfig.local` in your editor of choice
  ```bash
  $ vim git/.gitconfig.local
  ```
  > I have `vim`  selected here because it will be on most peoples machines.
- Configure your `.gitconfig.local**`
  ```bash
  [user]
    name = <your-git-username>
    email = <your-email>
  ```
  > More details can be found in [local gitconfig]
- verify the `.macOS` file
  - This step is really about choosing what you like and don't like in my `.macos`
    file.  This file, located at `~dotfiles/.macOS`, is a file that configures
    your mac. Not sure what this means? Well, you know how when you get a mac
    you have to make decisions like the sensitivty level of your trackpad, or
    your display settings? Turns out you can automate this setup. This file is
    going to automate these things for you.  With this in mind, these are
    preferences for how I like to work with my mac. Most are pretty good!  The
    ones that I think may be specific to me are listed below.  You should take
    a look and verify that you want to keep them.  Just delete or comment out
    the stuff you don't want.
  - section - iterm2
    - This is going to tell iterm2 to use the preferences I have setup in
        these dotfiles. If you do not want them, comment this line out.
  - section - screen:
    - where the screenshots are stored
- verify the `brewfile` file
  - The `brewfile` contains programs I usually always need.  Delete or comment
    out what you don't need.
- Run the setup script
  ```bash
  $ source ~/dotfiles/setup.sh
  ```
  > Please note that you will be prompted to enter your computer password while
  > the brew apps are being installed. To see what this is doing, checkout
  > the [Setup Explained] section

Once you have completed the above steps, I like to perform the following steps
just as a sanity check:

- restart computer
- verify iterm2 preferences are read from dotfiles

## Setup Explained

The `setup.sh` file is going to do all the heavy lifting and automate as many
hings as we can. It will perform the following tasks in order:

- Install Brew
- Brew install everything in the [Brewfile](https://robots.thoughtbot.com/brewfile-a-gemfile-but-for-homebrew)
- Symlink dotfiles
- Set the default shell environment to zsh
- Setup preferred macOS settings

## Gotchas

- iterm 2 syntax highlighting not displaying correctly?
  - See [iterm2 launch with zsh](https://stackoverflow.com/questions/13476232/make-iterm2-launch-with-zsh)

## Customization

### zsh

The `zsh` setup that comes with these dotfiles are going to do the following
things:

- setup oh-my-zsh
- A custom theme called "Thomas" (include my prompt setup)
- Ability to load custom zsh settings via a file called `.extras` (see below for
  more details)
- A few custom aliases that I find generally useful
- Node - nvm setup
- Java - jenv

Aside from the above I keep it light because its my feeling that `.zshrc` is a
personal thing

**Custom Zsh Settings**

There may be `.zshrc` aliases or configurations that you may want to keep private,
you can create a file called `.extras` in the `zsh` directory and this will be
picked up by `.zsh_profile`.

### Dev Environments

This section will outline different development languages / environments that this setup supports. These are the languages that I tend to work with. However, you will notice that the setups are usually package managers. This is because I use vagrant or docker and do not need specific versions of the following languages installed.

#### Node

The only thing that is node specific for our setup is `nvm`.  This is a great tool for managing version of node.  The issue though is this tool is slow in zsh!  So instead of loading it on init, we add a `loadnvm` alias and you run this when you want to use it.

Isn't this cumbersome?  Doubling the time it takes to start your shell is significantly worse.

#### Clojure

- jenv
- basic java setup

### Atom

- [sync atom](https://evanhahn.com/atom-apm-install-list/)
- make sure to install [package.sync](https://atom.io/packages/package-sync) to be able to make use of `package.cson` that I provide which is what I use to transfer my preferred atom settings from one computer to another.

### nvim

Experimenting with this.  Not daily driver.

- Running nightly so we can use telescope
- Install Rust Cargo (this is for parinfer-rust)
- Install [vim-plugin](https://github.com/junegunn/vim-plugs)
- If using `nvim-web-devicons` be sure to have [Nerd Font]
- Installing plugins - type `:PlugInstall` into vim
- Install and Build [parinfer-rust](https://github.com/eraserhd/parinfer-rust)
- If `vim-prettier` can't find the prettier exe:
  - move to `~/.vim/plugin/vim-prettier`
  - run yarn install

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

[Quickstart]: #quickstart
[Post Setup]: #post-setup
[Setup Explained]: #setup-explained
[Gotchas]: #Gotchas
[Customization]: #customization
[macos]: #macos
[Extras]: #extras
[Aliases]: #aliases


[Preferences by the commandline]: https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
[Nerd Font]: https://www.nerdfonts.com/
[Install Raycast]: https://raycast.com/
[Disable spotlight hotkey]: https://www.notion.so/Hotkey-56103210375b4fc78b63a7c5e7075fb7
[Zsh Performance]: https://htr3n.github.io/2018/07/faster-zsh/
[local gitconfig]: https://coderwall.com/p/wkqf9q/local-global-git-config
[nvm]: https://github.com/creationix/nvm
