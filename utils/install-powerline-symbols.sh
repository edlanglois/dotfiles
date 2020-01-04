#!/usr/bin/env bash
# Install powerline symbols to local user
set -eux

FONTS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
mkdir -p "$FONTS_DIR"
cd "$FONTS_DIR"
wget "https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf"

if hash fc-cache 2>/dev/null; then
	fc-cache -vf "$FONTS_DIR"
fi
