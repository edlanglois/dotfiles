m4_include(env_config.m4)m4_dnl
m4_ifdef({<<m4_env_config_GDK_SCALE>>},m4_dnl
s#^\(Exec *=\)\(.*spotify\b\)#\1/usr/bin/env \2 --force-device-scale-factor=m4_env_config_GDK_SCALE#
)m4_dnl
