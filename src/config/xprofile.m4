m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
#!/bin/sh

m4_ifdef(??[[<<m4_env_config_SETXKBMAP>>]]??,m4_dnl
setxkbmap -option "ctrl:nocaps"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_XMODMAP>>]]??,m4_dnl
xmodmap m4_user_config_XDG_CONFIG_HOME/xinit/Xmodmap
)m4_dnl

m4_ifdef(??[[<<m4_env_config_XBINDKEYS>>]]??,m4_dnl
xbindkeys -f m4_user_config_XDG_CONFIG_HOME/xbindkeys/config
)m4_dnl

xrandrrc=m4_user_config_XDG_CONFIG_HOME/xinit/xrandr
if [ -f $xrandrrc ]; then
	. $xrandrrc
fi

m4_ifdef(??[[<<m4_env_config_FEH>>]]??,m4_dnl
# Set desktop background from $XDG_CONFIG_HOME/wallpaper
WALLPAPER_DIR=m4_user_config_XDG_CONFIG_HOME/wallpaper
if [ -d "$WALLPAPER_DIR" -a -n "$(ls -A "$WALLPAPER_DIR")" ]; then
	m4_env_config_FEH --no-fehbg --bg-scale --randomize "$WALLPAPER_DIR"
fi
)m4_dnl

m4_ifdef(??[[<<m4_env_config_ENABLE_LOCKER_CMD>>]]??,m4_dnl
m4_env_config_ENABLE_LOCKER_CMD &
)m4_dnl
