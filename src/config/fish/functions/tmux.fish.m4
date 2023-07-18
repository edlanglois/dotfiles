m4_include(user_config.m4)m4_dnl
function tmux --description 'Tmux - Terminal Multiplexer'
	/usr/bin/env tmux -f m4_user_config_XDG_CONFIG_HOME/tmux/tmux.conf $argv
end
