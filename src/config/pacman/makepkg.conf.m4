m4_include(env_config.m4)m4_dnl
m4_include(user_config.m4)m4_dnl
PACKAGER="m4_user_config_NAME <m4_user_config_EMAIL>"

MAKEFLAGS="-j??[[<<>>]]??m4_env_config_NUM_CPU_CORES"
