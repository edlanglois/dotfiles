#!/usr/bin/env bash
# Persistent configurations that only need to be run once.
set -eux

# GNOME configuration
if hash gsettings 2>/dev/null && [ -n "${DISPLAY:-}" ]; then
	# Set Capslock to the control key on GNOME
	gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

	# Fix Nautilus on i3.
	# Otherwise creates an invisible, unresponsive something when opened.
	gsettings set org.gnome.desktop.background show-desktop-icons false

fi

# Generate the font configuration - Fonts must have been installed first.
if hash fc-cache 2>/dev/null; then
	fc-cache -vf ~/.fonts
fi
