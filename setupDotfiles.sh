#!/bin/bash

for dotfile in .[A-Za-z]*;
do
    if [ $dotfile = ".git" ];
    then
        echo "Skipping $dotfile"
    else
        echo "Creating symlink for dotfile: $dotfile"
        ln -s $(pwd)/$dotfile ~/$(basename $dotfile)
    fi
done
echo "Symlink creation successful!"
