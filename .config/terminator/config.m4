m4_include(env_config.m4)m4_dnl
[global_config]
  inactive_color_offset = 1.0
[profiles]
  [[default]]
m4_ifdef(??[[<<m4_env_config_NETUSER>>]]??,m4_ifdef(??[[<<m4_env_config_DEFAULT_SHELL>>]]??,m4_dnl
    custom_command = m4_env_config_DEFAULT_SHELL
))m4_dnl
    font = monospace 11
    scrollback_lines = 10000
    scrollbar_position = hidden
    show_titlebar = False
    use_system_font = False
