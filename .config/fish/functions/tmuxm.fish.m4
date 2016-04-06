function tmuxm --description "Create or attach to tmux session named 'main'"
	tmux new-session -A -s main
end
