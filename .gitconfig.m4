m4_include(user_config.m4)m4_dnl
[user]
	name = m4_user_config_NAME
	email = m4_user_config_EMAIL
[color]
	ui = true
[core]
	editor = vim
	excludesfile = ~/.gitignore_global
[diff]
	tool = vimdiff
[merge]
	tool = vimdiff
[mergetool]
	keepBackup = false
[alias]
	and-submodules = submodule update --init --recursive
	b = branch
	bm = branch --merged
	cb = checkout --branch
	d = diff
	dc = diff --cached
	s = status
	showtrackedignored = ls-files -i --exclude-standard
	tree = log --graph --oneline --decorate --author-date-order
	treea = log --graph --oneline --all --decorate --author-date-order
