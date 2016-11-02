m4_include(env_config.m4)m4_dnl
#!/bin/sh

m4_ifdef(??[[<<m4_env_config_SETXKBMAP>>]]??,m4_dnl
setxkbmap -option "ctrl:nocaps"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_XMODMAP>>]]??,m4_dnl
xmodmap ~/.Xmodmap
)m4_dnl

if hash imwheel &>/dev/null && ! ps cax | grep imwheel &>/dev/null; then
	imwheel
fi
