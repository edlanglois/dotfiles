[Unit]
Description=Backup files using duplicacy.

[Service]
ExecStart=duplicacy -log backup
Type=simple
RestartSec=10min
Restart=on-failure
