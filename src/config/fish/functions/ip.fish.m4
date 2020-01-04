m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_IP_CMD>>]]??,??[[<<m4_dnl
function ip --description "Show / manipulate routing, devices, policy routing and tunnels"
  m4_env_config_IP_CMD -c $argv
end
>>]]??)m4_dnl
