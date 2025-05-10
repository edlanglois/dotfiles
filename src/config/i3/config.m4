m4_include(env_config.m4)m4_dnl
m4_include(user_config.m4)m4_dnl
# Based on
# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod1

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:sans serif m4_user_config_TERMINAL_FONT_SIZE

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

m4_ifdef({<<m4_env_config_I3_MAX_FLOAT_WIDTH>>},m4_dnl
# Set a maximum size for floating windows.
# In particular prevent windows from being larger than the display.
# This happens frequently with browser save dialogs;
# possibly related to XFT_DPI / GDK_SCALE.
floating_maximum_size m4_env_config_I3_MAX_FLOAT_WIDTH x m4_env_config_I3_MAX_FLOAT_HEIGHT
)m4_dnl

# NOTE on --no-starup-id
# Include it to avoid the waiting cursor appearing on the desktop
# The default behaviour is use startup-notifications to have applications launch
# from the workspace in which the command was invoked.
# But for the many applications that don't support startup-notifications,
# i3 instead displays a waiting for some time.
#
# Reference:
# https://i3wm.org/docs/userguide.html#exec

# start a terminal
bindsym $mod+Return exec --no-startup-id m4_ifdef(m4_dnl
{<<m4_env_config_TERMINAL>>}, m4_env_config_TERMINAL, i3-sensible-terminal)

# Open a browser window
bindsym $mod+b exec --no-startup-id xdg-open http://

# kill focused window
bindsym $mod+Shift+q kill

m4_ifdef({<<m4_env_config_DMENU>>},m4_dnl
# start dmenu (a program launcher)
bindsym $mod+d exec --no-startup-id m4_env_config_DMENU)

# mod+Escape to toggle pass-through mode.
mode "passthrough" {
    bindsym $mod+Escape mode "default"
}
bindsym $mod+Escape mode "passthrough"

# Switch to window when activated
focus_on_window_activation focus

m4_ifdef({<<m4_env_config_I3_CONFIG_EDGE_BORDERS>>},m4_dnl
# Hide window borders when the only window
hide_edge_borders m4_env_config_I3_CONFIG_EDGE_BORDERS)

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# Always wrap when moving
force_focus_wrapping yes

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
# ; instead of h because shifted movement keys over 1 to use h
bindsym $mod+semicolon split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
bindsym $mod+z focus child

# switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# move workspace
bindsym $mod+Shift+bracketleft move workspace to output left
bindsym $mod+Shift+bracketright move workspace to output right
bindsym $mod+Shift+plus move workspace to output up
bindsym $mod+Shift+apostrophe move workspace to output down

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
	# These bindings trigger as soon as you enter the resize mode

	# Pressing left will shrink the window’s width.
	# Pressing right will grow the window’s width.
	# Pressing up will shrink the window’s height.
	# Pressing down will grow the window’s height.
	bindsym h resize shrink width 10 px or 10 ppt
	bindsym j resize grow height 10 px or 10 ppt
	bindsym k resize shrink height 10 px or 10 ppt
	bindsym l resize grow width 10 px or 10 ppt

	# same bindings, but for the arrow keys
	bindsym Left resize shrink width 10 px or 10 ppt
	bindsym Down resize grow height 10 px or 10 ppt
	bindsym Up resize shrink height 10 px or 10 ppt
	bindsym Right resize grow width 10 px or 10 ppt

	# back to normal: Enter or Escape
	bindsym Return mode "default"
	bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

m4_ifdef({<<m4_env_config_MANUAL_LOCK_CMD>>},m4_dnl
# Lock screen
bindsym $mod+Mod4+l exec --no-startup-id "m4_env_config_MANUAL_LOCK_CMD"
)m4_dnl

