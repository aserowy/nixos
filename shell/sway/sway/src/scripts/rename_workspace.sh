#!/bin/sh

# when we re-enter this script this env var will
# be set.
if [[ -n $SR ]]; then
    echo ""
    echo " Rename workspace to?" |  pv -qL $[20+(-2 + RANDOM%5)]
    echo ""
    echo -n "  "
    read newname
    sway rename workspace to $newname
fi

# launch alacritty instance with the size we want
# and re-enter this script.
SR=true zsh -c "alacritty \
    -o window.dimensions.columns=50 \
    -o window.dimensions.lines=3 \
    -o font.size=12.0 \
    -o window.padding.x=20 \
    -o window.padding.y=20 \
    --title "fzf-switcher" \
    --config-file "/etc/alacritty.yaml" \
    -e /etc/sway/scripts/rename_workspace.sh"&
