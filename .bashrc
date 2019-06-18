# Aliases
alias coursework="cd ~/Documents/Coursework/WINTER_2019/"
alias net_inf="source ~/Documents/ITS/net-infrastructure/bin/activate"
alias work="cd ~/Documents/ITS/"
alias run='runserver(){
    if test -n "$VIRTUAL_ENV"; then
        python manage.py runserver
    else
        echo "START VIRTUAL ENVIRONMENT FIRST"
    fi
}; runserver'

# Shortcut Aliases
alias vi='vim'
alias diff='colordiff'
alias ll="ls -la"
alias ..="cd .."
alias ...="cd ../../"

alias mkdir="mkdir -p"
alias mkcd='mkcd(){
    mkdir -p "$1"
    cd "$1"
}; mkcd'
alias doco="docker-compose"
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend" # Lock Screen when AFK

# Safety
alias mv="mv -i"
alias cp="cp -i"

# Environment Variables
export EDITOR=$(which vim)
# export PROMPT_COMMAND=refresh_prompt

# Terminal Colors
export CLICOLOR=1
export TERM=xterm-256color
export LSCOLORS="Exfxcxdxbxegedabagacad"

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Coloring inspired by @mathiasbynens's prompt: https://github.com/mathiasbynens/dotfiles
if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 64);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
        echo "(${BRANCH})"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
    clean=`echo -n "${status}" 2> /dev/null | grep "working tree clean" &> /dev/null; echo "$?"`
    added=`echo -n "${status}" 2> /dev/null | grep "Changes to be committed" &> /dev/null; echo "$?"`
	bits=''

    if [ "${clean}" -eq "0" ]; then
        # Directory is clean - GREEN
        echo -e ${green}
    elif [ "${added}" -eq "0" ]; then
        # Uncommitted Additions - YELLOW 
        echo -e ${yellow}
    else
        # Changes to be added - RED
        echo -e ${red}
    fi
}

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi; 

PS1="\[${yellow}\]\u@:" # username
PS1+="\[${hostStyle}\]\h:" # host
PS1+="\[${violet}\]\W " # Current directory, change to \w for full path
PS1+="\[\$(parse_git_dirty)\]"
PS1+="\$(parse_git_branch) "
PS1+="\[${reset}\]\$ " # $ character (and white)
export PS1;
#     export PS1="\[\033\$(set_virtualenv)\[\033[33m\]\u@\h:\[\033[1;34m\]\W \[\033\$(parse_git_branch)\]\[\033[00m\] \$ "
# }
