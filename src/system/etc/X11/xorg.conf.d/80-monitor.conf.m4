m4_include(env_config.m4)m4_dnl
m4_ifdef({<<m4_env_config_DISPLAY_NAME>>},m4_dnl
Section "Monitor"
	Identifier		"m4_env_config_DISPLAY_NAME"
	DisplaySize		m4_env_config_DISPLAY_DIMS
EndSection)

m4_ifdef({<<m4_env_config_BATTERY_0>>},m4_dnl Use defaults for desktop
# Set laptop screens to turn off after a few minutes of inactivity
Section "ServerLayout"
	Identifier "Main Layout"
	Option "StandByTime" "5"
	Option "SuspendTime" "5"
	Option "OffTime" "5"
EndSection)
