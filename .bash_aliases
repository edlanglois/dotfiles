alias apox='apropos'
alias quit='exit'
alias hex='xxd -c 4'
alias tmux='tmux -2'

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias lld='ls -ld'

alias vi="vim"

if [ "$colour_prompt" = yes ]; then
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
fi

alias R='R --quit --no-save'
