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

m4_dnl XDG config directories.
m4_dnl No support for changing these currently (except cache)
m4_define(m4_xdg_config_home,??[[<<$HOME/.config>>]]??)m4_dnl
m4_define(m4_xdg_cache_home,??[[<<$HOME/.cache>>]]??)m4_dnl
m4_define(m4_xdg_data_home,??[[<<$HOME/.local/share>>]]??)m4_dnl

# Set editor to vim
export EDITOR=vim

m4_ifdef(??[[<<m4_env_config_BROWSER>>]]??,m4_dnl
# Set default browser
export BROWSER=m4_env_config_BROWSER)

# Set locale; also set in .config/locale.conf but that isn't always read.
LANG=m4_user_config_LANG.utf8
LANGUAGE=m4_user_config_LANGUAGE

# Add user local directories to environment paths
PATH="$(pathprepend_if_isdir "$PATH" "$HOME/bin")"
PATH="$(pathprepend_if_isdir "$PATH" "$HOME/.local/bin")"

LD_LIBRARY_PATH="$(pathprepend_if_isdir "$LD_LIBRARY_PATH" "$HOME/lib")"
LD_LIBRARY_PATH="$(pathprepend_if_isdir "$LD_LIBRARY_PATH" "$HOME/.local/lib")"

MANPATH="$(pathprepend_if_isdir "$(manpath -g)" "$HOME/man")"
MANPATH="$(pathprepend_if_isdir "$MANPATH" "$HOME/share/man")"
MANPATH="$(pathprepend_if_isdir "$MANPATH" "$HOME/.local/man")"
MANPATH="$(pathprepend_if_isdir "$MANPATH" "$HOME/.local/share/man")"

# OpenSSL Seed File (Defaults to $HOME/.rnd)
export RANDFILE="m4_xdg_cache_home/openssl/rnd"

# wget
export WGETRC="m4_xdg_config_home/wgetrc"

# tmux
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

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

m4_ifdef(??[[<<m4_env_config_MUJOCO_PATH>>]]??,m4_dnl
# Mujoco Library Path
LD_LIBRARY_PATH="$(pathappend_if_isdir "$LD_LIBRARY_PATH" "m4_env_config_MUJOCO_PATH/bin")"
export MUJOCO_PY_MUJOCO_PATH="m4_env_config_MUJOCO_PATH"
export MUJOCO_PY_MJKEY_PATH="m4_env_config_MJKEY_PATH"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_PYTHON>>]]??,m4_dnl
# Python Environment
export PYTHONSTARTUP="m4_xdg_config_home/python/startup.py"
export PYLINTRC="m4_xdg_config_home/pylint/config"
export PYLINTHOME="m4_xdg_cache_home/pylint"
export THEANORC="m4_xdg_config_home/theano/config"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_RUBY_GEM>>]]??,m4_dnl
# Ruby Gem Configuration Directories
export GEMRC="m4_xdg_config_home/gem/config.yaml"
export GEM_HOME="m4_xdg_data_home/gem"
export GEM_SPEC_CACHE="m4_xdg_cache_home/gem"
)m4_dnl
m4_ifdef(??[[<<m4_env_config_GEM_BIN_PATH>>]]??,m4_dnl
# Ruby Gem Paths
while IFS=: read -d: -r gempath; do
  PATH="$(pathappend_if_isdir "$PATH" "$gempath")"
done <<< "m4_env_config_GEM_BIN_PATH:"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_TASK>>]]??,m4_dnl
# Task configuration file
export TASKRC="m4_xdg_config_home/task/config"
)m4_dnl

# Vim Environment
export VIMINIT=":source m4_xdg_config_home/vim/vimrc"

export PATH
export LD_LIBRARY_PATH
export MANPATH
