#!/usr/bin/env bash
# Download powerline files into this repository
# https://powerline.readthedocs.io/en/latest/installation/linux.html#fontconfig
set -eu
cd -P "$(dirname -- "$0")/.."

VERSION=2.8.3
URL="https://github.com/powerline/powerline/raw/$VERSION"
wget "$URL/font/PowerlineSymbols.otf" -O src/data/fonts/PowerlineSymbols.otf
wget "$URL/font/10-powerline-symbols.conf" \
	-O src/config/fontconfig/conf.d/10-powerline-symbols.conf
wget "$URL/LICENSE" -O licenses/powerline-LICENSE
