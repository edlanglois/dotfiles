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

# Set editor to vim
export EDITOR=vim

m4_ifdef(??[[<<m4_env_config_VIMPAGER>>]]??,m4_dnl
export PAGER=vimpager)

m4_ifdef(??[[<<m4_env_config_LANG>>]]??,m4_dnl
# Set locale; also set in .config/locale.conf but that isn't always read.
LANG=m4_env_config_LANG
LANGUAGE=m4_env_config_LANGUAGE)

# set PATH so it includes user's local bin & lib directories
PATH="$(pathprepend_if_isdir "$PATH" "$HOME/.local/bin")"
PATH="$(pathprepend_if_isdir "$PATH" "$HOME/bin")"
LD_LIBRARY_PATH="$(pathprepend_if_isdir "$LD_LIBRARY_PATH" "$HOME/.local/lib")"
LD_LIBRARY_PATH="$(pathprepend_if_isdir "$LD_LIBRARY_PATH" "$HOME/lib")"

m4_ifdef(??[[<<m4_env_config_CUDA_ROOT>>]]??,m4_dnl
# CUDA Path
export CUDA_HOME="m4_env_config_CUDA_ROOT"
LD_LIBRARY_PATH="$(pathappend_if_isdir "$LD_LIBRARY_PATH" "$CUDA_HOME/lib64")"
LD_LIBRARY_PATH="$(pathappend_if_isdir "$LD_LIBRARY_PATH" "$CUDA_HOME/extras/CUPTI/lib64")"
)m4_dnl
m4_ifdef(??[[<<m4_env_config_CUDA_BIN>>]]??,m4_dnl
PATH="$(pathappend_if_isdir "$PATH" "m4_env_config_CUDA_BIN")"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_GOROOT>>]]??,m4_dnl
# Go Path
export GOROOT="m4_env_config_GOROOT"
PATH="$(pathappend_if_isdir "$PATH" "$GOROOT/bin")"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_GEM_BIN_PATH>>]]??,m4_dnl
# Ruby Path
PATH="$(pathappend_if_isdir "$PATH" "m4_env_config_GEM_BIN_PATH")"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_BREW_BIN_PATH>>]]??,m4_dnl
# Homebrew Path
PATH="$(pathappend_if_isdir "$PATH" "m4_env_config_BREW_BIN_PATH")"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_PERL_ROOT>>]]??,m4_dnl
# Perl Path
PATH="$(pathappend_if_isdir "$PATH" "m4_env_config_PERL_ROOT/bin")"
export PERL5LIB="$(pathappend_if_isdir "$PERL5LIB" "m4_env_config_PERL_ROOT/lib/perl5")"
export PERL_LOCAL_LIB_ROOT="$(pathappend_if_isdir "$PERL_LOCAL_LIB_ROOT" "m4_env_config_PERL_ROOT")"
export PERL_MB_OPT="--install_base \"m4_env_config_PERL_ROOT\""
export PERL_MM_OPT="INSTALL_BASE=m4_env_config_PERL_ROOT"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_MUJOCO_LIB>>]]??,m4_dnl
# Mujoco Library Path
LD_LIBRARY_PATH="$(pathappend_if_isdir "$LD_LIBRARY_PATH" "m4_env_config_MUJOCO_LIB")"
)m4_dnl

export PATH
export LD_LIBRARY_PATH
