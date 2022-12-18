# DOTFILES

Welcome to my dotfiles; You are very welcome to use them :smile:

You can take what you like from these dotfiles a la carte, or feel free to use
the [Quickstart] below which will walk you through how I setup a
new mac for development.

- [Quickstart]
- [Gotchas]
- [Language Details]
  - [node]
  - [clojure]
- [Dev Tools]
  - [Neovim]
  - [iterm2]
  - [duti]
  - [macos]
- [Extras]
  - [Aliases]
- [Graveyard]


## Quickstart Explained

> This setup has been tested on macOS **10.12.x** Sierra and up.  Some of the
> commands belows might be specific to my tastes.  When this is the case I have
> added an "optional" label to the step.  You can ignore these if you like.
> Commands beginning with `$` are meant to be run in the terminal.


This quickstart is going to run through all the steps required to start using
these dotfiles.  As much of the process as we're comfortable with automating
has been automated.  At a high level, here is what you will do (don't worry,
it's all explained below in detail):

- Download the dotfiles
- Install Brew
- Brew install everything in the [Brewfile]
- Symlink dotfiles
- Set the default shell environment to zsh
- Run the `setup.sh` script
- preferred macOS settings

And with that, let's start with setting up the dotfiles:

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
  $ git clone https://github.com/athomasoriginal/dotfiles.git
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
- Install [nvm] (optional)
- open `.gitconfig.local` in your editor of choice
  ```bash
  $ vim dotfiles/git/.gitconfig.local
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
  - Open `.macOS` file
  - Update the 3 variables at the top:
    ```bash
    COMPUTERNAME="your-comp-name"
    HOSTNAME='your-host-name'
    LOCALHOSTNAME='your-local-host-name'
    ```
  > This step is really about choosing what you like and don't like in my `.macos`
  > file.  This file, located at `~dotfiles/.macOS`, is a file that configures
  > your mac. Not sure what this means? Well, you know how when you get a mac
  > you have to make decisions like the sensitivty level of your trackpad, or
  > your display settings? Turns out you can automate this setup. This file is
  > going to automate these things for you.  With this in mind, these are
  > preferences for how I like to work with my mac. Most are pretty good!  The
  > ones that I think may be specific to me are listed below.  You should take
  > a look and verify that you want to keep them.  Just delete or comment out
  > the stuff you don't want.
  - section - iterm2
    - This is going to tell iterm2 to use the preferences I have setup in
        these dotfiles. If you do not want them, comment this line out.
  - section - screen:
    - where the screenshots are stored
- verify the `brewfile`
  - The `brewfile` contains programs I usually always need.  Delete or comment
    out what you don't need.
- Move into `dotfiles` dir
- Run the setup script
  ```bash
  $ source setup.sh
  ```
  > Please note that you will be prompted to enter your computer password while
  > the brew apps are being installed. To see what this is doing, checkout
  > the [Setup Explained] section
- Install zsh-highlight (optional)
  ```bash
  see https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
  ```
- Open new terminal tab and make sure there are no warnings

Once you have completed the above steps, I like to perform the following steps
just as a sanity check:

- restart computer
- verify iterm2 preferences are read from dotfiles.  To do this:
  - Open `iterm2`
  - load preferences from custom folder and enter the `path/to/profiles`
  - Custom theme
    - ensure the symlink was executed correctly
- verify `.zshrc` is symlinked correctly



## Gotchas

- iterm 2 syntax highlighting not displaying correctly?
  - See [iterm2 launch with zsh]

## Language Details

This section outlines what language configurations exist in our zsh profile and
why:

### zsh

Our `zsh` setup comes with the following configurations:

- initialization of oh-my-zsh
- zsh prompt
- A custom theme called "Thomas"
- Support for custom zsh settings: `.extras`
- Helpful, common aliases
- [Zsh Performance] optimizations
  - Node - nvm initialization
  - Java - jenv initialization

**Custom Zsh Settings**

There may be `.zshrc` aliases or configurations that you may want to keep private,
you can create a file called `.extras` in the `zsh` directory and this will be
picked up by `.zsh_profile`.

### Node

The only thing that is node specific for our setup is `nvm`.  This is a great
tool for managing node versions.  Now, there is a problem with this tool: it's
going to slow down the initialization of your terminal app!  Our solution to this
is to optimize by adding a `loadnvm` alias and you run this when you want to use
it.

### Clojure

Similar to Node and nvm, we use jenv with Java.  Yes, this also slows down the
initialization of your terminal so we apply a similar performance optimizing
strategy.

## Dev Tools

This section outlines how to get started with some of the main tools in my kit.
Yes, the Dotfiles installed these things, but there is a little further to go.
Why not automate?  That requires more testing and maintenance cost than I want
to think about right now.


### Neovim

I use nvim + atom, the following are some notes for getting up and running with
nvim based on the configurations in these dotfiles.

- Install [vim-plugin]
- Install [Rust and Cargo]
  - This is required to use the `parinfer-rust` nvim plugin
- Install and Build [parinfer-rust]
- Install [ripgrep] for live_search with telescope
- Install zprint
  - This is for Clojure development
  - `brew install zprint`
- Install [Nerd Font]
  - This is required to use the `nvim-web-devicons`
- Open Nvim
- Install Plugins
  ```bash
  :PlugInstall
  ```
  > The casing is important

**Gotchas**

- If `vim-prettier` can't find the prettier exe:
  - move to `~/.vim/plugged/vim-prettier`
  - run yarn install
  > This should be a last resort though as our configuration of this plugin should
  > just do this for us automatically.  Also note that if you don't autoload nvm
  > like me, run that first.

### iterm2

- Settings
  - I activate scroll functionality so you can just use the trackpad for long
    pieces of text. For example, try typing `man defaults` into your terminal.
    When you have to scroll this kind of long document in your terminal, it can
    get janky. This helps to avoid that.
- Color Themes
  - Solarized - especially amazing if you ever code outside or in a room with a
    lot of sunlight
- hotkeys
  - `command + d` will bring up iterm2 when in the background - very handy when
     you are an active terminal user - something I picked up from
    [guake terminal]

### duti

duti is a program built to make it easier to configure which filetypes are
opened by which application. For example, lets say you want all `.html` files
to be opened by `Sublime` and not the default browser, we can configure this in
Duti. For more info, see the `.duti` file.

### macos

- [Preferences by the commandline]

## Extras

These are some helpful extras which I figure could be helpful to just show people

### Aliases

- Count lines by file type
  ```bash
  alias repocount="git ls-files | grep '\.clj' | xargs wc -l"
  ```

## Graveyard

> This section is for my fallen Homies. 🪦 🍻

- Atom - Mid 2022
  - started to transition for the speed, simplicity and flexibility.  This is
    in the time where big IDE has taken over.  Yes, I'm looking at you VS Code,
    Jet Brains etc.

[Quickstart]: #quickstart
[Post Setup]: #post-setup
[Setup Explained]: #setup-explained
[Gotchas]: #Gotchas
[Language Details]: #language-details
[macos]: #macos
[Extras]: #extras
[Aliases]: #aliases
[node]: #node
[clojure]: #clojure
[Dev Tools]: #dev-tools
[Neovim]: #Neovim
[iterm2]: #iterm2
[duti]: #duti
[macos]: #macos
[Graveyard]: #Graveyard

[Preferences by the commandline]: https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
[Nerd Font]: https://www.nerdfonts.com/
[Install Raycast]: https://raycast.com/
[Disable spotlight hotkey]: https://www.notion.so/Hotkey-56103210375b4fc78b63a7c5e7075fb7
[Zsh Performance]: https://htr3n.github.io/2018/07/faster-zsh/
[local gitconfig]: https://coderwall.com/p/wkqf9q/local-global-git-config
[nvm]: https://github.com/creationix/nvm
[package.sync]: https://atom.io/packages/package-sync
[vim-plugin]: https://github.com/junegunn/vim-plug
[Rust and Cargo]: https://doc.rust-lang.org/cargo/getting-started/installation.html
[parinfer-rust]: https://github.com/eraserhd/parinfer-rust
[guake terminal]: https://github.com/Guake/guake
[Brewfile]: https://robots.thoughtbot.com/brewfile-a-gemfile-but-for-homebrew
[iterm2 launch with zsh]: https://stackoverflow.com/questions/13476232/make-iterm2-launch-with-zsh
[sync atom]: https://evanhahn.com/atom-apm-install-list/
[ripgrep]: https://github.com/BurntSushi/ripgrep
