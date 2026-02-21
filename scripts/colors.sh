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
