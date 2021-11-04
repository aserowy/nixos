#!/bin/sh

WORKSPACE=""

output=$(i3-msg -t get_outputs | jq -r -c 'map(select(.active == true)) | .[] | .name')
current=$(i3-msg -t get_outputs | jq -r -c 'map(select(.active == true)) | .[] | .current_workspace')

current_index=0
workspaces=($(i3-msg -t get_workspaces | jq -r -c 'map(select(.output ==  "'${output}'")) | sort_by(.name) | .[] | .name'))
for workspace in "${workspaces[@]}"; do
    if [ "$workspace" == "$current" ]; then
        break 
    fi
    current_index=$(($current_index+1))
done

workspaces_length=${#workspaces[@]}
if [ $current_index -gt $workspaces_length ]; then
    return 1
fi

navigate() {
    next=$(($2+$3))

    if [ $next -lt 0 ]; then
        return $(($1-1))
    elif [ $next -ge $1 ]; then
        return 0
    else
        return $next
    fi
}

case "$@" in
    prev)
        navigate $workspaces_length $current_index -1
        WORKSPACE=${workspaces[$?]}
    ;;
    next)
        navigate $workspaces_length $current_index 1
        WORKSPACE=${workspaces[$?]}
    ;;
esac

echo $WORKSPACE

if [ "$WORKSPACE" != "" ]; then
    i3-msg workspace $WORKSPACE >/dev/null 2>&1
fi
