m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_DISPLAY_NAME>>]]??,m4_dnl
Section "Monitor"
	Identifier		"m4_env_config_DISPLAY_NAME"
	DisplaySize		m4_env_config_DISPLAY_DIMS
EndSection)

m4_ifdef(??[[<<m4_env_config_BATTERY_0>>]]??,m4_dnl Use defaults for desktop
# Set laptop screens to turn off after 2 minutes of inactivity
Section "ServerLayout"
	Identifier "Main Layout"
	Option "StandByTime" "2"
	Option "SuspendTime" "2"
	Option "OffTime" "2"
EndSection)
