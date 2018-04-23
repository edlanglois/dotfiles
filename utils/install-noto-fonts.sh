#!/usr/bin/env bash
# Install Google Noto Fonts to local user
set -eux

cd ~/Downloads
wget --no-clobber "https://noto-website-2.storage.googleapis.com/pkgs/Noto-hinted.zip"
wget --no-clobber "https://noto-website-2.storage.googleapis.com/pkgs/NotoSansMono-hinted.zip"
unzip Noto-hinted.zip -d noto
unzip NotoSansMono-hinted.zip -d noto
mkdir -p ~/.local/share/fonts
mv noto/*otf ~/.local/share/fonts
mv noto/*ttf ~/.local/share/fonts

# Generate the font configuration - Fonts must have been installed first.
if hash fc-cache 2>/dev/null; then
	fc-cache -vf ~/.local/share/fonts
fi
