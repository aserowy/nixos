#!/bin/sh

OPTIONS="music\nsocial\n"

workspaces=($(swaymsg -t get_workspaces -r | jq -r -c '.[] | .name'))
for workspace in "${workspaces[@]}"; do
    if [[ $OPTIONS != *$workspace* ]]
    then
        OPTIONS="$OPTIONS$workspace\n"
    fi
done

if [ "$@" ]
then
    swaymsg workspace $@ >/dev/null 2>&1
else
    echo -e $OPTIONS
fi
