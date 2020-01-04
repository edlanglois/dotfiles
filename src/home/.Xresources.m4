m4_include(env_config.m4)m4_dnl
XTerm.termName: xterm-256color
UXTerm.termName: xterm-256color
*.vt100.locale: true

Xft.rgba: rgb

*renderFont: true
*faceName: DejaVu Sans Mono
*faceSize: m4_env_config_TERM_FONT_SIZE

URxvt*scrollBar: false

! special
*.foreground:   #m4_env_config_COLOUR_FOREGROUND
*.background:   #m4_env_config_COLOUR_BACKGROUND
*.cursorColor:  #m4_env_config_COLOUR_CURSOR

*.color0:       #m4_env_config_COLOUR_0
*.color1:       #m4_env_config_COLOUR_1
*.color2:       #m4_env_config_COLOUR_2
*.color3:       #m4_env_config_COLOUR_3
*.color4:       #m4_env_config_COLOUR_4
*.color5:       #m4_env_config_COLOUR_5
*.color6:       #m4_env_config_COLOUR_6
*.color7:       #m4_env_config_COLOUR_7
*.color8:       #m4_env_config_COLOUR_8
*.color9:       #m4_env_config_COLOUR_9
*.color10:      #m4_env_config_COLOUR_10
*.color11:      #m4_env_config_COLOUR_11
*.color12:      #m4_env_config_COLOUR_12
*.color13:      #m4_env_config_COLOUR_13
*.color14:      #m4_env_config_COLOUR_14
*.color15:      #m4_env_config_COLOUR_15
