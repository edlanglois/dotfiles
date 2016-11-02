m4_include(env_config.m4)m4_dnl
#!/bin/sh

setxkbmap -option "ctrl:nocaps"

m4_ifdef(??[[<<m4_env_config_XMODMAP>>]]??,m4_dnl
xmodmap ~/.Xmodmap
)m4_dnl

if hash imwheel &>/dev/null && ! ps cax | grep imwheel &>/dev/null; then
	imwheel
fi
