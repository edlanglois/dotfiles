m4_include(env_config.m4)m4_dnl
[global_config]
  inactive_color_offset = 1.0
[profiles]
  [[default]]
m4_ifdef(??[[<<m4_env_config_NETUSER>>]]??,m4_ifdef(??[[<<m4_env_config_SHELL>>]]??,m4_dnl
    custom_command = m4_env_config_SHELL
    use_custom_command = True
))m4_dnl
    font = monospace 11
    foreground_color = "#ffffff"
    palette = "#000000:#cd0000:#00cd00:#cdcd00:#0000ee:#cd00cd:#00cdcd:#e5e5e5:#7f7f7f:#ff0000:#00ff00:#ffff00:#5c5cff:#ff00ff:#00ffff:#ffffff"
    scrollback_lines = 10000
    scrollbar_position = hidden
    show_titlebar = False
    use_system_font = False
