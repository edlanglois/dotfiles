m4_include(env_config.m4)m4_dnl
#!/bin/sh

m4_ifdef(??[[<<m4_env_config_SETXKBMAP>>]]??,m4_dnl
setxkbmap -option "ctrl:nocaps"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_XMODMAP>>]]??,m4_dnl
xmodmap ~/.Xmodmap
)m4_dnl

m4_ifdef(??[[<<m4_env_config_XBINDKEYS>>]]??,m4_dnl
xbindkeys
)m4_dnl

m4_ifdef(??[[<<m4_env_config_XINPUT>>]]??,m4_dnl
# Attempt to configure touchpad
TOUCHPAD_DEVICE_NAME="SynPS/2 Synaptics TouchPad"
if xinput list --id-only "$TOUCHPAD_DEVICE_NAME" &>/dev/null; then
	xinput set-prop "$TOUCHPAD_DEVICE_NAME" "libinput Tapping Enabled" 1
	xinput set-prop "$TOUCHPAD_DEVICE_NAME" "libinput Click Method Enabled" 0 1
	xinput set-prop "$TOUCHPAD_DEVICE_NAME" "libinput Disable While Typing Enabled" 0
fi
)m4_dnl

m4_ifdef(??[[<<m4_env_config_FEH>>]]??,m4_dnl
# Set desktop background from .wallpaper
WALLPAPER_DIR="$HOME/.wallpaper"
if [ -d "$WALLPAPER_DIR" -a -n "$(ls -A "$WALLPAPER_DIR")" ]; then
	m4_env_config_FEH --bg-scale --randomize "$WALLPAPER_DIR"
fi
)m4_dnl

m4_ifdef(??[[<<m4_env_config_XSS_LOCK>>]]??,m4_dnl
xss-lock -l -- $HOME/.config/xss-lock/transfer-sleep-lock-i3lock.sh &
)m4_dnl
