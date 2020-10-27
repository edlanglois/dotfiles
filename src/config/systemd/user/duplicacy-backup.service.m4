[Unit]
Description=Backup files using duplicacy.
# Don't restart more than 3 times in 2 hours
StartLimitIntervalSec=7200
StartLimitBurst=3

[Service]
ExecStart=duplicacy -log backup
Type=simple
RestartSec=10min
Restart=on-failure
