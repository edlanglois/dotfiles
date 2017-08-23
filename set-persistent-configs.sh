#!/usr/bin/env bash
# Persistent configurations that only need to be run once.
set -eux

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

# Generate the font configuration - Fonts must have been installed first.
if hash fc-cache 2>/dev/null; then
	fc-cache -vf ~/.fonts
fi
