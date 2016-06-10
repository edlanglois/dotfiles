m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_DEFAULT_SHELL>>]]??,
set -g default-shell m4_env_config_DEFAULT_SHELL
)m4_dnl
# Force 256 colours.
set -g default-terminal "screen-256color"

# Set Ctrl-a as the default prefix
unbind C-b
set -g prefix C-a
bind C-a send-prefix

m4_ifdef(??[[<<m4_env_config_TMUX_GE_2_2>>]]??,,m4_dnl
# Use UTF8
set -g utf8
set-window-option -g utf8 on

)m4_dnl
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

m4_ifdef(??[[<<m4_env_config_TMUX_GE_2_0>>]]??,m4_dnl
# Send focus events
set -g focus-events on

)m4_dnl
# Use | and - to split windows
bind | split-window -h
bind - split-window -v

# Use h and v to split windows horizontally and vertically, respectively.
bind h split-window -h
bind v split-window -v

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
m4_ifdef(??[[<<m4_env_config_TMUX_GE_2_0>>]]??,m4_dnl
set -g mouse off,
set -g mode-mouse off)

# reload config file
bind R source-file ~/.tmux.conf \; display-message "Config reloaded."

# Status bar
set -g status-keys vi
set -g status-interval 5

# Use tmuxline status bar if available
if-shell "test -f .tmuxline.conf" "source .tmuxline.conf"
