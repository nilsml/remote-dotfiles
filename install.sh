#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="bash_aliases bash_profile bashrc zshrc shell_prompt.sh vimrc gitconfig profile tmux.conf"    # list of files/folders to symlink in homedir

##########

# instal oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -- -y

# install or update starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y

# install fonts
#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
#sudo unzip Meslo.zip -d /usr/share/fonts
#sudo fc-cache -f -v

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir"
  mv ~/.$file $olddir/
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

items=($( ls $dir/config ))
# copy config files
for item in $items; do
  echo "copying $item to .config dir."
  cp -r $dir/config/$item ~/.config/
done