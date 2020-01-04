m4_include(env_config.m4)m4_dnl
[Unit]
Description=Run a duplicacy backup.

[Service]
ExecStart=/bin/bash "m4_env_config_LOCAL_PREFIX/bin/duplicacy-backup" "%h"
Type=simple
RestartSec=10min
Restart=on-failure
