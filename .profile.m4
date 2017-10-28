m4_include(env_config.m4)
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# same for LD_LIBRARY_PATH
if [ -d "$HOME/lib" ] ; then
	LD_LIBRARY_PATH="$HOME/lib:$LD_LIBRARY_PATH"
fi
m4_ifdef(??[[<<m4_env_config_GEM_BIN_PATH>>]]??,
PATH="${PATH}:m4_env_config_GEM_BIN_PATH"
)
