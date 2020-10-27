m4_include(env_config.m4)m4_dnl
[Unit]
Description=Prune duplicacy backups.
# Don't restart more than 3 times in 2 hours
StartLimitIntervalSec=7200
StartLimitBurst=3

[Service]
# Prune old snapshots
# Keep 1 snapshot every 360 day(s) if older than 360 day(s)
# Keep 1 snapshot every 30 day(s) if older than 180 day(s)
# Keep 1 snapshot every 7 day(s) if older than 30 day(s)
# Keep 1 snapshot every 1 day(s) if older than 7 day(s)
ExecStart=duplicacy -log prune --keep 360:360 -keep 30:180 -keep 7:30 -keep 1:7 
Type=simple
