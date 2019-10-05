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
m4_define(m4_I3BLOCKS_DIR,??[[<<~/.config/i3blocks/scripts>>]]??)
command=m4_I3BLOCKS_DIR/$BLOCK_NAME
align=left
color=#ffffff
separator=false
separator_block_width=15

[mediaplayer-label]
command=[ -n "$(m4_I3BLOCKS_DIR/mediaplayer)" ] && echo '♫' || echo ''
color=#00ffff
separator_block_width=4
interval=5

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

m4_ifdef(??[[<<m4_user_config_OPEN_WEATHER_MAP_API_KEY>>]]??,m4_dnl
[weather-label]
command=m4_I3BLOCKS_DIR/weather 'm4_user_config_OPEN_WEATHER_MAP_API_KEY' --id 'm4_user_config_OPEN_WEATHER_MAP_CITY_ID' --units 'm4_user_config_OPEN_WEATHER_MAP_UNITS' --fmt '%i'
interval=600
color=#00ffff
separator_block_width=4

[weather]
command=m4_I3BLOCKS_DIR/weather 'm4_user_config_OPEN_WEATHER_MAP_API_KEY' --id 'm4_user_config_OPEN_WEATHER_MAP_CITY_ID' --units 'm4_user_config_OPEN_WEATHER_MAP_UNITS' --fmt '%t %s (%c)' --sfmt '%t'
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
m4_ifdef(??[[<<m4_env_config_I3BLOCKS_CPU_POPUP>>]]??,m4_dnl
command=m4_I3BLOCKS_DIR/$BLOCK_NAME && ( if [ "$BLOCK_BUTTON" == "1" ]; then m4_env_config_I3BLOCKS_CPU_POPUP; fi ))
interval=10
min_width=99.99%
align=right

m4_define(GPU_USAGE, ??[[<<m4_ifelse($1,-1,,??[[<<GPU_USAGE(m4_eval($1-1))
[gpu-usage $1 80 95]
interval=10
min_width=100%
align=right
>>]]??)>>]]??)
m4_ifdef(??[[<<m4_env_config_NVIDIA_SMI>>]]??,m4_dnl
# GPU usage
[gpu-usage-label]
full_text=GPU
color=#00ffff
separator_block_width=4
GPU_USAGE(m4_eval(m4_env_config_NUM_GPUS - 1)))

# Memory usage
#
# The type defaults to "mem" if the instance is not specified.
[memory-label]
full_text=MEM
color=#00ffff
separator_block_width=4

[memory]
m4_ifdef(??[[<<m4_env_config_I3BLOCKS_MEM_POPUP>>]]??,m4_dnl
command=m4_I3BLOCKS_DIR/$BLOCK_NAME && ( if [ "$BLOCK_BUTTON" == "1" ]; then m4_env_config_I3BLOCKS_MEM_POPUP; fi ))
interval=30

# [memory-label]
# full_text=SWAP
# color=#00ffff
# separator_block_width=4
#
# [memory]
# instance=swap
# interval=30

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

# # Network interface monitoring
# #
# # If the instance is not specified, use the interface used for default route.
# # The address can be forced to IPv4 or IPv6 with -4 or -6 switches.
# [iface-label]
# full_text=🖧
# color=#00ffff
# separator_block_width=4
#
# [iface]
# #instance=wlan0
# #color=#00FF00
# interval=10
m4_ifdef(??[[<<m4_env_config_WIRELESS_INTERFACE>>]]??,m4_dnl

[wifi-label]
full_text=📶
color=#00ffff
separator_block_width=4

[wifi]
instance=m4_env_config_WIRELESS_INTERFACE
interval=10
separator_block_width=4

[essid]
INTERFACE=m4_env_config_WIRELESS_INTERFACE
interval=60
)
m4_ifdef(??[[<<m4_env_config_BATTERY_0>>]]??,m4_dnl

# Battery indicator
#
# The battery instance defaults to 0.
[battery-label]
interval=30
color=#00ffff
separator_block_width=4

[battery]
command=m4_I3BLOCKS_DIR/battery | sed 's/\(CHR\|DIS\) \?//'
BAT_NUMBER=0
interval=30)
m4_ifdef(??[[<<m4_env_config_BATTERY_1>>]]??,m4_dnl
[battery]
command=m4_I3BLOCKS_DIR/battery | sed 's/\(CHR\|DIS\) \?//'
BAT_NUMBER=1
interval=30)

# Date
[date-label]
full_text=📅
color=#00ffff
separator_block_width=4

[date-calendar m4_ifdef(??[[<<m4_env_config_GSIMPLECAL>>]]??,gsimplecal)]
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
