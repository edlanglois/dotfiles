m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl

[env]
XDG_CACHE_HOME = "m4_env_config_XDG_CACHE_HOME"

[shell]
program = "m4_env_config_SHELL"

[font]
size = m4_user_config_TERMINAL_FONT_SIZE

[colors.primary]
background = "#m4_env_config_COLOUR_BACKGROUND"
foreground = "#m4_env_config_COLOUR_FOREGROUND"

[colors.normal]
black = "#m4_env_config_COLOUR_0"
red = "#m4_env_config_COLOUR_1"
green = "#m4_env_config_COLOUR_2"
yellow = "#m4_env_config_COLOUR_3"
blue = "#m4_env_config_COLOUR_4"
magenta = "#m4_env_config_COLOUR_5"
cyan = "#m4_env_config_COLOUR_6"
white = "#m4_env_config_COLOUR_7"

[colors.bright]
black = "#m4_env_config_COLOUR_8"
red = "#m4_env_config_COLOUR_9"
green = "#m4_env_config_COLOUR_10"
yellow = "#m4_env_config_COLOUR_11"
blue = "#m4_env_config_COLOUR_12"
magenta = "#m4_env_config_COLOUR_13"
cyan = "#m4_env_config_COLOUR_14"
white = "#m4_env_config_COLOUR_15"
