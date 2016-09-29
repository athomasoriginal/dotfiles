# ==============================================================================
# setup
# ==============================================================================


# remove existing dotfiles
rm -rf ~/.zsh_profile
rm -rf ~/.zshrc
rm -rf ~/.gitconfig
rm -rf ~/.vimrc

# symlink to dotfiles
ln -s ~/.dotfiles/.zsh_profile     ~/.zsh_profile
ln -s ~/.dotfiles/.zshrc           ~/.zshrc
ln -s ~/.dotfiles/.gitconfig       ~/.gitconfig
ln -s ~/.dotfiles/.vimrc           ~/.vimrc

