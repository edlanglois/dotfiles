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

# PREFIX="$1"
# START_QUOTE="$2"
# END_QUOTE="$3"
# Used in a sed expression so escape the chracters: \ / &
PREFIX_SED=$(sed -e 's/[\/&]/\\&/g' <<< "$1")
START_QUOTE_SED=$(sed -e 's/[\/&]/\\&/g' <<< "$2")
END_QUOTE_SED=$(sed -e 's/[\/&]/\\&/g' <<< "$3")

# -t continues to the next line if the previous replace was successful
# -d deletes the line
# So this only prints matching comment or assignment lines
sed \
  -e 's/^\s*#/m4_dnl/' -e 't' \
  -e 's/\([^=]\+\)=\(.*\)/m4_define('"${PREFIX_SED}\\1,${START_QUOTE_SED}\\2${END_QUOTE_SED}"')m4_dnl/' -e 't' \
  -e 'd'
