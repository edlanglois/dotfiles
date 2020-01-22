m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_DISPLAY_NAME>>]]??,m4_dnl
Section "Monitor"
	Identifier		"m4_env_config_DISPLAY_NAME"
	DisplaySize		m4_env_config_DISPLAY_DIMS
EndSection)
