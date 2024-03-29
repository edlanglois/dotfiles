m4_include(env_config.m4)m4_dnl
m4_include(user_config.m4)m4_dnl
m4_ifdef({<<m4_env_config_SHELL>>},
set -g default-shell m4_env_config_SHELL
)m4_dnl
# Force >=256 colours.
set -g default-terminal "tmux-256color"
# Enable True Colour (24-bit colour).
set -sa terminal-overrides ",alacritty:Tc"
set -sa terminal-overrides ",terminator:Tc"
set -sa terminal-overrides ",xterm-termite:Tc"

# Set Ctrl-a as the default prefix
unbind C-b
set -g prefix C-a
bind C-a send-prefix

m4_ifdef({<<m4_env_config_TMUX_GE_2_2>>},,m4_dnl
# Use UTF8
set -g utf8
set-window-option -g utf8 on

)m4_dnl
# Support xterm keys (like ctrl-arrow for moving by word)
set-window-option -g xterm-keys on

# Make window full sized when looking at different windows with different
# sessions.
set-window-option -g aggressive-resize on

# set scrollback history to 10k
set -g history-limit 10000

# shorten command delay
set -sg escape-time 0

# Vi mode keys
set-window-option -g mode-keys vi

# 12 Hour Clock
set-window-option -g clock-mode-style 12

# Disable bell monitoring
set-option -g monitor-bell off

m4_ifdef({<<m4_env_config_TMUX_GE_2_0>>},m4_dnl
# Send focus events
set -g focus-events on

)m4_dnl
# Use | and - to split windows
bind | split-window -h
bind - split-window -v

# Use h and v to split windows horizontally and vertically, respectively.
bind h split-window -h
bind v split-window -v

# Make the current pane the first pane
bind Enter swap-pane -s 0

# Next / prev window while holding Ctrl.
bind C-p previous-window
bind C-n next-window

# resize panes using HJKL
bind -r H resize-pane -L
bind -r J resize-pane -D
bind -r K resize-pane -U
bind -r L resize-pane -R

# Next layout with space
bind Space next-layout

# explicitly disable mouse control
m4_ifdef({<<m4_env_config_TMUX_GE_2_0>>},m4_dnl
set -g mouse off,
set -g mode-mouse off)

# reload config file
bind R source-file ~/.tmux.conf \; display-message "Config reloaded."

# Status bar
set -g status-keys vi
set -g status-interval 5

# Use tmuxline status bar if available
if-shell "test -f m4_user_config_XDG_CONFIG_HOME/tmux/tmuxline.conf" "source m4_user_config_XDG_CONFIG_HOME/tmux/tmuxline.conf"
