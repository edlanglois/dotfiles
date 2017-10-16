function hostname-icon --description "Echo an icon hashed from the hostname."
	printf '\u26'(hostname | md5sum | cut -c -2)'\n'
end
