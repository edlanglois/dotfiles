function hostname-icon --description "Echo an icon hashed from the hostname."
	set -q XDG_CONFIG_HOME; or set -l XDG_CONFIG_HOME "$HOME/.config"
	set -l _HOSTNAME_ICON_FILE "$XDG_CONFIG_HOME/hostname-icon"
	if [ -f "$_HOSTNAME_ICON_FILE" ]
		cat "$_HOSTNAME_ICON_FILE"
		return
	end

	if type -q hostname
		set _HOSTNAME (hostname)
	else if [ -f "/proc/sys/kernel/hostname" ]
		set _HOSTNAME (head -1 /proc/sys/kernel/hostname)
	else if type -q hostnamectl
		set _HOSTNAME (hostnamectl --static)
	else
		return
	end
	printf '\u26'(echo "$_HOSTNAME" | md5sum | cut -c -2)'\n'
end
