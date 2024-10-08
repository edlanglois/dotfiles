m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
m4_ifdef({<<m4_env_config_FONT_AWESOME>>},{<<m4_dnl
m4_define(m4_ICON_CALENDAR,)
m4_define(m4_ICON_CPU,)
m4_define(m4_ICON_GPU,)
m4_define(m4_ICON_MEMORY,)
m4_define(m4_ICON_SPEAKER,)
m4_define(m4_ICON_SPEAKER_LOW,)
m4_define(m4_ICON_SPEAKER_MED,)
m4_define(m4_ICON_SPEAKER_HIGH,)
m4_define(m4_ICON_TEMPERATURE,)
m4_define(m4_ICON_TIME,)
m4_define(m4_ICON_WIFI,)
m4_define(m4_ICON_WIFI_OFF,)
m4_define(m4_ICON_VPN,)
>>},{<<m4_dnl
m4_define(m4_ICON_CALENDAR,📅)
m4_define(m4_ICON_CPU,⌬)
m4_define(m4_ICON_GPU,⊞)
m4_define(m4_ICON_MEMORY,⎍)
m4_define(m4_ICON_SPEAKER_LOW,🔈︎)
m4_define(m4_ICON_SPEAKER_MED,🔉︎)
m4_define(m4_ICON_SPEAKER_HIGH,🔊︎)
m4_define(m4_ICON_TEMPERATURE,🌡)
m4_define(m4_ICON_TIME,🕒︎)
m4_define(m4_ICON_WIFI,📶︎)
m4_define(m4_ICON_WIFI_OFF,⚠)
m4_define(m4_ICON_VPN,↔)
>>})m4_dnl
m4_ifelse(m4_env_config_FONT_AWESOME,6,{<<m4_dnl
m4_define({<<m4_ICON_CPU>>},)
>>})m4_dnl
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
m4_define(m4_I3BLOCKS_DIR,{<<m4_user_config_XDG_CONFIG_HOME/i3blocks/scripts>>})
command=m4_I3BLOCKS_DIR/$BLOCK_NAME | if [ -n "$ICON" ]; then sed -e '1,2s/^/<span color="cyan">'"$ICON"'<\/span> /'; else cat; fi
align=center
color=#fbfaf5
markup=pango
# TODO: Maybe set based on DPI?
separator_block_width=25

[music]
ICON=♫
interval=5
signal=2

m4_ifdef({<<m4_env_config_PULSEAUDIO>>},m4_dnl
[volume-pulseaudio]
LONG_FORMAT=<span color="cyan">${SYMB}</span> ${VOL}%
SHORT_FORMAT=<span color="cyan">${SYMB}</span> ${VOL}%
AUDIO_LOW_SYMBOL=m4_ICON_SPEAKER_LOW
AUDIO_MED_SYMBOL=m4_ICON_SPEAKER_MED
AUDIO_HIGH_SYMBOL=m4_ICON_SPEAKER_HIGH
,m4_dnl
[volume]
ICON=m4_ICON_SPEAKER_HIGH
)m4_dnl
STEP=3%
instance=Master
interval=once
signal=1

m4_ifdef({<<m4_user_config_OPEN_WEATHER_MAP_API_KEY>>},m4_dnl
[weather]
command=m4_I3BLOCKS_DIR/weather 'm4_user_config_OPEN_WEATHER_MAP_API_KEY' --name '{<<m4_user_config_OPEN_WEATHER_MAP_CITY>>}' --units 'm4_user_config_OPEN_WEATHER_MAP_UNITS' --fmt '<span color="cyan">%i</span> %t %s (%c)' --sfmt '<span color="cyan">%i</span> %t'
interval=600)

[cpu_usage2]
command=m4_I3BLOCKS_DIR/$BLOCK_NAME
LABEL=<span color="cyan">m4_ICON_CPU</span>
WARN_PERCENT=90
REFRESH_TIME=10
DECIMALS=0
interval=persist

m4_ifelse(m4_env_config_NUM_GPUS,0,,
[gpu-usage m4_env_config_NUM_GPUS 80 95]
ICON=m4_ICON_GPU
interval=10
min_width=m4_ICON_GPU 100%
)

[memory]
ICON=m4_ICON_MEMORY
m4_ifdef({<<m4_env_config_I3BLOCKS_MEM_POPUP>>},m4_dnl
command=m4_I3BLOCKS_DIR/$BLOCK_NAME | {<<sed -e '1,2s/^/<span color="cyan">'"$ICON"'<\/span> /'>>} && ( if [ "$BLOCK_BUTTON" = "1" ]; then m4_env_config_I3BLOCKS_MEM_POPUP >/dev/null; fi ))
interval=30

[temperature]
ICON=m4_ICON_TEMPERATURE
# Likely have to generalize this to an env config at some point
SENSOR_CHIP=*-isa-*
interval=5

m4_ifdef({<<m4_env_config_WIRELESS_INTERFACE>>},m4_dnl
[wifi]
LABEL=m4_ICON_WIFI
LABEL_OFF=m4_ICON_WIFI_OFF
LABEL_COLOUR=cyan
RFKILL_WLAN_ID=m4_env_config_RFKILL_WLAN_ID
instance=m4_env_config_WIRELESS_INTERFACE
interval=10
)m4_dnl

m4_ifdef({<<m4_env_config_NM_VPN>>},m4_dnl
[nm-vpn]
ICON=m4_ICON_VPN
init_color=#FFFFFF
on_color=#FFFFFF
interval=10
)m4_dnl

m4_ifdef({<<m4_env_config_BATTERY_0>>},m4_dnl
# Battery indicator
#
# The battery instance defaults to 0.
[battery]
interval=30
ICON_COLOUR=cyan)

# Date
[date-calendar m4_ifdef({<<m4_env_config_GSIMPLECAL>>},gsimplecal)]
ICON=m4_ICON_CALENDAR
interval=60
markup=pango

[time]
ICON=m4_ICON_TIME
command=date '+%X' | sed -e '1,2s/^/<span color="cyan">'"$ICON"'<\/span> /'
interval=1

# Add a trailing separator
[empty]
command=echo ""
interval=once
