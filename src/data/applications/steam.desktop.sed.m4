m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_GDK_SCALE>>]]??,m4_dnl
s#\(Exec *=\)\(.*steam-runtime\b\)#\1/usr/bin/env GDK_SCALE=m4_env_config_GDK_SCALE \2#
)m4_dnl
