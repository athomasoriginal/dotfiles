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

# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/.jenv/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,extras}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

#==============================================================================
# ALIASES
#==============================================================================

# general
alias zshconfig="subl ~/dotfiles/zsh/.zshrc"     # open zshrc with sublime
alias dotfiles="cd ~/dotfiles"                   # open dotfiles
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app' # show hidden files
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'  # hide hidden files

# docker
alias containers="docker ps --format 'table {{.Names}}\t{{.Image}}'"

#==============================================================================
# PYTHON
#==============================================================================

# virtualenvwrapper configuration
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/source

# tell virtual env exactly which python interpreter and local of vw
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

#==============================================================================
# NODE
#==============================================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#==============================================================================
# JAVA
#==============================================================================
eval "$(jenv init -)"


#==============================================================================
# POSTGRES
#==============================================================================
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
