[Unit]
Description=Regular duplicacy backup pruning.

[Timer]
OnCalendar=weekly
AccuracySec=10min
RandomizedDelaySec=2h
Persistent=true

[Install]
WantedBy=timers.target
