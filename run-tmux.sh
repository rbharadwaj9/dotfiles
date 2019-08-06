#!/bin/bash

# set -x

IFS=' ' read -a sessions <<< "$(tmux list-sessions -F '#S' | tr '\n' ' ')"
sessions=("Start a new session" "${sessions[@]}")

i=0
for session in "${sessions[@]}"
do
    echo $i. $session
    ((i++))
done

read -p "What do you want to do?: " input

if [[ $input -eq 0 ]]
then
    read -p "Name your session: " name
    tmux new -s $name
else
    if [[ -n ${sessions[${input}]} ]]
    then
        tmux attach -t ${sessions[${input}]}
    else
        echo "Invalid action"
    fi
fi
