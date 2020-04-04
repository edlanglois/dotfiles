[Unit]
Description=Regular duplicacy backups.

[Timer]
OnCalendar=daily
AccuracySec=10min
RandomizedDelaySec=1h
Persistent=true

[Install]
WantedBy=timers.target
