#!/usr/bin/env bash
# Install powerline symbols to local user
set -eux

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget "https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf"

if hash fc-cache 2>/dev/null; then
	fc-cache -vf ~/.local/share/fonts
fi
