m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_OSX>>]]??,,m4_dnl
function cpaste --description "Paste from clipboard"
	xsel --clipboard --output
end
)m4_dnl
