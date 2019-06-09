alias coursework="cd ~/Documents/Coursework/WINTER_2019/"
alias net_inf="source ~/Documents/ITS/net-infrastructure/bin/activate"

export EDITOR=$(which vim)
export CLICOLOR=1
export TERM=xterm-256color

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
    changed=`echo -n "${status}" 2> /dev/null | grep "working tree clean" &> /dev/null; echo "$?"`
	bits=''
    if [ "${changed}" == "0" ]; then
        bits="[32m"
    else
        bits="[31m"
    fi

	if [ ! "${bits}" == "" ]; then
		echo "${bits}"
	else
		echo ""
	fi
}

# export PS1="\u:\W \$(parse_git_dirty)\$(parse_git_branch) \e[m\\$ "
# export PS1="\u:\W \[\033[33m\]\$(parse_git_branch)\[\033[00m\] \$"
function refresh_prompt {
    export PS1="\u@\h:\W \[\033\$(parse_git_branch)\]\[\033[00m\] \$ "
}
export PROMPT_COMMAND=refresh_prompt
