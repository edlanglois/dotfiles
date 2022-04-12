m4_include(env_config.m4)m4_dnl
[build]
rustflags = ["-C", "target-cpu=native"]
target-dir = "m4_env_config_XDG_CACHE_HOME/cargo/target"
