#!/bin/bash

for dotfile in .[A-Za-z]*;
do
    echo $dotfile
    if [ $dotfile = ".git" ] || [ $dotfile = ".DS_Store" ];
    then
        echo "Skipping $dotfile"
    else
        if [ -d $dotfile ]
        then
            echo "$dotfile is a folder"
            mkdir ~/$(basename $dotfile)
            ln -s $(pwd)/$dotfile/* ~/$(basename $dotfile)  
        else
            echo "Creating symlink for dotfile: $dotfile"
            ln -s $(pwd)/$dotfile ~/$(basename $dotfile)
        fi
    fi

done
echo "Symlink creation successful!"
