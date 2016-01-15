m4_include(env_config.m4)m4_dnl
function torch-activate --description "Set environment variables to activate torch."
m4_ifdef(??[[<<m4_env_config_TORCH_ACTIVATE>>]]??,m4_dnl
??[[<<m4_dnl
	# Source torch-activate. Sets environment variables for running torch (th).
	# torch-activate sets environment variables in the BASH style.
	# Translate for fish:
	#   1. Change "export NAME=..." to "set -x NAME ..."
	#   2. Change : (path separator) to space (list elements).
	#   3. Change PATH to fish_user_paths. Temporarily add a space to end of each
	#      line to help capturing PATH as a standalone word.
	#
	# Regex is simple so that it is portable. No +, no |, no word boundary markers.
	cat "m4_env_config_TORCH_ACTIVATE" | \
		sed 's/^export *\([^=][^=]*\)=/set -x \1 /' | \
		sed 's/:/ /g' | \
		sed 's/$/ /' | sed 's/\([ $]\)PATH /\1fish_user_paths /g' | sed 's/ $//' | \
		source>>]]??,
??[[<<m4_dnl
	echo "Could not find torch-activate script."
	return 1>>]]??)
end
