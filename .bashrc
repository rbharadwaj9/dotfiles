# Skip config if not run interactively - fixes issues with rsync
case $- in
    *i*) ;;
    *) return;;
esac

# Aliases
alias ros="source ~/catkin_ws/devel/setup.bash"
alias coursework="cd ~/Documents/Coursework/WINTER_2020/"
alias projects="source /Users/rbharadwaj/Documents/Python/projects/bin/activate"
alias work="cd ~/Documents/ITS/"
alias comp="compile_local"
alias run='runserver(){
    if test -n "$VIRTUAL_ENV"; then
        python manage.py runserver
    else
        echo "START VIRTUAL ENVIRONMENT FIRST"
    fi
}; runserver'
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend" # Lock Screen when AFK

# Git Aliases
alias gs="git status"
alias gco="git checkout"
alias gl="git log --oneline"

# Shortcut Aliases
alias vi='vim'
alias diff='colordiff'
alias ll="ls -lahG"
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

alias mkdir="mkdir -p"
alias mkcd='mkcd(){
    mkdir -p "$1"
    cd "$1"
}; mkcd'
alias doco="docker-compose"
alias grep="grep --color"

# Safety
alias mv="mv -i"
alias cp="cp -i"

# Environment Variables
export EDITOR=$(which vim)

# Terminal Colors
export CLICOLOR=1
export TERM=xterm-256color
export LSCOLORS="Exfxcxdxbxegedabagacad"

# Local Compile
compile_local()
{
    echo "g++ -g3 -DDEBUG -std=c++1z -Wall -Werror -Wextra -pedantic "$1" -o $(basename $1 ".cpp").exe"
    g++ -g3 -DDEBUG -std=c++1z -Wall -Werror -Wextra -pedantic "$1" -o $(basename $1 ".cpp").exe
}

[ -f /usr/local/etc/profile.d/bash_completion.sh ] && . /usr/local/etc/profile.d/bash_completion.sh || echo "WARNING: Bash Completion is not enabled."

# Coloring inspired by @mathiasbynens's prompt: https://github.com/mathiasbynens/dotfiles
if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	black=$(tput setaf 0);
	blue=$(tput setaf 27);
	cyan=$(tput setaf 39);
	green=$(tput setaf 34);
	orange=$(tput setaf 136);
	purple=$(tput setaf 55);
	red=$(tput setaf 124);
	violet=$(tput setaf 63);
	white=$(tput setaf 15);
	yellow=$(tput setaf 190);
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
        echo "(${BRANCH}) "
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
	hostStyle="${orange}";
fi; 

# PS1 Variable
PS1="\[${orange}\]\u@" # username
PS1+="\[${hostStyle}\]\h:" # host
PS1+="\[${violet}\]\W " # Current directory, change to \w for full path
PS1+="\[\$(parse_git_dirty)\]"
PS1+="\$(parse_git_branch)"
PS1+="\[${reset}\]\$ " # $ character (and white)
export PS1;

# Startup scripts
if [[ -z $TMUX ]] && [[ -z "${SSH_TTY}" ]]; then
    ~/startmux
fi

if [[ -n $TMUX ]] && [[ "$(pwd)" == "${HOME}" ]]; then
    sesh=$(tmux display-message -p '#S');
    if [[ "${sesh}" == "281" ]]; then
        coursework;
        cd EECS_281;
    elif [[ "${sesh}" == "370" ]]; then
        coursework;
        cd EECS_370;
    elif [[ "${sesh}" == "work" ]]; then
        work;
    elif [[ "${sesh}" == "ros" ]]; then
        ros;
    fi
fi
 
source /opt/ros/noetic/setup.bash
