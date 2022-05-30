#!/usr/bin/env bash

source colors.sh

echo "${cyan}Installing software for MacOS devices${reset}"

if ! [ -f /usr/local/etc/bash_completion ];
then
    echo "${yellow}WARNING: Bash Completion is not installed.${reset}"
    echo "Do you want to install it? (y/n): "
    read install_completion
    case $install_completion in
        [Yy]* ) echo "${cyan}Installing bash completion.${reset}"; brew install bash-completion;;
        * ) echo "Skipping bash completion installation."
    esac
fi

if [ $(which brew; echo $?) -ne "0" ];
then
    echo "${cyan}Installing Homebrew package manager${reset}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [ $(which tmux; echo $?) -ne "0" ];
then
    echo "${cyan}Installing tmux${reset}"
    brew install tmux
fi

brew install fzf

if ! [ -f ~/.tmux/plugins/tpm/tpm ];
then
    echo "${cyan}Installing TPM${reset}"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "${green}Installed TPM successfully. Please use prefix+I command to install plugins.${reset}"
fi
