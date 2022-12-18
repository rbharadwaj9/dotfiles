# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git 
  macos
  tmux 
  vi-mode
  zsh-syntax-highlighting 
  zsh-autosuggestions
  colored-man-pages
  docker
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Aliases
alias gs="git status"
alias gco="git checkout"
alias gl="git log --oneline"

# Shortcut Aliases
alias vi='vim'
alias diff='colordiff'
alias ll="ls -lahG"

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rbharadwaj/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rbharadwaj/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rbharadwaj/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rbharadwaj/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#
# Startup scripts
# if [[ -z $TMUX ]] && [[ -z "${SSH_TTY}" ]]; then
#     ~/startmux
# fi

if [[ -n $TMUX ]] && [[ "$(pwd)" == "${HOME}" ]]; then
  sesh=$(tmux display-message -p '#S');
  if [[ "${sesh}" == "482" ]]; then
    coursework;
    cd eecs_482;
  elif [[ "${sesh}" == "461" ]]; then
    coursework;
    cd eecs_461;
  elif [[ "${sesh}" == "work" ]]; then
    work;
  fi
fi

# Direnv
eval "$(direnv hook zsh)"

# ROS Noetic
if [ -f /opt/ros/noetic/setup.zsh ]
then
  source /opt/ros/noetic/setup.zsh
  alias catkin_debug="catkin_make -DCMAKE_BUILD_TYPE=Debug"
fi

alias rs='source ${ROS_DEVEL_SOURCE}' # Variable must be set in .envrc through direnv

# Neovim
if [ -d "${HOME}/neovim/bin" ]
then
  export PATH="${HOME}/neovim/bin:${PATH}"
fi

if [ -d "/usr/local/lib/node_modules" ]
then
  export PATH="/usr/local/lib/node_modules/:${PATH}"
fi

alias vim="nvim"
