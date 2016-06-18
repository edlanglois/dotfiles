m4_include(env_config.m4)m4_dnl
#!/usr/bin/env bash
set -eu
if [[ $(m4_env_config_I3BLOCKS_DIR/battery | head -n 1) =~ .*DIS.* ]]; then
	echo 🔋
	echo 🔋
else
	echo 🔌
	echo 🔌
fi
