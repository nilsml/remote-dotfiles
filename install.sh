#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=$(pwd)                        # dotfiles directory
files="bash_aliases bash_profile bashrc zshrc shell_prompt.sh vimrc gitconfig profile tmux.conf"    # list of files/folders to symlink in homedir

##########

# install or update starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done