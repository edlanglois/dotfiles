m4_dnl Dynamic variable assignments
m4_dnl Use src/config/security/pam_env.conf.m4 for static assignments.
#!/usr/bin/sh
m4_include(user_config.m4)
m4_include(env_config.m4)
# Set environment variables

pathprepend() {
  # Usage: pathprepend $PATH /path/to/add
  # Update a PATH-like colon-separated variable by prepending a new value if not
  # already present.
  local value="$2"
  local paths="${1:-$value}"
  case ":$paths:" in
    *:$value:*)
      echo "$paths";;
    *)
      echo "$value:$paths";;
  esac
}

pathprepend_if_isdir() {
  # Same as pathprepend but checks that the value to add exists as a directory.
  if [ -d "$2" ]; then
    pathprepend "$@"
  else
    echo "$1"
  fi
}

pathappend() {
  # Usage: pathappend $PATH /path/to/add
  # Update a PATH-like colon-separated variable by appending a new value if not
  # already present.
  local value="$2"
  local paths="${1:-$value}"
  case ":$paths:" in
    *:$value:*)
      echo "$paths";;
    *)
      echo "$paths:$value";;
  esac
}

pathappend_if_isdir() {
  # Same as pathappend but checks that the value to add exists as a directory.
  if [ -d "$2" ]; then
    pathappend "$@"
  else
    echo "$1"
  fi
}

# Not exported; Not quoted to allow ~ expansion
LOCAL_PREFIX_=m4_user_config_LOCAL_PREFIX

# XDG_RUNTIME_DIR is supposed to be set automatically but sometimes it is not.
# Set it manually if the standard directory exists
if [ -z "$XDG_RUNTIME_DIR" ]; then
	BACKUP_RUNTIME_DIR="/run/user/$(id -u)"
	if [ -d "$BACKUP_RUNTIME_DIR" ]; then
		echo "XDG_RUNTIME_DIR unset. Setting to '$BACKUP_RUNTIME_DIR'"
		export XDG_RUNTIME_DIR="$BACKUP_RUNTIME_DIR"
	fi
fi

# Add user local directories to environment paths
PATH="$(pathprepend_if_isdir "$PATH" "$LOCAL_PREFIX_/bin")"

MANPATH="$(pathprepend_if_isdir "$MANPATH" "$LOCAL_PREFIX_/man")"
MANPATH="$(pathprepend_if_isdir "$MANPATH" "$LOCAL_PREFIX_/share/man")"

# ==== TROUBLESHOOTING: CAN CAUSE GUI LOGIN TO FAIL  ====
# Set XAUTHORITY to avoid the creation of an .Xauthority file.
# Setting XAUTHORITY causes login to fail with some login managers.
# In that case, the user is returned to the login screen after trying to log in.
# Avoid setting XAUTHORITY if any of the following login managers are installed.
# Also do not set XAUTHORITY if it is already set to a value that does not end
# in .Xauthority
if \
	! command -v lightdm > /dev/null && \
	! command -v gdm > /dev/null && \
	! command -v gdm3 > /dev/null && \
	[ -z "$XAUTHORITY" -o "$(basename "$XAUTHORITY")" = .Xauthority ]
then
	export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
fi

m4_ifdef({<<m4_env_config_XLSCLIENTS>>},m4_dnl
# Check if a standard display server exists that we can connect to.
# This is useful for ssh + remote desktop
# allowing the SSH terminals to access the remote desktop display.
if [ -z "$DISPLAY" ]; then
	for i in  {0..9}; do
		if m4_env_config_XLSCLIENTS -display ":$i" >/dev/null 2>&1; then
			export DISPLAY=":$i"
			break
		fi
	done
fi
)m4_dnl

# Browser
if [ -n "$DISPLAY" ]; then
m4_ifdef({<<m4_env_config_BROWSER>>},m4_dnl
	export BROWSER="m4_env_config_BROWSER",
	true)
else
m4_ifdef({<<m4_env_config_TERMINAL_BROWSER>>},m4_dnl
	export BROWSER="m4_env_config_TERMINAL_BROWSER",
	true)
fi

m4_ifdef({<<m4_env_config_CUDA_ROOT>>},m4_dnl
# CUDA Path
PATH="$(pathprepend_if_isdir "$PATH" "m4_env_config_CUDA_ROOT/bin")"
LD_LIBRARY_PATH="$(pathprepend_if_isdir "$LD_LIBRARY_PATH" "m4_env_config_CUDA_ROOT/lib64")"
)m4_dnl

m4_ifdef({<<m4_env_config_BREW_BIN_PATH>>},m4_dnl
# Homebrew Path
PATH="$(pathappend_if_isdir "$PATH" "m4_env_config_BREW_BIN_PATH")"
)m4_dnl

m4_ifdef({<<m4_env_config_GOROOT>>},m4_dnl
# Go Path
export GOROOT="m4_env_config_GOROOT"
PATH="$(pathappend_if_isdir "$PATH" "$GOROOT/bin")"
)m4_dnl

m4_ifdef({<<m4_env_config_MUJOCO_PATH>>},m4_dnl
# Mujoco Library Path
LD_LIBRARY_PATH="$(pathappend_if_isdir "$LD_LIBRARY_PATH" "m4_env_config_MUJOCO_PATH/bin")"
export MUJOCO_PY_MUJOCO_PATH="m4_env_config_MUJOCO_PATH"
export MUJOCO_PY_MJKEY_PATH="m4_env_config_MJKEY_PATH"
)m4_dnl

m4_ifdef({<<m4_env_config_PERL_ROOT>>},m4_dnl
# Perl Path
PATH="$(pathappend_if_isdir "$PATH" "m4_env_config_PERL_ROOT/bin")"
export PERL5LIB="$(pathappend_if_isdir "$PERL5LIB" "m4_env_config_PERL_ROOT/lib/perl5")"
export PERL_LOCAL_LIB_ROOT="$(pathappend_if_isdir "$PERL_LOCAL_LIB_ROOT" "m4_env_config_PERL_ROOT")"
export PERL_MB_OPT="--install_base \"m4_env_config_PERL_ROOT\""
export PERL_MM_OPT="INSTALL_BASE=m4_env_config_PERL_ROOT"
)m4_dnl

m4_ifdef({<<m4_env_config_GEM_BIN_PATH>>},m4_dnl
# Ruby Gem Paths
while IFS=: read -d: -r gempath; do
  PATH="$(pathappend_if_isdir "$PATH" "$gempath")"
done <<< "m4_env_config_GEM_BIN_PATH:"
)m4_dnl

m4_ifdef({<<m4_env_config_CARGO_BIN>>},m4_dnl
# Binaries managed by cargo / rustup
PATH="$(pathprepend_if_isdir "$PATH" "m4_env_config_CARGO_BIN")"
)m4_dnl

export PATH
export LD_LIBRARY_PATH
# Make sure that MANPATH (if non-empty) ends in a ':' so that the system
# paths are searched as well
MANPATH="$(pathappend "$MANPATH" "")"
export MANPATH
