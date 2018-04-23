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
*.foreground:   #ffffff
*.background:   #000000
*.cursorColor:  #ffffff

! black
*.color0:       #000000
*.color8:       #7f7f7f

! red
*.color1:       #cd0000
*.color9:       #ff0000

! green
*.color2:       #00cd00
*.color10:      #00ff00

! yellow
*.color3:       #cdcd00
*.color11:      #ffff00

! blue
*.color4:       #0000ee
*.color12:      #5c5cff

! magenta
*.color5:       #cd00cd
*.color13:      #ff00ff

! cyan
*.color6:       #00cdcd
*.color14:      #00ffff

! white
*.color7:       #e5e5e5
*.color15:      #ffffff
