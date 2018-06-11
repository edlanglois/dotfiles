m4_include(env_config.m4)
# Set environment variables

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# same for LD_LIBRARY_PATH
if [ -d "$HOME/.local/lib" ] ; then
	export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
fi
if [ -d "$HOME/lib" ] ; then
	export LD_LIBRARY_PATH="$HOME/lib:$LD_LIBRARY_PATH"
fi

m4_ifdef(??[[<<m4_env_config_CUDA_ROOT>>]]??,
# CUDA Path
export CUDA_HOME="m4_env_config_CUDA_ROOT"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$CUDA_HOME/lib64"
CUPTI_LIB="$CUDA_HOME/extras/CUPTI/lib64"
if [ -d "$CUPTI_LIB" ] ; then
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$CUPTI_LIB"
fi
)m4_dnl
m4_ifdef(??[[<<m4_env_config_CUDA_BIN>>]]??,
PATH="${PATH}:m4_env_config_CUDA_BIN"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_GOROOT>>]]??,
# Go Path
export GOROOT="m4_env_config_GOROOT"
PATH="${PATH}:${GOROOT}/bin"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_GEM_BIN_PATH>>]]??,
# Ruby Path
PATH="${PATH}:m4_env_config_GEM_BIN_PATH"
)m4_dnl

m4_ifdef(??[[<<m4_env_config_BREW_BIN_PATH>>]]??,
PATH=$PATH:m4_env_config_BREW_BIN_PATH
)m4_dnl

m4_ifdef(??[[<<m4_env_config_MUJOCO_LIB>>]]??,
# Mujoco Library Path
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:m4_env_config_MUJOCO_LIB"
)m4_dnl
