m4_include(env_config.m4)m4_dnl
alias apox='apropos'
alias quit='exit'
alias hex='xxd -c 4'
alias tmux='tmux -2 -f "${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"'

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias lld='ls -ld'

if [ "$colour_prompt" = yes ]; then
    if [ "$(uname)" != "Darwin" ]; then
        alias ls='ls --color=auto'
    fi
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
fi

alias R='R --quiet --no-save'
m4_ifdef(??[[<<m4_env_config_IP_CMD>>]]??,
alias ip='m4_env_config_IP_CMD -c'
)m4_dnl
