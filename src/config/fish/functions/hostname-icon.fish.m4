function hostname-icon --description "Echo an icon hashed from the hostname."
	set -q XDG_CONFIG_HOME; or set -l XDG_CONFIG_HOME "$HOME/.config"
	set -l _HOSTNAME_ICON_FILE "$XDG_CONFIG_HOME/hostname-icon"
	if [ -f "$_HOSTNAME_ICON_FILE" ]
		cat "$_HOSTNAME_ICON_FILE"
	else
		printf '\u26'(hostname | md5sum | cut -c -2)'\n'
	end
end
