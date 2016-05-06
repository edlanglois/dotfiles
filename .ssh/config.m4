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
	Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
	MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160,umac-128@openssh.com
	UseRoaming no
