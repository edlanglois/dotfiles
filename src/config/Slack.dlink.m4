m4_include(env_config.m4)m4_dnl
m4_dnl Slack stores data and cache in config.
m4_dnl Some might actually be config but I don't intend to share across machines
m4_dnl https://github.com/electron/electron/issues/8124
m4_env_config_XDG_DATA_HOME/Slack
