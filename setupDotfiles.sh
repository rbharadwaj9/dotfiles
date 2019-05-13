#!/bin/bash

for dotfile in .[A-Za-z]*;
do
    echo "Creating symlink for dotfile: $dotfile"
    ln -s $(pwd)/$dotfile ~/$(basename $dotfile)
done
echo "Symlink creation successful!"
