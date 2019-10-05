m4_include(env_config.m4)m4_dnl
# Based on
# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod1

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:Noto Sans 13px

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec m4_ifdef(??[[<<m4_env_config_TERMINAL>>]]??,m4_dnl
m4_env_config_TERMINAL, i3-sensible-terminal)

# Open a browser window
bindsym $mod+b exec xdg-open http://

# Open the Google Play Music desktop player
bindsym $mod+m exec gpmdp

# kill focused window
bindsym $mod+Shift+q kill

m4_ifdef(??[[<<m4_env_config_DMENU>>]]??,m4_dnl
# start dmenu (a program launcher)
bindsym $mod+d exec --no-startup-id m4_env_config_DMENU)

# mod+Escape to toggle pass-through mode.
mode "passthrough" {
    bindsym $mod+Escape mode "default"
}
bindsym $mod+Escape mode "passthrough"

# Switch to window when activated
focus_on_window_activation focus

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

# move workspace left/right
bindsym $mod+Shift+bracketleft move workspace to output left
bindsym $mod+Shift+bracketright move workspace to output right

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

# Lock screen
bindsym $mod+Mod4+l exec "m4_env_config_LOCK_CMD"

m4_ifdef(??[[<<m4_env_config_PLAYERCTL>>]]??,m4_dnl
# Media player controls
bindsym XF86AudioPlay exec playerctl play-pause
bindsym XF86AudioPause exec playerctl play-pause
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous
bindsym XF86Forward exec playerctl next
bindsym XF86Back exec playerctl previous
)
# Volume
bindsym $mod+comma exec "amixer -q set Master 5%- unmute; pkill -RTMIN+1 i3blocks"
bindsym $mod+period exec "amixer -q set Master 5%+ unmute; pkill -RTMIN+1 i3blocks"
bindsym XF86AudioRaiseVolume exec "amixer -q set Master 5%+ unmute; pkill -RTMIN+1 i3blocks"
bindsym XF86AudioLowerVolume exec "amixer -q set Master 5%- unmute; pkill -RTMIN+1 i3blocks"
m4_ifdef(??[[<<m4_env_config_PULSEAUDIO>>]]??,m4_dnl
bindsym XF86AudioMute exec "amixer -q -D pulse set Master toggle; pkill -RTMIN+1 i3blocks",m4_dnl
bindsym XF86AudioMute exec "amixer -q set Master toggle; pkill -RTMIN+1 i3blocks")

m4_ifdef(??[[<<m4_env_config_XBACKLIGHT>>]]??,m4_dnl
# Brightness
bindsym XF86MonBrightnessUp exec "xbacklight -inc 10"
bindsym XF86MonBrightnessDown exec "xbacklight -dec 10"
bindsym $mod+XF86MonBrightnessUp exec "xbacklight -inc 1"
bindsym $mod+XF86MonBrightnessDown exec "xbacklight -dec 1"
)m4_dnl

# Start a status bar.
bar {
m4_ifdef(??[[<<m4_env_config_I3BLOCKS>>]]??,m4_dnl
	status_command i3blocks,
	status_command i3status)
	position bottom
}

m4_ifdef(??[[<<m4_env_config_START_SCREENSAVER>>]]??,m4_dnl
exec m4_env_config_START_SCREENSAVER)

m4_ifdef(??[[<<m4_env_config_DEX>>]]??,m4_dnl
# Auto-start desktop entries in {/etc/xdg,~/.config}/autostart
exec m4_env_config_DEX -ae i3)

m4_sinclude(.config/i3/config.local)m4_dnl
