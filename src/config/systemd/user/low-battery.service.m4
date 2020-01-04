m4_include(env_config.m4)m4_dnl
[Unit]
Description=Notify or suspend on low battery

[Service]
ExecStart=/bin/bash "m4_env_config_LOCAL_PREFIX/bin/low-battery-action"
Type=oneshot
