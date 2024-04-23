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
if [[ $(which brew) == 'brew not found' ]]; then
    # http://brew.sh/
    info "Brew - Install"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # add homebrew to path
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/dotfiles/zsh/.zprofile 
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed...";
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
# @todo add condition around this!
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# dotfile setup
# =============================================================================

info "dotfiles - removing existing dotfiles"
rm -rf ~/.zprofile
rm -rf ~/.zshrc
rm -rf ~/.gitconfig
rm -rf ~/.gitignore
rm -rf ~/.gitcommitmessage
rm -rf ~/.gitconfig.local
rm -rf ~/.vimrc
rm -rf ~/.extras
rm -rf ~/.oh-my-zsh/themes/thomas.zsh-theme
rm -rf ~/.duti
rm -rf ~/.gitconfig.local
rm -rf ~/.clojure/deps.edn
rm -rf ~/.config/nvim
rm -rf ~/.config/kitty

info "dotfiles - symlinking dotfiles"
ln -sf ~/dotfiles/zsh/.zsh_profile             ~/.zprofile
ln -sf ~/dotfiles/zsh/.zshrc                   ~/.zshrc
ln -sf ~/dotfiles/zsh/themes/thomas.zsh-theme  ~/.oh-my-zsh/themes/thomas.zsh-theme
ln -sf ~/dotfiles/git/.gitignore               ~/.gitignore
ln -sf ~/dotfiles/git/.gitconfig               ~/.gitconfig
ln -sf ~/dotfiles/git/.gitconfig.local         ~/.gitconfig.local
ln -sf ~/dotfiles/git/.gitcommitmessage        ~/.gitcommitmessage
ln -sf ~/dotfiles/git/.gitconfig.local         ~/.gitconfig.local
ln -sf ~/dotfiles/zsh/.extras                  ~/.extras
ln -sf ~/dotfiles/.duti                        ~/.duti
ln -sf ~/dotfiles/.clojure/deps.edn            ~/.clojure/deps.edn
ln -sf ~/dotfiles/nvim/                        ~/.config/nvim
ln -sf ~/dotfiles/kitty                        ~/.config/kitty


# macOS init
# =============================================================================

info "macOS - init macOS preferences"
source .macOS

info "macOS - init zshrc"
source ~/.zshrc

info "macOS - running duti"
source ~/.duti
