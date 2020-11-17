m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl

# Note: The path cannot be quoted. The XDG_CONFIG_HOME variable may use the `~` 
# character, which is only expanded to $HOME if the string is unqouted.
set fish_function_path $fish_function_path m4_user_config_XDG_CONFIG_HOME/fish/plugins/foreign-env/functions

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

# Set hostname icon
set -x HOSTNAME_ICON (hostname-icon)

# Source environment variables from env_profile using the foreign env plugin.
fenv source m4_user_config_XDG_CONFIG_HOME/env_profile

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

m4_ifdef(??[[<<m4_env_config_VIRTUALFISH_INIT>>]]??,
# Enable virtualfish auto-activation.
set -x VIRTUALFISH_HOME m4_user_config_XDG_DATA_HOME/python-virtualenvs
m4_env_config_VIRTUALFISH_INIT
)m4_dnl

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        # Save startx output to a log file
        # xorg also logs to /home/eric/.local/share/xorg/Xorg.0.log
        # but the contents are different
        exec startx m4_env_config_XDG_CONFIG_HOME/xinit/xinitrc -- m4_env_config_XDG_CONFIG_HOME/xinit/xserverrc -keeptty &>m4_env_config_XDG_CACHE_HOME/fish-startx.log
    end
end
