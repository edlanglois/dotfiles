m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
[options]
allow_bold = true
m4_ifdef({<<m4_env_config_BROWSER>>},m4_dnl
browser = m4_env_config_BROWSER
)m4_dnl
clickable_url = true
hyperlinks = true
mouse_autohide = true
fullscreen = false
scrollback_lines = 10000
search_wrap = true
font = monospace m4_user_config_TERMINAL_FONT_SIZE

[colors]
# special
foreground      = #m4_env_config_COLOUR_FOREGROUND
foreground_bold = #m4_env_config_COLOUR_FOREGROUND_BOLD
cursor          = #m4_env_config_COLOUR_CURSOR
background      = #m4_env_config_COLOUR_BACKGROUND

color0  = #m4_env_config_COLOUR_0
color1  = #m4_env_config_COLOUR_1
color2  = #m4_env_config_COLOUR_2
color3  = #m4_env_config_COLOUR_3
color4  = #m4_env_config_COLOUR_4
color5  = #m4_env_config_COLOUR_5
color6  = #m4_env_config_COLOUR_6
color7  = #m4_env_config_COLOUR_7
color8  = #m4_env_config_COLOUR_8
color9  = #m4_env_config_COLOUR_9
color10 = #m4_env_config_COLOUR_10
color11 = #m4_env_config_COLOUR_11
color12 = #m4_env_config_COLOUR_12
color13 = #m4_env_config_COLOUR_13
color14 = #m4_env_config_COLOUR_14
color15 = #m4_env_config_COLOUR_15
