m4_include(env_config.m4)m4_dnl
envs_dirs:
  - "m4_env_config_XDG_DATA_HOME/conda/envs"
pkgs_dirs:
  - "m4_env_config_XDG_CACHE_HOME/conda/pkgs"
conda-build:
    root-dir: "m4_env_config_XDG_DATA_HOME/conda/builds"
