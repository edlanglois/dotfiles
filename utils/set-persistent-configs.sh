#!/usr/bin/env bash
# Persistent configurations that only need to be run once.
set -eux

# Terminal info for termite
if ! infocmp xterm-termite 1>/dev/null 2>&1; then
	curl 'https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo' -o '/tmp/termite.terminfo'
	tic -x '/tmp/termite.terminfo'
fi

# GNOME configuration
if hash gsettings 2>/dev/null && [ -n "${DISPLAY:-}" ]; then
	# Set Capslock to the control key on GNOME
	gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" || true

	# Fix Nautilus on i3.
	# Otherwise creates an invisible, unresponsive something when opened.
	gsettings set org.gnome.desktop.background show-desktop-icons false || true
fi

# Program Defaults
DEFAULT_BROWSER=$(./env/browser | grep 'BROWSER=' | sed 's/.*=//')
if [ -n "$DEFAULT_BROWSER" ]; then
	xdg-settings set default-web-browser ${DEFAULT_BROWSER}.desktop
fi

# Enable low-battery monitor if have a battery and systemctl
if hash systemctl 2>/dev/null && [ -n "$(env/battery)" ]; then
  systemctl --user enable low-battery.timer
fi

# Generate the font configuration - Fonts must have been installed first.
if hash fc-cache 2>/dev/null; then
	fc-cache -vf ~/.fonts
fi
