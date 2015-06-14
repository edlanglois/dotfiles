function fish_prompt --description 'Write out the prompt'
	set last_status $status
	
	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end

	if [ $last_status = 0 ]
		set -g __fish_prompt_name (set_color cyan)
	else
		set -g __fish_prompt_name (set_color red)
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

		echo -n -s "$__fish_prompt_name" "$USER" "$__fish_prompt_normal" ': ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '# '

		case '*'

		if not set -q __fish_prompt_cwd
			set -g __fish_prompt_cwd (set_color $fish_color_cwd)
		end

		echo -n -s "$__fish_prompt_name" "$USER" "$__fish_prompt_normal" ': ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '> '

	end
end
