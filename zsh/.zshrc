export ZSH=$HOME/.oh-my-zsh     # Path to oh-my-zsh installation
export DOTFILES=$HOME/dotfiles  # path to dotfiles

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
    zsh-nvm
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
alias dotfiles="cd ~/dotfiles"                   # open dotfiles
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app' # show hidden files
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'  # hide hidden files

alias emacs="/usr/local/Cellar/emacs-plus/25.1/Emacs.app/Contents/MacOS/Emacs"

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

# uncomment the following if you want to manually setup zsh in this file
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#==============================================================================
# ANDROID
#==============================================================================
# uncomment the following if you want to start android development
# export ANDROID_HOME=/usr/local/opt/android-sdk

#==============================================================================
# RUBY
#==============================================================================
export PATH="$PATH:$HOME/.rvm/bin"    # Add RVM to PATH

export PATH="$HOME/.rbenv/bin:$PATH"  # Add rbenv to PATH
eval "$(rbenv init -)"

#==============================================================================
# JAVA
#==============================================================================
eval "$(jenv init -)"

