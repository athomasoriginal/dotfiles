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

# Mac Deps + Apps
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

info "Brew - installing brew bundle + all things in our brewfile"
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
rm -rf ~/.gitconfig.local
rm -rf ~/.vimrc
rm -rf ~/.extras
rm -rf ~/.oh-my-zsh/themes/thomas.zsh-theme
rm -rf ~/.duti
rm -rf ~/.tmux.conf
rm -rf ~/.gitconfig.local
rm -rf ~/.emacs.d
rm -rf ~/.clojure/deps.edn

info "dotfiles - symlinking dotfiles"
ln -sf ~/dotfiles/zsh/.zsh_profile             ~/.zsh_profile
ln -sf ~/dotfiles/zsh/.zshrc                   ~/.zshrc
ln -sf ~/dotfiles/atom/                        ~/.atom
ln -sf ~/dotfiles/zsh/themes/thomas.zsh-theme  ~/.oh-my-zsh/themes/thomas.zsh-theme
ln -sf ~/dotfiles/git/.gitignore               ~/.gitignore
ln -sf ~/dotfiles/git/.gitconfig               ~/.gitconfig
ln -sf ~/dotfiles/git/.gitconfig.local         ~/.gitconfig.local
ln -sf ~/dotfiles/git/.gitcommitmessage        ~/.gitcommitmessage
ln -sf ~/dotfiles/git/.gitconfig.local         ~/.gitconfig.local
ln -sf ~/dotfiles/vim/.vimrc                   ~/.vimrc
ln -sf ~/dotfiles/zsh/.extras                  ~/.extras
ln -sf ~/dotfiles/.duti                        ~/.duti
ln -sf ~/dotfiles/tmux/.tmux.conf              ~/.tmux.conf
ln -sf ~/dotfiles/.emacs.d                     ~/.emacs.d
ln -sf ~/dotfiles/.clojure/deps.edn            ~/.clojure/deps.edn

# sublime text
# =============================================================================

info "sublime text - setup shortcut: subl"
ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

info "sublime text - replace default sublime text icon"
rm -rf /Applications/Sublime\ Text.app/Contents/Resources/Sublime\ Text.icns
ln -sf ~/dotfiles/sublime/Sublime\ Text.icns /Applications/Sublime\ Text.app/Contents/Resources/
open ~/dotfiles/sublime
killall -KILL Dock

# python
# =============================================================================
info "python - installing virtualenvwrapper"
pip3 install virtualenvwrapper

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
