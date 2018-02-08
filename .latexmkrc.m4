m4_include(env_config.m4)m4_dnl
m4_ifdef(??[[<<m4_env_config_DBLPBIB>>]]??,m4_dnl
$pdflatex = "dblpbib %S && pdflatex -synctex=1 --halt-on-error %O %S";)
