#!/bin/bash

dir=~/dotfiles
olddir=~/dotfiles_old
files=".bash_profile .gitignore_global .agignore .gitconfig .gitignore .zshenv .zshrc"

echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

echo "Changing to the $dir directory"
cd $dir
echo "...done"

for file in $files; do
    if [ ! -e "$file" ]
    then
	echo "$file does not exist."; echo
	continue
    fi
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

source ~/.bash_profile
