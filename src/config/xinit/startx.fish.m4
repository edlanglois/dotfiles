m4_include(env_config.m4)m4_dnl
# Start an x session with fish

# Save startx output to a log file
# xorg also logs to /home/eric/.local/share/xorg/Xorg.0.log
# but the contents are different
startx m4_env_config_XDG_CONFIG_HOME/xinit/xinitrc -- m4_env_config_XDG_CONFIG_HOME/xinit/xserverrc -keeptty &>m4_env_config_XDG_CACHE_HOME/fish-startx.log
m4_ifdef({<<m4_env_config_SYSTEMCTL>>},m4_dnl
systemctl --no-block --user stop xsession.target)
