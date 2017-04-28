# =============================================================================
# setup
# =============================================================================
# Welcome to the startup file.  When you run this file, it will attempt to
# install a number of apps, folders and files that the author likes.


# =============================================================================
# helpers
# =============================================================================
# The info, success and fail helpers are inspired by holman/dotfiles

info() {
    printf "\r [ \033[00;34mINFO\033[0m ] $1\n"
}

success() {
    printf "\r\033[2k [ \033[00;32mOK\033[0m ]   $1\n"
}

fail() {
    printf "\r\033[2k [ \033[0;31mFAIL\033[0m ] $1\n"
}

# =============================================================================
# Setup
# =============================================================================

info "Setting up your mac..."

# brew
# =============================================================================

info "Brew - Checking if brew is already installed"
if test ! $(which brew); then
    # http://brew.sh/
    info "Brew - Install"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

info "Brew - Updating Recipes"
brew update

info "Brew - Upgading packages"
brew upgrade

info "Brew - installing all the brew 'tings"
brew tap homebrew/bundle
brew bundle

# oh-my-zsh
# =============================================================================

info "oh-my-zsh - installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# dotfile setup
# =============================================================================

info "dotfiles - removing existing dotfiles"
rm -rf ~/.zsh_profile
rm -rf ~/.zshrc
rm -rf ~/.atom
rm -rf ~/.gitconfig
rm -rf ~/.gitignore
rm -rf ~/.gitcommitmessage
rm -rf ~/.vimrc
rm -rf ~/.extras
rm -rf ~/.oh-my-zsh/themes/thomas.zsh-theme
rm -rf ~/.duti
rm -rf ~/.tmux.conf

info "dotfiles - symlinking dotfiles"
ln -s ~/dotfiles/zsh/.zsh_profile             ~/.zsh_profile
ln -s ~/dotfiles/zsh/.zshrc                   ~/.zshrc
ln -s ~/dotfiles/atom/                        ~/.atom
ln -s ~/dotfiles/zsh/themes/thomas.zsh-theme  ~/.oh-my-zsh/themes/thomas.zsh-theme
ln -s ~/dotfiles/git/.gitignore               ~/.gitignore
ln -s ~/dotfiles/git/.gitconfig               ~/.gitconfig
ln -s ~/dotfiles/git/.gitcommitmessage        ~/.gitcommitmessage
ln -s ~/dotfiles/vim/.vimrc                   ~/.vimrc
ln -s ~/dotfiles/zsh/.extras                  ~/.extras
ln -s ~/dotfiles/.duti                        ~/.duti
ln -s ~/dotfiles/tmux/.tmux.conf              ~/.tmux.conf

# sublime text
# =============================================================================

info "sublime text - setup shortcut: subl"
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

info "sublime text - replace default sublime text icon"
rm -rf /Applications/Sublime\ Text.app/Contents/Resources/Sublime\ Text.icns
ln -s ~/dotfiles/sublime/Sublime\ Text.icns /Applications/Sublime\ Text.app/Contents/Resources/
open ~/dotfiles/sublime
killall -KILL Dock

# python
# =============================================================================
info "python - installing virtualenvwrapper"
pip install virtualenvwrapper

# java
# =============================================================================

info "java - add jdk to jenv"
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home

info "java - set the global version of Java with jenv"
jenv global oracle64-1.8.0.112

# node
# =============================================================================

info "node - installing nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash

# macOS init
# =============================================================================

info "macOS - init macOS preferences"
source ~/dotfiles/.macOS

info "macOS - init zshrc"
source ~/.zshrc

info "macOS - running duti"
source ~/.duti
