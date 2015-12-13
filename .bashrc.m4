m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

m4_ifdef(??[[<<m4_env_config_LOCALE>>]]??,
export LC_ALL="m4_env_config_LOCALE"
)m4_dnl

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
# HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) colour_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_colour_prompt=yes

if [ -n "$force_colour_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	colour_prompt=yes
    else
	colour_prompt=
    fi
fi

if [ "$colour_prompt" = yes ]; then
    # Print username in cyan if last command succeeded and red if it failed.
    m4_ifdef(??[[<<m4_env_config_ROOT>>]]??,
    export PS1="\`if [ \$? = 0 ]; then echo \[\e[0\;30\;43m\]; else echo \[\e[0\;31\;43m\]; fi\`\u\[\e[m\]:\[\e[1;33m\]\w\[\e[m\]>\[\e[m\] ",
    export PS1="\`if [ \$? = 0 ]; then echo \[\e[0\;36m\]; else echo \[\e[0\;31m\]; fi\`\u\[\e[m\]:\[\e[1;33m\]\w\[\e[m\]>\[\e[m\] "
)m4_dnl
else
    PS1='${debian_chroot:+($debian_chroot)}\u:\w> '
fi
unset force_colour_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$colour_prompt" = yes -a -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ "$TERM" != "dumb" ] && command -v fortune >/dev/null; then
	command fortune&
	FORTUNE=$!
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export INPUTRC=$HOME/.inputrc
export EDITOR=vim

# Colour for ls in BSD/OSX
export CLICOLOR=1

# Coloured Man Pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# Set shared library path
export LD_RUN_PATH=$HOME/lib:/usr/local/lib:/usr/lib

if [ -n "$FORTUNE" ]; then
	wait $FORTUNE
fi
echo "Hello $(whoami). Welcome to $(hostname)."
