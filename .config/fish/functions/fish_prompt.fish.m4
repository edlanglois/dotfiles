m4_include(env_config.m4)m4_dnl
function fish_prompt --description 'Write out the prompt'
	set last_status $status

	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end

	if not set -q __fish_prompt_symbol
		set -g __fish_prompt_symbol '> '
	end

	if not set -q __fish_prompt_host
		set -g __fish_prompt_host (set_color yellow)
	end

	switch $USER
		case root
			if not set -q __fish_prompt_cwd
				if set -q fish_color_cwd_root
					set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
				else
					set -g __fish_prompt_cwd (set_color $fish_color_cwd)
				end
			end
			set -g __fish_prompt_name_options '-b'

		case '*'
			if not set -q __fish_prompt_cwd
				set -g __fish_prompt_cwd (set_color $fish_color_cwd)
			end
			set -g __fish_prompt_name_options
	end

	if set -q VIRTUAL_ENV
		set -g __fish_prompt_virtualenv_msg (set_color magenta) '('(basename "$VIRTUAL_ENV")')'"$__fish_prompt_normal"
	else
		set -g __fish_prompt_virtualenv_msg ''
	end

	if [ $last_status = 0 ]
		set -g __fish_prompt_name (set_color $__fish_prompt_name_options cyan)
	else
		set -g __fish_prompt_name (set_color $__fish_prompt_name_options red)
	end

		echo -n -s "$__fish_prompt_host" "m4_env_config_HOSTNAME_ICON " "$__fish_prompt_name" "$USER" "$__fish_prompt_normal" ': ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" "$__fish_prompt_virtualenv_msg" "$__fish_prompt_symbol"

end
