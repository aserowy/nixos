#!/bin/sh

OPTIONS="\tsuspend\n⏻\tshutdown\n\treboot\n\tlock\n\tlogout"

if [ "$@" ]
then
	case $@ in
        *shutdown)
            systemctl poweroff
            ;;
        *reboot)
            systemctl reboot
            ;;
        *suspend)
            if [ -z "$WAYLAND_DISPLAY" ]
            then
                dm-tool lock
                sleep 1
            fi

            systemctl suspend
            ;;
        *lock)
            if [ -z "$WAYLAND_DISPLAY" ]
            then
                dm-tool lock
            fi
            ;;
        *logout)
            if [ -z "$WAYLAND_DISPLAY" ]
            then
                i3-msg exit
            else
                swaymsg exit
            fi
            ;;
	esac
else
	echo -e $OPTIONS
fi
