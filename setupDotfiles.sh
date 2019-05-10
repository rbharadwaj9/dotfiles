#!/bin/bash

for dotfile in .[A-za-z]*; do
    echo "Creating symlink for dotfile: $dotfile"
    ln -fs $(pwd)/$dotfile ~/$(basename $dotfile)
done
echo "DONE"
