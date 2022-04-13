m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
[user]
	name = m4_user_config_NAME
	email = m4_user_config_EMAIL
[color]
	ui = true
[core]
	editor = vim
	excludesfile = m4_user_config_XDG_CONFIG_HOME/git/ignore
[init]
	templateDir = m4_user_config_XDG_CONFIG_HOME/git/template
	defaultBranch = master
[diff]
	tool = vimdiff
[merge]
	tool = vimdiff
[mergetool]
	keepBackup = false
[alias]
	a = add
	and-submodules = submodule update --init --recursive
	ap = add --patch
	b = branch
	bd = branch -d
	bm = branch --merged
	cb = checkout -b
	cm = commit -m
	d = diff
	dc = diff --cached
	ds = diff --stat
	dcs = diff --cached --stat
	s = status
	ss = status --short
	showtrackedignored = ls-files -i --exclude-standard
	t = log --graph --oneline --decorate --author-date-order
	ta = log --graph --oneline --decorate --author-date-order --all
	tn = log --graph --author-date-order --pretty=format:"%C(yellow)%h%Cblue\\ [%cn]%Cred%d\\ %Creset%s"
	tan = log --graph --author-date-order --all --pretty=format:"%C(yellow)%h%Cblue\\ [%cn]%Cred%d\\ %Creset%s"
	ts = log --graph --oneline --decorate --author-date-order --numstat
	tas = log --graph --oneline --decorate --author-date-order --all --numstat
	tns = log --graph --author-date-order --pretty=format:"%C(yellow)%h%Cblue\\ [%cn]%Cred%d\\ %Creset%s%n" --numstat
	tans = log --graph --author-date-order --all --pretty=format:"%C(yellow)%h%Cblue\\ [%cn]%Cred%d\\ %Creset%s%n" --numstat
m4_ifdef({<<m4_env_config_GIT_CONFIG_PUSH_DEFAULT>>},
[push]
	default = simple
)m4_dnl
m4_ifdef({<<m4_env_config_GIT_CONFIG_PULL_REBASE>>},
[pull]
	rebase = false
)m4_dnl
