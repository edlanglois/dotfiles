m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_FONT_AWESOME>>]]??,??[[<<m4_dnl
m4_define(m4_ICON_CALENDAR,)
m4_define(m4_ICON_CPU,)
m4_define(m4_ICON_GPU,)
m4_define(m4_ICON_MEMORY,)
m4_define(m4_ICON_POWER_BATTERY,)
m4_define(m4_ICON_POWER_WIRE,)
m4_define(m4_ICON_SPEAKER,)
m4_define(m4_ICON_TEMPERATURE,)
m4_define(m4_ICON_TIME,)
m4_define(m4_ICON_WIFI,)
m4_define(m4_ICON_WIFI_OFF,)
>>]]??,??[[<<m4_dnl
m4_define(m4_ICON_CALENDAR,📅)
m4_define(m4_ICON_CPU,⌬)
m4_define(m4_ICON_GPU,⊞)
m4_define(m4_ICON_MEMORY,⎍)
m4_define(m4_ICON_POWER_BATTERY,🔋)
m4_define(m4_ICON_POWER_WIRE,🔌)
m4_define(m4_ICON_SPEAKER,🔊︎)
m4_define(m4_ICON_TEMPERATURE,🌡)
m4_define(m4_ICON_TIME,🕒︎)
m4_define(m4_ICON_WIFI,📶︎)
m4_define(m4_ICON_WIFI_OFF,⚠)
>>]]??)m4_dnl
# i3blocks config file
#
# Please see man i3blocks for a complete reference!
# The man page is also hosted at http://vivien.github.io/i3blocks
#
# i3 properties:
# https://i3wm.org/docs/i3bar-protocol.html#_blocks_in_detail
#
# i3blocks properties:
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
m4_define(m4_I3BLOCKS_DIR,??[[<<m4_user_config_XDG_CONFIG_HOME/i3blocks/scripts>>]]??)
command=m4_I3BLOCKS_DIR/$BLOCK_NAME | sed -e '1,2s/^/<span foreground="cyan">'"$ICON"'<\/span> /'
align=center
color=#fbfaf5
markup=pango
separator_block_width=20

[music]
ICON=♫
interval=5
signal=2

[volume]
ICON=m4_ICON_SPEAKER
STEP=3%
instance=Master
interval=once
signal=1

m4_ifdef(??[[<<m4_user_config_OPEN_WEATHER_MAP_API_KEY>>]]??,m4_dnl
[weather]
command=m4_I3BLOCKS_DIR/weather 'm4_user_config_OPEN_WEATHER_MAP_API_KEY' --name '??[[<<m4_user_config_OPEN_WEATHER_MAP_CITY>>]]??' --units 'm4_user_config_OPEN_WEATHER_MAP_UNITS' --fmt '<span foreground="cyan">%i</span> %t %s (%c)' --sfmt '%t'
interval=600)

# -w and -c specify warning / critical thresholds
[cpu_usage -w 80 -c 95]
ICON=m4_ICON_CPU
COLOR_NORMAL=#fbfaf5
m4_ifdef(??[[<<m4_env_config_I3BLOCKS_CPU_POPUP>>]]??,m4_dnl
command=m4_I3BLOCKS_DIR/$BLOCK_NAME | ??[[<<sed -e '1,2s/^/<span foreground="cyan">'"$ICON"'<\/span> /'>>]]?? && ( if [ "$BLOCK_BUTTON" == "1" ]; then m4_env_config_I3BLOCKS_CPU_POPUP; fi ))
interval=10
min_width=m4_ICON_CPU 99.99%
align=right

m4_ifelse(m4_env_config_NUM_GPUS,0,,
[gpu-usage m4_env_config_NUM_GPUS 80 95]
ICON=m4_ICON_GPU
interval=10
min_width=m4_ICON_GPU 100%
align=right
)

[memory]
ICON=m4_ICON_MEMORY
m4_ifdef(??[[<<m4_env_config_I3BLOCKS_MEM_POPUP>>]]??,m4_dnl
command=m4_I3BLOCKS_DIR/$BLOCK_NAME | ??[[<<sed -e '1,2s/^/<span foreground="cyan">'"$ICON"'<\/span> /'>>]]?? && ( if [ "$BLOCK_BUTTON" == "1" ]; then m4_env_config_I3BLOCKS_MEM_POPUP; fi ))
interval=30

[temperature]
ICON=m4_ICON_TEMPERATURE
interval=10

m4_ifdef(??[[<<m4_env_config_WIRELESS_INTERFACE>>]]??,m4_dnl
[wifi]
LABEL=m4_ICON_WIFI
LABEL_OFF=m4_ICON_WIFI_OFF
LABEL_COLOUR=cyan
RFKILL_WLAN_ID=m4_env_config_RFKILL_WLAN_ID
instance=m4_env_config_WIRELESS_INTERFACE
interval=10
)

m4_ifdef(??[[<<m4_env_config_BATTERY_0>>]]??,m4_dnl
# Battery indicator
#
# The battery instance defaults to 0.
[battery-label]
command=m4_I3BLOCKS_DIR/battery-label m4_ICON_POWER_WIRE m4_ICON_POWER_BATTERY
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
[date-calendar m4_ifdef(??[[<<m4_env_config_GSIMPLECAL>>]]??,gsimplecal)]
ICON=m4_ICON_CALENDAR
interval=60
markup=pango

[time]
ICON=m4_ICON_TIME
command=date '+%X' | sed -e '1,2s/^/<span foreground="cyan">'"$ICON"'<\/span> /'
interval=1

# Add a trailing separator
[empty]
command=echo ""
interval=once
