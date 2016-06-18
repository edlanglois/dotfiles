m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
# i3blocks config file
#
# Please see man i3blocks for a complete reference!
# The man page is also hosted at http://vivien.github.io/i3blocks
#
# List of valid properties:
#
# align
# color
# command
# full_text
# instance
# interval
# label
# min_width
# name
# separator
# separator_block_width
# short_text
# signal
# urgent

# Global properties
#
# The top properties below are applied to every block, but can be overridden.
# Each block command defaults to the script name to avoid boilerplate.
m4_ifdef(??[[<<m4_env_config_I3BLOCKS_DIR>>]]??,m4_dnl
command=m4_env_config_I3BLOCKS_DIR/$BLOCK_NAME
)
align=left
color=#ffffff
separator=false
separator_block_width=15

[mediaplayer-label]
full_text=♫
color=#00ffff
separator_block_width=4

# Generic media player support
#
# This displays "ARTIST - SONG" if a music is playing.
# Supported players are: spotify, vlc, audacious, xmms2, mplayer, and others.
[mediaplayer]
#instance=spotify
interval=5
signal=10

# Volume indicator
#
# The first parameter sets the step (and units to display)
# The second parameter overrides the mixer selection
# See the script for details.
[volume-label]
full_text=🔊
color=#00ffff
separator_block_width=4

[volume]
instance=Master
interval=once
signal=1

m4_ifdef(??[[<<m4_user_config_CANADA_WEATHER_REGION_NUMBER>>]]??,m4_dnl
[weather-ca-label]
command=$HOME/.config/i3blocks/scripts/weather-ca m4_user_config_CANADA_WEATHER_PROVINCE m4_user_config_CANADA_WEATHER_REGION_NUMBER '%i'
interval=600
color=#00ffff
separator_block_width=4

[weather-ca]
command=$HOME/.config/i3blocks/scripts/$BLOCK_NAME m4_user_config_CANADA_WEATHER_PROVINCE m4_user_config_CANADA_WEATHER_REGION_NUMBER '%t (%c)' '%t'
interval=600)

# CPU usage
#
# The script may be called with -w and -c switches to specify thresholds,
# see the script for details.
[cpu_usage-label]
full_text=CPU
color=#00ffff
separator_block_width=4

[cpu_usage -w 80 -c 95]
interval=10

# Memory usage
#
# The type defaults to "mem" if the instance is not specified.
[memory lable]
full_text=MEM
color=#00ffff
separator_block_width=4

[memory]
interval=30

[memory lable]
full_text=SWAP
color=#00ffff
separator_block_width=4

[memory]
instance=swap
interval=30

# # Disk usage
# [disk]
# label=ROOT
# instance=/
# interval=30

# # The directory defaults to $HOME if the instance is not specified.
# # The script may be called with a optional argument to set the alert
# # (defaults to 10 for 10%).
# [disk]
# label=HOME
# interval=30

# Temperature
#
# Support multiple chips, though lm-sensors.
# The script may be called with -w and -c switches to specify thresholds,
# see the script for details.
[temperature-label]
full_text=🌡
color=#00ffff
separator_block_width=4

[temperature -w 50 -c 65]
interval=10

# Network interface monitoring
#
# If the instance is not specified, use the interface used for default route.
# The address can be forced to IPv4 or IPv6 with -4 or -6 switches.
[iface-label]
full_text=🖧
color=#00ffff
separator_block_width=4

[iface]
#instance=wlan0
#color=#00FF00
interval=10

#[wifi]
##instance=wlp3s0
#interval=10

# # Battery indicator
# #
# # The battery instance defaults to 0.
# [battery]
# #label=BAT
# label=⚡
# #instance=1
# interval=30

# Date
[time-label]
full_text=📅
color=#00ffff
separator_block_width=4

[time]
command=date '+%Y-%m-%d %a'
interval=60

[time-label]
full_text=🕒
color=#00ffff
separator_block_width=4

[time]
command=date '+%X'
interval=5

# OpenVPN support
#
# Support multiple VPN, with colors.
#[openvpn]
#interval=20
