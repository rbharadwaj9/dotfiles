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

cp karabiner.json ~/.config/karabiner/karabiner.json && echo "Karabiner config copied" || echo "Error while copying Karabiner"
cp windows-binding.json ~/.config/karabiner/assets/complex_modifications/windows-binding.json && echo "Karabiner Complex Modification copied" || echo "Error while copying complex modification"

ln -s $(pwd)/run-tmux.sh ~/run-tmux.sh || echo "Error while symlinking tmux startup script"

echo "Symlink creation successful!"
