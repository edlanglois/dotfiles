m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
if [[ -f ~/.profile ]]; then
	source ~/.profile;
elif [[ -f ~/.bashrc ]]; then
	source ~/.bashrc;
fi
m4_ifdef(??[[<<m4_env_config_KEYCHAIN>>]]??,
eval $(keychain --eval --agents ssh --quick --quiet)
)m4_dnl
m4_ifdef(??[[<<m4_env_config_BREW_BIN_PATH>>]]??,
export PATH=$PATH:m4_env_config_BREW_BIN_PATH
)m4_dnl
m4_ifdef(??[[<<m4_env_config_GEM_BIN_PATH>>]]??,
export PATH=$PATH:m4_env_config_GEM_BIN_PATH
)m4_dnl
