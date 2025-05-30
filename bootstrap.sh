#!/bin/bash

dir=~/dots
olddir=~/dots_old
files=".aliases .gitignore_global .agignore .gitconfig .gitignore .zshenv .zshrc .install-plugins"

echo "Creating $olddir for backup of any existing dots in ~"
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

    echo "Moving any existing dots from ~ to $olddir"

    mv ~/$file ~/dots_old/

    echo "Creating symlink to $file in home directory."

    ln -s $dir/$file ~/$file
done

echo "linking .my-zshenv"
ln -s ~/Dropbox/dots/.my-zshenv ~/.my-zshenv
