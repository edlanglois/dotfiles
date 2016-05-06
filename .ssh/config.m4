m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_GITHUB_ID>>]]??,
Host github.com
	IdentityFile m4_env_config_GITHUB_ID
)
Host *
	KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
	PubkeyAuthentication yes
	Protocol 2
	HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa
