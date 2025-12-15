m4_include(env_config.m4)m4_dnl
m4_include(user_config.m4)m4_dnl

[Appearance]
ColorScheme=Custom
Font=Hack,m4_user_config_TERMINAL_FONT_SIZE

[General]
Command=m4_env_config_SHELL
Name=Custom
Parent=FALLBACK/
