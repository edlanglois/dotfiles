#!/bin/sh

setxkbmap -option "ctrl:nocaps"

if hash xmodmap 2>/dev/null && [ -f ~/.Xmodmap ]; then
	xmodmap ~/.Xmodmap
fi

if hash imwheel &>/dev/null && ! ps cax | grep imwheel &>/dev/null; then
	imwheel
fi
