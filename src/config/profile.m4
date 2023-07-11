# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Manually load pam_environment if PAM didn't
if [ -z "$PAM_USER_ENV" ]; then
	# Parse VAR_NAME DEFAULT=... entries
	eval "$(sed ~/.pam_environment -ne 's/^\([[:alnum:]_]\+\) \+DEFAULT=/export \1=/p')"
fi

. "${XDG_CONFIG_HOME:-$HOME/.config}/env_profile"

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		source "$HOME/.bashrc"
	fi
fi
