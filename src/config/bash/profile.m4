m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
if [[ -f ~/.profile ]]; then
	source ~/.profile;
elif [[ -f ~/.bashrc ]]; then
	source ~/.bashrc;
fi

# Start an X session automatically from the login shell
if shopt -q login_shell && [ -z "$DISPLAY" -a "$XDG_VTNR" = 1 ]; then
	exec bash m4_env_config_XDG_CONFIG_HOME/xinit/startx.sh
fi
