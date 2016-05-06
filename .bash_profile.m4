m4_include(env_config.m4)m4_dnl
if [[ -f ~/.profile ]]; then
	source ~/.profile;
elif [[ -f ~/.bashrc ]]; then
	source ~/.bashrc;
fi

# Start an ssh agent if none is running
if [[ -z $SSH_AUTH_SOCK ]] || ssh-add -l 2>&1 | grep 'Error connecting to agent' >/dev/null; then
	if hash ssh-agent 2>/dev/null; then
		eval $(ssh-agent)
		# Add private keys to the keychain
		if ls .ssh/*.pub &>/dev/null; then
			ssh-add $(ls .ssh/*.pub | sed 's/\.pub$//')
		fi
	fi
fi

m4_ifdef(??[[<<m4_env_config_BREW_BIN_PATH>>]]??,

export PATH=$PATH:m4_env_config_BREW_BIN_PATH
)m4_dnl
