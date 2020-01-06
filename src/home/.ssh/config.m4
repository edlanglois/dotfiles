m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_GITHUB_ID>>]]??,
Host github.com
	IdentityFile m4_env_config_GITHUB_ID
)
m4_sinclude(src/home/.ssh/config.local)m4_dnl

Host *
	# Add keys to ssh-agent if it is running
	AddKeysToAgent yes
	# Roaming is/was an experimental feature to allow resuming ssh connections
	# but contained exploitable bugs.
	UseRoaming no
m4_ifdef(??[[<<m4_env_config_NETUSER>>]]??,m4_dnl
	# If HOME is network mounted then localhost in the same .ssh/known_hosts
	# can refer to different machines depending on which machine is being used.
	# So any saved key might disagree with the current host key when
	# authenticating.
	NoHostAuthenticationForLocalhost yes
)m4_dnl
