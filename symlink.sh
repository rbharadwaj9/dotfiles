#!/usr/bin/env bash
# Script to set up symlinks for dotfiles
# TODO: Move to XDG config directory and possibly get rid of this complex mess
echo -e "${cyan}Symlinking setup files.${reset}"
for dotfile in .[A-Za-z]*;
do
    if [[ "$dotfile" == *".swp"* ]]
    then
        continue
    fi

    echo $dotfile
    if [ $dotfile = ".git" ] || [ $dotfile = ".DS_Store" ];
    then
        echo "Skipping $dotfile"
    else
        if [ -d $dotfile ]
        then
            echo "${yellow}${dotfile} is a folder${reset}"
            mkdir ~/$(basename $dotfile)
            ln -s $(pwd)/$dotfile/* ~/$(basename $dotfile)
        else
            echo "Creating symlink for dotfile: $dotfile"
            ln -s $(pwd)/$dotfile ~/$(basename $dotfile)
        fi
    fi
done
echo "${green}Symlink creation successful!${reset}"

ln -s $(pwd)/startmux ~/startmux || echo "Error while symlinking tmux startup script"

rm ~/.zshrc
ln -s $(pwd)/.zshrc ~/.zshrc || echo "Error while symlinking .zshrc"

