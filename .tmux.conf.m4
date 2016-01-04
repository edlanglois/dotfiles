m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_DEFAULT_SHELL>>]]??,
set -g default-shell m4_env_config_DEFAULT_SHELL
)m4_dnl
set -g default-terminal "screen-256color"

#Set Ctrl-a as the default prefix
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Use UTF8
set -g utf8
set-window-option -g utf8 on

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

# Send focus events
set -g focus-events on

# Use | and - to split windows
bind | split-window -h
bind - split-window -v

# Zoom with z
bind z resize-pane -Z

# Use ctrl-n and ctrl-N (without prefix) to split windows
bind -n C-n split-window -h

# Smart pane switching with awareness of vim splits
# Ctrl-h,j,k,l => left,down,up,right
# Ctrl-\ previous split
is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?)(-p3)?(diff)?$"'
bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"
bind -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"

# Make the current pane the first pane
bind Enter swap-pane -s 0

# Rotate with ctrl-o
bind -r o rotate-window

# Last window
bind l last-window

# resize panes using HJKL
bind -r H resize-pane -L
bind -r J resize-pane -D
bind -r K resize-pane -U
bind -r L resize-pane -R

# Next layout with space
bind Space next-layout

# explicitly disable mouse control
set -g mouse off

# reload config file
unbind r
bind r source-file ~/.tmux.conf \; display-message "Config reloaded."

# Status bar
set -g status-keys vi
set -g status-interval 1
set -g status-attr bright
set -g status-fg white
set -g status-bg colour17
set -g status-left-length 20
set -g status-left '#[fg=green][#[fg=red]#S#[fg=green]]#[default]'
set -g status-justify centre
set -g status-right '#[fg=grey][ %b %d %H:%M:%S ]#[default]'
setw -g window-status-current-format '#[fg=yellow](#I.#P#F#W)#[default]'
setw -g window-status-format '#I#F#W'

# Use tmuxline status bar if available
if-shell "test -f .tmuxline.conf" "source .tmuxline.conf"