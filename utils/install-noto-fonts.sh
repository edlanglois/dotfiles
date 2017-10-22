#!/usr/bin/env bash
# Install Google Noto Fonts to local user
set -eux

cd ~/Downloads
wget --no-clobber https://noto-website.storage.googleapis.com/pkgs/Noto-hinted.zip
unzip Noto-hinted.zip -d noto
cp noto/*otf ~/.fonts

# Generate the font configuration - Fonts must have been installed first.
if hash fc-cache 2>/dev/null; then
	fc-cache -vf ~/.fonts
fi
