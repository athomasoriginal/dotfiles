# @profiling enable the following when you want to see what is taking a long
#            time to load.  To use:
#   - Change this file
#   - Reload by running `exec zsh`
#   - Run `zprof` to see the results
#
# and another way to track this is
#
#   - /usr/bin/time zsh -i -c exit
#   - for i in $(seq 1 10); do /usr/bin/time /bin/zsh -i -c exit; done;
#
# zmodload zsh/zprof

# Add `~/bin` to the `$PATH`
#export PATH="/usr/local/bin:$PATH"


export ZSH=$HOME/.oh-my-zsh     # Path to oh-my-zsh installation
export DOTFILES=$HOME/dotfiles  # path to dotfiles
export GPG_TTY=$(tty)           # GPG git commit signing

# ------------------------------------------------------------------------------
# ZSH Config
# ------------------------------------------------------------------------------

export ZSH=$HOME/.oh-my-zsh     # Path to oh-my-zsh installation

# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2308206 speed
# up the zsh load time by only checking if zcompdump needs regenerating once a
# day
autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

# zsh theme name - see `themes/thomas.zsh-theme`
ZSH_THEME="thomas"

# auto-update zsh after 13 days
export UPDATE_ZSH_DAYS=13

# make zsh-syntax-highlighting available - highlight cli commands as typing
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh plugins to improve your workflow
plugins=(
    # syntax highlight man pages for easier reading
    colored-man-pages
    # syntax higlight by file extension
    colorize
    # shortcuts like `hidefiles` & `showfiles`
    macos
)

# be sure to source this after you specify the plugins above or they will all
# not work as expected
source $ZSH/oh-my-zsh.sh



# ------------------------------------------------------------------------------
# USER SETTINGS
# ------------------------------------------------------------------------------

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Load shell dotfiles, and user specific configs:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extras can be used for other settings you don’t want to commit.
for file in ~/.{path,extras}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;




# ------------------------------------------------------------------------------
# ALIASES
# ------------------------------------------------------------------------------

# quick access to config files
alias dotfiles="cd ~/dotfiles" # open dotfiles

# docker
alias containers="docker ps --format 'table {{.Names}}\t{{.Image}}'"

# ------------------------------------------------------------------------------
# NODE
# ------------------------------------------------------------------------------
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_DIR="$HOME/.nvm"

alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'

# ------------------------------------------------------------------------------
# JAVA
# ------------------------------------------------------------------------------

# @performance jenv is slow.  This is a lazy loading technique we learned from
# https://github.com/shihyuho/zsh-jenv-lazy/blob/master/jenv-lazy.plugin.zsh
# I have no idea why I didn't just install as a custom plugin.  Likely, I was
# frustrated that jenv was taking 50% of the total load time.
export JENV_ROOT="${JENV_ROOT:=${HOME}/.jenv}"
if ! type jenv > /dev/null && [ -f "${JENV_ROOT}/bin/jenv" ]; then
    export PATH="${JENV_ROOT}/bin:${PATH}"
fi

# Lazy load jenv
if type jenv > /dev/null; then
    export PATH="${JENV_ROOT}/bin:${JENV_ROOT}/shims:${PATH}"
    function jenv() {
        unset -f jenv
        eval "$(command jenv init -)"
        jenv $@
    }
fi


# ------------------------------------------------------------------------------
# POSTGRES
# ------------------------------------------------------------------------------
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin


# ------------------------------------------------------------------------------
# Clojure
# ------------------------------------------------------------------------------

# alias to call zprint for code formatting
alias pz="/usr/local/bin/zprint"

# vim-iced
export PATH=$PATH:~/.vim/plugged/vim-iced/bin


# ------------------------------------------------------------------------------
# Wireshark
# ------------------------------------------------------------------------------

alias cap="dumpcap -i 1 -i 10 -w ~/wireshark-capture/data.pcapng -b filesize:500000 -b files:5"

export PATH=$PATH:/Applications/Wireshark.app/Contents/MacOS$PATH

# ------------------------------------------------------------------------------
# Rust
# ------------------------------------------------------------------------------

export PATH=$PATH:$HOME/.cargo/bin
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# ------------------------------------------------------------------------------
# Odin
# ------------------------------------------------------------------------------

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"


# ------------------------------------------------------------------------------
# Kamal
# ------------------------------------------------------------------------------
# run `loadruby` to install (only if needed) Ruby 3.4.1 and then source chruby
# so we can use our version of Ruby in the current session.  The reason for
# this is because I don't require Ruby in my regular work, so no need to add
# to the session unless I call for it.
# https://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/
alias loadruby='
    version=3.4.1
    source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
    source $(brew --prefix)/opt/chruby/share/chruby/auto.sh

    if ! chruby | grep -q "ruby-${version}"; then
        echo "Ruby ${version} not found, installing..."
        ruby-install ruby-${version}
        echo "Ruby ${version} installed. Now enabling..."
        chruby ruby-${version}
    else
      echo "Ruby ${version} found, enabling..."
      chruby ruby-${version}
    fi'
