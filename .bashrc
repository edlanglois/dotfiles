CLASSPATH=:/u/cs350/sys161/bin:/u/cs350/bin

export PS1="\`if [ \$? = 0 ]; then echo \[\e[0\;36m\]; else echo \[\e[0\;31m\]; fi\`\u\[\e[m\]:\[\e[1;33m\]\w\[\e[m\]>\[\e[m\] "
export PATH=$PATH:$HOME/bin$CLASSPATH
export HISTCONTROL=ignoredups
export INPUTRC=$HOME/.inputrc
export EDITOR=vim

alias apox='apropos'
alias quit='exit'
alias hex='xxd -c 4'

if [ "$TERM" != "dumb" ]; then
	command fortune &
	FORTUNE=$!
	eval "`dircolors -b`"
	if ls &>/dev/null; then 
		alias ls='ls --color=auto'
	fi

	export GREP_OPTIONS='--color=auto'
fi

if [ -e /u/cs241/setup ]; then
	source /u/cs241/setup
fi

if [ -n "$FORTUNE" ]; then
	wait $FORTUNE
	echo "Hello Eric. Welcome to $(hostname)."
fi
