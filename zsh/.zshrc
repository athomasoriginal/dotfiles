# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

#==============================================================================
# ZSH SETTINGS
#==============================================================================

ZSH_THEME="thomas"        # zsh theme
export UPDATE_ZSH_DAYS=13 # how often to auto-update zsh
plugins=(                 # plugins to load.
    git
    colored-man
    colorize
    github
    jira
    vagrant
    virtualenv
    pip
    python
    brew
    osx
    zsh-syntax-highlighting
)

#==============================================================================
# USER SETTINGS
#==============================================================================

export PATH="/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" # export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#==============================================================================
# ALIASES
#==============================================================================

alias zshconfig="subl ~/dotfiles/zsh/.zshrc"     # open zshrc with sublime
alias envconfig="subl ~/Projects/config/env.sh"  # open env with sublime
alias dotfiles="cd ~/dotfiles"                   # open dotefiles with sublime
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app' # show hidden files
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'  # hide hidden files

#==============================================================================
# PYTHON
#==============================================================================

# virtualenvwrapper configuration
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/source
source /usr/local/bin/virtualenvwrapper.sh

#==============================================================================
# NODE
#==============================================================================

export NVM_DIR="/Users/thomasmattacchione/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#==============================================================================
# ANDROID
#==============================================================================
export ANDROID_HOME=/usr/local/opt/android-sdk

#==============================================================================
# RUBY
#==============================================================================
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
