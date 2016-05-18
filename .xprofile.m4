#!/bin/sh

setxkbmap -option "ctrl:nocaps"

if hash imwheel &>/dev/null && ! ps cax | grep imwheel &>/dev/null; then
	imwheel
fi
