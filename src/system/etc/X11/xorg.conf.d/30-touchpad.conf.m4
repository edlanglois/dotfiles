m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_TOUCHPAD>>]]??,m4_dnl
Section "InputClass"
	Identifier "touchpad"
	Driver "libinput"
	MatchIsTouchpad "on"
	Option "Tapping" "on"
	Option "TappingButtonMap" "lrm"
	Option "TappingDrag" "on"
	Option "NaturalScrolling" "off"
EndSection)
