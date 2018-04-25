m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
set -g fish_color_cwd yellow
set -g fish_pager_color_description cea746

# Disable greeting message
set fish_greeting ""

# Coloured man pages
set -x LESS_TERMCAP_mb (printf \e"[01;31m")
set -x LESS_TERMCAP_md (printf \e"[01;38;5;74m")
set -x LESS_TERMCAP_me (printf \e"[0m")
set -x LESS_TERMCAP_se (printf \e"[0m")
set -x LESS_TERMCAP_so (printf \e"[38;5;246m")
set -x LESS_TERMCAP_ue (printf \e"[0m")
set -x LESS_TERMCAP_us (printf \e"[04;38;5;146m")

# Set editor to vim
set --global -x EDITOR vim

# Set hostname icon
set -x HOSTNAME_ICON (hostname-icon)

# Add user's bin to path
set --global fish_user_paths $fish_user_paths $HOME/bin $HOME/.local/bin

m4_ifdef(??[[<<m4_env_config_CUDA_ROOT>>]]??,
# CUDA Path
set --global -x CUDA_HOME "m4_env_config_CUDA_ROOT"
set --global -x LD_LIBRARY_PATH (set -q LD_LIBRARY_PATH; and echo $LD_LIBRARY_PATH:; or echo)"$CUDA_HOME/lib64"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_GOROOT>>]]??,
# Go Path
set --global -x GOROOT "m4_env_config_GOROOT"
set --global fish_user_paths $fish_user_paths "$GOROOT/bin"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_GEM_BIN_PATH>>]]??,
# Add ruby gem bin directory to path
set --global fish_user_paths $fish_user_paths (echo "m4_env_config_GEM_BIN_PATH" | sed 's/:/\n/g')
)m4_dnl

m4_ifdef(??[[<<m4_env_config_KEYCHAIN>>]]??,
# Start keychain - ensures ssh-agent is running.
if status --is-interactive
	keychain --eval --agents ssh --quick --quiet | source
end
)m4_dnl

m4_ifdef(??[[<<m4_env_config_VIRTUALFISH>>]]??,
# Enable virtualfish auto-activation.
eval (python -m virtualfish auto_activation global_requirements)
)m4_dnl
