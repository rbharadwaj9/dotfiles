# Aliases
alias coursework="cd ~/Documents/Coursework/WINTER_2019/"
alias net_inf="source ~/Documents/ITS/net-infrastructure/bin/activate"

# Environment Variables
export EDITOR=$(which vim)
export PROMPT_COMMAND=refresh_prompt

# Terminal Colors
export CLICOLOR=1
export TERM=xterm-256color
export LSCOLORS="Gxfxcxdxbxegedabagacad"

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
        echo "$(parse_git_dirty)(${BRANCH})"
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
        bits="[0;32m"
    elif [ "${added}" -eq "0" ]; then
        # Uncommitted Additions - YELLOW 
        bits="[0;33m"
    else
        # Changes to be added - RED
        bits="[0;31m"
    fi

	if [ ! "${bits}" == "" ]; then
		echo "${bits}"
	else
		echo ""
	fi
}

# Generate PS1 string to be exported by PROMPT_COMMAND
function refresh_prompt {
    export PS1="\u@\h:\W \[\033\$(parse_git_branch)\]\[\033[00m\] \$ "
}
