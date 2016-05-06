m4_include(env_config.m4)m4_dnl
set -g fish_color_cwd yellow

# Coloured man pages
set -x LESS_TERMCAP_mb (printf "\e[01;31m")
set -x LESS_TERMCAP_md (printf "\e[01;38;5;74m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[38;5;246m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[04;38;5;146m")

# Add user's bin to path
set --global fish_user_paths $fish_user_paths $HOME/bin
m4_ifdef(??[[<<m4_env_config_GEM_BIN_PATH>>]]??,

# Add ruby gem bin directory to path
set --global fish_user_paths $fish_user_paths (echo "m4_env_config_GEM_BIN_PATH" | sed 's/:/\n/g')
)m4_dnl

# Start an ssh agent if none is running
if begin [ -z "$SSH_AUTH_SOCK" ]; or ssh-add -l ^&1 | grep 'Error connecting to agent' >/dev/null; end
	if command --search gnome-keyring-daemon >/dev/null
		gnome-keyring-daemon --start | sed -e 's/^/set -x /' -e 's/=/ /' -e 's/$/;/' | source
		# Auto adds keys, no need to call ssh-add manually
	else if command --search ssh-agent >/dev/null
		ssh-agent | sed -e 's/^SSH/set -x SSH/' -e 's/=/ /' -e 's/export [^;]*;//' | source
		# Add private keys to the keychain
		if ls .ssh/*.pub >/dev/null ^&1
			ssh-add (ls .ssh/*.pub | sed 's/\.pub$//')
		end
	end
end

# Add private keys to the keychain
ssh-add m4_user_config_PRIVATE_KEYS
m4_ifdef(??[[<<m4_env_config_VIRTUALFISH>>]]??,

# Enable virtualfish auto-activation.
eval (python -m virtualfish auto_activation)
)m4_dnl