m4_ifdef({<<m4_env_config_PLAYERCTL>>},m4_dnl
# Media player controls
bindsym XF86AudioPlay exec --no-startup-id "pplayerctl play-pause; sleep 0.1; pkill -RTMIN+2 i3blocks"
bindsym XF86AudioPause exec --no-startup-id "pplayerctl play-pause; sleep 0.1; pkill -RTMIN+2 i3blocks"
bindsym XF86AudioNext exec --no-startup-id "pplayerctl next; sleep 0.2; pkill -RTMIN+2 i3blocks"
bindsym XF86AudioPrev exec --no-startup-id "pplayerctl previous; sleep 0.2; pkill -RTMIN+2 i3blocks"
bindsym $mod+m exec --no-startup-id "pplayerctl next; sleep 0.2; pkill -RTMIN+2 i3blocks"
bindsym $mod+n exec --no-startup-id "pplayerctl previous; sleep 0.2; pkill -RTMIN+2 i3blocks"
bindsym XF86Forward exec --no-startup-id "pplayerctl next; sleep 0.2; pkill -RTMIN+2 i3blocks"
bindsym XF86Back exec --no-startup-id "pplayerctl previous; sleep 0.2; pkill -RTMIN+2 i3blocks"
)
# Volume
m4_define({<<m4_ALSA_DEVICE>>},m4_dnl
m4_ifdef({<<m4_env_config_PULSEAUDIO>>},-D pulse))
# Note: Using -D pulse requires alsa-plugins on Arch linux
# If pluse is not used and you get the error
#	amixer: Unable to find simple control 'Master',0
# then the wrong (or no?) default card is set.
# cat /proc/asound/cards to see the available cards.
# The card can be set with `-c` or in /etc/asound.conf or ~/.asoundrc
# https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture#Set_the_default_sound_card
bindsym $mod+comma exec --no-startup-id "amixer -M -q m4_ALSA_DEVICE set Master 3%- unmute; pkill -RTMIN+1 i3blocks"
bindsym $mod+period exec --no-startup-id "amixer -M -q m4_ALSA_DEVICE set Master 3%+ unmute; pkill -RTMIN+1 i3blocks"
bindsym XF86AudioRaiseVolume exec --no-startup-id "amixer -M -q m4_ALSA_DEVICE set Master 3%+ unmute; pkill -RTMIN+1 i3blocks"
bindsym XF86AudioLowerVolume exec --no-startup-id "amixer -M -q m4_ALSA_DEVICE set Master 3%- unmute; pkill -RTMIN+1 i3blocks"
bindsym XF86AudioMute exec --no-startup-id "amixer -M -q m4_ALSA_DEVICE set Master toggle; pkill -RTMIN+1 i3blocks"

m4_ifdef({<<m4_env_config_BRIGHTNESSCTL>>},m4_dnl
# Brightness
bindsym XF86MonBrightnessUp exec --no-startup-id "brightnessctl set 10%+"
bindsym XF86MonBrightnessDown exec --no-startup-id "brightnessctl set 10%-"
bindsym $mod+XF86MonBrightnessUp exec --no-startup-id "brightnessctl set 1%+"
bindsym $mod+XF86MonBrightnessDown exec --no-startup-id "brightnessctl set 1%-"
,m4_dnl
m4_ifdef({<<m4_env_config_XBACKLIGHT>>},m4_dnl
# Brightness
bindsym XF86MonBrightnessUp exec --no-startup-id "xbacklight -inc 10"
bindsym XF86MonBrightnessDown exec --no-startup-id "xbacklight -dec 10"
bindsym $mod+XF86MonBrightnessUp exec --no-startup-id "xbacklight -inc 1"
bindsym $mod+XF86MonBrightnessDown exec --no-startup-id "xbacklight -dec 1"
)m4_dnl
)m4_dnl

m4_ifdef({<<m4_env_config_MAIM>>},m4_dnl
# Screenshots
bindsym Print exec --no-startup-id "maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png"
bindsym Control+Print exec --no-startup-id "mkdir -p ~/Pictures/screenshots && maim ~/Pictures/screenshots/$(date -Iseconds | sed 's/:/_/g').png"
bindsym $mod+g exec --no-startup-id "maim -s | xclip -selection clipboard -t image/png")

# Program special cases
for_window [class="stellaris"] floating disable, fullscreen enable
for_window [class="zoom"] floating enable

# Start a status bar.
bar {
m4_ifdef({<<m4_env_config_I3BLOCKS>>},m4_dnl
	status_command m4_env_config_I3BLOCKS,
	status_command i3status)
	position bottom
}

m4_ifdef({<<m4_env_config_DEX>>},m4_dnl
{<<# Auto-start desktop entries>>}
exec --no-startup-id m4_env_config_DEX -ae i3 -s /etc/xdg/autostart:m4_user_config_XDG_CONFIG_HOME/autostart)

m4_ifdef({<<m4_env_config_PICOM>>},m4_dnl
{<<# Run the picom compositor>>}
exec --no-startup-id m4_env_config_PICOM --daemon)

m4_sinclude(src/config/i3/config.local)m4_dnl
