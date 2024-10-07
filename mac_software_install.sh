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

if ! [ -f ~/.tmux/plugins/tpm/tpm ];
then
    echo "${cyan}Installing TPM${reset}"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "${green}Installed TPM successfully. Please use prefix+I command to install plugins.${reset}"
fi

if [ $(brew list --versions nvm; echo $?) -ne "0" ]
then
    echo "${cyan}Installing NVM${reset}"
    brew install nvm
fi

if ! [ -d $HOME/.oh-my-zsh ];
then
    echo "${cyan}Installing Oh My ZSH${reset}"
    ZSH=$HOME/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "${green}Installed Oh My ZSH successfully.${reset}"
fi

brew install fzf bat ripgrep
