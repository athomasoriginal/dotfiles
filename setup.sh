# ==============================================================================
# setup
# ==============================================================================

# remove existing dotfiles
rm -rf ~/.zsh_profile
rm -rf ~/.zshrc
rm -rf ~/.gitconfig
rm -rf ~/.gitignore
rm -rf ~/.gitcommitmessage
rm -rf ~/.vimrc

# symlink dotfiles
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
