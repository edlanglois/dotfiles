#!/usr/bin/env bash
# Install Google Noto Fonts to local user
set -eux

FONTS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
DOWNLOADS_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
cd "$DOWNLOADS_DIR"
wget --no-clobber "https://noto-website-2.storage.googleapis.com/pkgs/Noto-hinted.zip"
wget --no-clobber "https://noto-website-2.storage.googleapis.com/pkgs/NotoSansMono-hinted.zip"
unzip Noto-hinted.zip -d noto
unzip NotoSansMono-hinted.zip -d noto
mkdir -p "$FONTS_DIR"
mv noto/*otf "$FONTS_DIR"
mv noto/*ttf "$FONTS_DIR"

# Generate the font configuration - Fonts must have been installed first.
if hash fc-cache 2>/dev/null; then
	fc-cache -vf "$FONTS_DIR"
fi
