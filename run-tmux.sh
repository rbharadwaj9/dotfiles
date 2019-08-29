#!/bin/bash

# set -x

while True
do
    IFS=' ' read -a sessions <<< "$(tmux list-sessions -F '#S' | tr '\n' ' ')"
    sessions=("Start a new session" "${sessions[@]}")

    i=0
    for session in "${sessions[@]}"
    do
        echo $i. $session
        ((i++))
    done

    read -p "What do you want to do?: " input args

    if [[ "$input" == "e" ]]
    then
        exit 0
    elif [[ "$input" -eq "0" ]]
    then
        read -p "Name your session: " name
        tmux new -s $name
    else
        if [[ -n ${sessions[${input}]} ]]
        then
            case ${args} in
                r)
                    echo "Killing session ${sessions[${input}]}."
                    tmux kill-session -t ${sessions[${input}]}
                    ;;
                *)
                    tmux attach -t ${sessions[${input}]}
                    ;;
            esac
        else
            echo "Invalid action"
        fi
    fi
done
