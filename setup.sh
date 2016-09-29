# ==============================================================================
# setup
# ==============================================================================

# remove existing dotfiles
rm -rf ~/.zsh_profile
rm -rf ~/.zshrc
rm -rf ~/.gitconfig
rm -rf ~/.vimrc

# symlink dotfiles
ln -s ~/.dotfiles/.zsh_profile     ~/.zsh_profile
ln -s ~/.dotfiles/.zshrc           ~/.zshrc
ln -s ~/.dotfiles/.gitconfig       ~/.gitconfig
ln -s ~/.dotfiles/.vimrc           ~/.vimrc

# subl - shortcut for sublime
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

# clone dotfiles repo & set origin
git -C ~/.dotfiles remote add origin https://github.com/tkjone/dotfiles.git

# replace the sublime text 3 icon
rm -rf /Applications/Sublime\ Text.app/Contents/Resources/Sublime\ Text.icns
ln -s ~/dotfiles/sublime/Sublime\ Text.icns /Applications/Sublime\ Text.app/Contents/Resources/
open ~/dotfiles/sublime
killall dock
