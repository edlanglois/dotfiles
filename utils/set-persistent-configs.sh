#!/usr/bin/env bash
# Persistent configurations that only need to be run once.
set -eux

# Terminal info for termite
if ! infocmp xterm-termite 1>/dev/null 2>&1; then
	TMPDIR="$(mktemp -d)"
	curl 'https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo' -o "$TMPDIR/termite.terminfo"
	tic -x "$TMPDIR/termite.terminfo"
fi

# GNOME configuration
if command -v gsettings 2>/dev/null && [ -n "${DISPLAY:-}" ]; then
	# Set Capslock to the control key on GNOME
	gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" || true

	# Fix Nautilus on i3.
	# Otherwise creates an invisible, unresponsive something when opened.
	gsettings set org.gnome.desktop.background show-desktop-icons false || true
fi

# Program Defaults
DEFAULT_BROWSER=$(./src/env/browser | grep 'BROWSER=' | sed 's/.*=//')
if [ -n "$DEFAULT_BROWSER" ] && [ -z "$BROWSER" ]; then
	xdg-settings set default-web-browser "${DEFAULT_BROWSER}.desktop"
fi

# Enable user systemd units
if hash systemctl 2>/dev/null; then
  # Low battery monitory
  if [ -n "$(./src/env/battery)" ]; then
    systemctl --user enable --now low-battery.timer
  fi

  # Backup timer
  if hash duplicacy 2>/dev/null; then
    systemctl --user enable --now duplicacy-backup.timer
  fi

  # SSH Agent
  systemctl --user enable --now ssh-agent.service
fi
