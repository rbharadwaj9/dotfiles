if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
source ~/.git-completion.bash

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

. "$HOME/.cargo/env"
