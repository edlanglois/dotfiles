m4_include(env_config.m4)m4_dnl
[global]
m4_ifdef(??[[<<m4_env_config_CUDA_ROOT>>]]??,
device = cuda
floatX = float32

[cuda]
root = m4_env_config_CUDA_ROOT
)m4_dnl
