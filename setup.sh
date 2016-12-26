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

# zsh
# =============================================================================

info "Zsh - setting zsh as the default shell environment"
chsh -s $(which zsh)

# macOS
# =============================================================================

info "macOS - setting up macOS preferences"
source .macos

# dotfile setup
# =============================================================================

info "dotfiles - removing existing dotfiles"
rm -rf ~/.zsh_profile
rm -rf ~/.zshrc
rm -rf ~/.gitconfig
rm -rf ~/.gitignore
rm -rf ~/.gitcommitmessage
rm -rf ~/.vimrc

info "dotfiles - symlinking dotfiles"
ln -s ~/dotfiles/zsh/.zsh_profile             ~/.zsh_profile
ln -s ~/dotfiles/zsh/.zshrc                   ~/.zshrc
ln -s ~/dotfiles/zsh/themes/thomas.zsh-theme  ~/.oh-my-zsh/themes/thomas.zsh-theme
ln -s ~/dotfiles/git/.gitignore               ~/.gitignore
ln -s ~/dotfiles/git/.gitconfig               ~/.gitconfig
ln -s ~/dotfiles/git/.gitcommitmessage        ~/.gitcommitmessage
ln -s ~/dotfiles/vim/.vimrc                   ~/.vimrc

# # subl - shortcut for sublime
# ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

# # clone dotfiles repo & set origin
# git -C ~/.dotfiles remote add origin https://github.com/tkjone/dotfiles.git

# # replace the sublime text 3 icon
# rm -rf /Applications/Sublime\ Text.app/Contents/Resources/Sublime\ Text.icns
# ln -s ~/dotfiles/sublime/Sublime\ Text.icns /Applications/Sublime\ Text.app/Contents/Resources/
# open ~/dotfiles/sublime
# killall dock
