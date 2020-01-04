m4_include(env_config.m4)m4_dnl
[global_config]
  inactive_color_offset = 1.0
[profiles]
  [[default]]
m4_ifdef(??[[<<m4_env_config_NETUSER>>]]??,m4_ifdef(??[[<<m4_env_config_SHELL>>]]??,m4_dnl
    custom_command = m4_env_config_SHELL
    use_custom_command = True
))m4_dnl
    font = monospace m4_env_config_TERM_FONT_SIZE
    foreground_color = "#m4_env_config_COLOUR_FOREGROUND"
    background_color = "#m4_env_config_COLOUR_BACKGROUND"
    palette = "#m4_env_config_COLOUR_0:#m4_env_config_COLOUR_1:#m4_env_config_COLOUR_2:#m4_env_config_COLOUR_3:#m4_env_config_COLOUR_4:#m4_env_config_COLOUR_5:#m4_env_config_COLOUR_6:#m4_env_config_COLOUR_7:#m4_env_config_COLOUR_8:#m4_env_config_COLOUR_9:#m4_env_config_COLOUR_10:#m4_env_config_COLOUR_11:#m4_env_config_COLOUR_12:#m4_env_config_COLOUR_13:#m4_env_config_COLOUR_14:#m4_env_config_COLOUR_15"
    scrollback_lines = 10000
    scrollbar_position = hidden
    show_titlebar = False
    use_system_font = False
