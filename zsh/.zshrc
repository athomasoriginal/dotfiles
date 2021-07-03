# @profiling this is enabled when you want to see what is taking a long time to
# load.  To use:
#   - Change this file
#   - Reload by running `exec zsh`
#   - Run `zprof` to see the results
# and another way to track this is
#   - /usr/bin/time zsh -i -c exit
#   - for i in $(seq 1 10); do /usr/bin/time /bin/zsh -i -c exit; done;
# zmodload zsh/zprof

export ZSH=$HOME/.oh-my-zsh     # Path to oh-my-zsh installation
export DOTFILES=$HOME/dotfiles  # path to dotfiles

# ------------------------------------------------------------------------------
# ZSH Config
# ------------------------------------------------------------------------------

# zsh theme name - see `themes/thomas.zsh-theme`
ZSH_THEME="thomas"

# auto-update zsh after 13 days
export UPDATE_ZSH_DAYS=13

# zsh plugins to improve your workflow
plugins=(
    # manage nvm and help us improve load performance
    zsh-nvm
    # syntax highlight man pages for easier reading
    colored-man-pages
    # syntax higlight by file extension
    colorize
    # shortcuts like `hidefiles` & `showfiles`
    osx
    # syntax hilight cli commands as you're typing
    zsh-syntax-highlighting
)

# be sure to source this after you specify the plugins above or they will all
# not work as expected
source $ZSH/oh-my-zsh.sh

# ------------------------------------------------------------------------------
# USER SETTINGS
# ------------------------------------------------------------------------------

# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/.jenv/bin:$PATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,extras}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


# Add `~/bin` to the `$PATH`
export PATH="/usr/local/bin:$PATH"


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

# # load nvm
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
#
#  # nvm bash_completion
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ------------------------------------------------------------------------------
# JAVA
# ------------------------------------------------------------------------------
eval "$(jenv init -)"


# ------------------------------------------------------------------------------
# POSTGRES
# ------------------------------------------------------------------------------
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin


# ------------------------------------------------------------------------------
# Clojure
# ------------------------------------------------------------------------------

# alias to call zprint for code formatting
alias pz="/usr/local/bin/zprint"
