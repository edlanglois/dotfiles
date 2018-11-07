m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
# Plugins
set fish_function_path $fish_function_path "$HOME/.config/fish/plugins/foreign-env/functions"

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

# Set SHELL
set --global -x SHELL (which fish)

# Set hostname icon
set -x HOSTNAME_ICON (hostname-icon)

# Source environment variables from ~/.env_profile using the foreign env plugin.
fenv source "$HOME/.env_profile"

m4_ifdef(??[[<<m4_env_config_MODULE_GE_4>>]]??,m4_dnl
# Enable the "module" command
modulecmd fish autoinit | source -
m4_ifdef(??[[<<m4_env_config_MODULE_DEFAULT_COLLECTION>>]]??,m4_dnl
# Install the default modules
module restore "m4_env_config_MODULE_DEFAULT_COLLECTION" >/dev/null
),m4_ifdef(??[[<<m4_env_config_MODULE_INIT_DIR>>]]??,m4_dnl
# Enable the "module" command
if test -f "m4_env_config_MODULE_INIT_DIR/fish"
  source "m4_env_config_MODULE_INIT_DIR/fish"
end
))m4_dnl

m4_ifdef(??[[<<m4_env_config_KEYCHAIN>>]]??,
# Start keychain - ensures ssh-agent is running.
if status --is-interactive
	keychain --eval --agents ssh --quick --quiet | source
end
)m4_dnl

m4_ifdef(??[[<<m4_env_config_VIRTUALFISH_INIT>>]]??,
# Enable virtualfish auto-activation.
m4_env_config_VIRTUALFISH_INIT
)m4_dnl
