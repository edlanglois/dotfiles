#!/bin/sh
if hash imwheel &>/dev/null && ! ps cax | grep imwheel &>/dev/null; then
	imwheel
fi
