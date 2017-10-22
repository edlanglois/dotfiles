#!/bin/bash
set -eu

print_usage() {
	echo "Usage: $0 [-h] PREFIX START_QUOTE END_QUOTE"
}

print_help() {
	print_usage
	echo ""
	echo "Turns NAME=VALUE definitions into a list of m4 macro definitions."
	echo ""
	echo "  PREFIX        Prepended to the names of the m4 macros."
	echo "  START_QUOTE   m4 start-quote sequence."
	echo "  END_QUOTE     m4 end-quote sequence."
}

if [ "$#" -gt 0 ] && [ "$1" == '-h' ]; then
	print_help
	exit 0
fi

if [ "$#" -ne 3 ]; then
	print_usage
	exit 1
fi

PREFIX="$1"
START_QUOTE="$2"
END_QUOTE="$3"

while IFS='=' read -r NAME VALUE; do
	echo "m4_define(${PREFIX}${NAME},${START_QUOTE}${VALUE}${END_QUOTE})m4_dnl"
done
