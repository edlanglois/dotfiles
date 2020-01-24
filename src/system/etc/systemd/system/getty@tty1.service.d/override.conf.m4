m4_include(env_config.m4)m4_dnl
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin m4_env_config_USER --noclear %I $TERM
Type=simple
