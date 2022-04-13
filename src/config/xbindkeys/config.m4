m4_include(env_config.m4)m4_dnl
# For the benefit of emacs users: -*- shell-script -*-
###########################
# xbindkeys configuration #
###########################
#
# Version: 1.8.6
#
# If you edit this file, do not forget to uncomment any lines
# that you change.
# The pound(#) symbol may be used anywhere for comments.
#
# To specify a key, you can use 'xbindkeys --key' or
# 'xbindkeys --multikey' and put one of the two lines in this file.
#
# The format of a command line is:
#    "command to start"
#       associated key
#
#
# A list of keys is in /usr/include/X11/keysym.h and in
# /usr/include/X11/keysymdef.h
# The XK_ is not needed.
#
# List of modifier:
#   Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock),
#   Mod3 (CapsLock), Mod4, Mod5 (Scroll).
#

# The release modifier is not a standard X modifier, but you can
# use it if you want to catch release events instead of press events

# By defaults, xbindkeys does not pay attention with the modifiers
# NumLock, CapsLock and ScrollLock.
# Uncomment the lines above if you want to pay attention to them.

#keystate_numlock = enable
#keystate_capslock = enable
#keystate_scrolllock= enable

m4_ifdef({<<m4_env_config_XDOTOOL>>},m4_dnl
# Map side mouse buttons to media control keys.
"xdotool key XF86AudioNext"
	b:9

"xdotool key XF86AudioPrev"
	b:8

"xdotool key --clearmodifiers XF86AudioPlay"
	control + b:9

"xdotool key --clearmodifiers XF86AudioPause"
	control + b:8

"xdotool key --clearmodifiers XF86AudioRaiseVolume"
	shift + b:9

"xdotool key --clearmodifiers XF86AudioLowerVolume"
	shift + b:8

# Map Alt+Volume to media control
"xdotool keyup XF86AudioMute key --clearmodifiers XF86AudioPlay"
	alt + XF86AudioMute

"xdotool keyup XF86AudioLowerVolume key --clearmodifiers XF86AudioPrev"
	alt + XF86AudioLowerVolume

"xdotool keyup XF86AudioRaiseVolume key --clearmodifiers XF86AudioNext"
	alt + XF86AudioRaiseVolume

)m4_dnl

# Examples of commands:

# "xbindkeys_show"
#   control+shift + q

# # set directly keycode (here control + f with my keyboard)
# "xterm"
#   c:41 + m:0x4

# # specify a mouse button
# "xterm"
#   control + b:2

#"xterm -geom 50x20+20+20"
#   Shift+Mod2+alt + s
#
## set directly keycode (here control+alt+mod2 + f with my keyboard)
#"xterm"
#  alt + c:0x29 + m:4 + mod2
#
## Control+Shift+a  release event starts rxvt
#"rxvt"
#  release+control+shift + a
#
## Control + mouse button 2 release event starts rxvt
#"rxvt"
#  Control + b:2 + Release

##################################
# End of xbindkeys configuration #
##################################
