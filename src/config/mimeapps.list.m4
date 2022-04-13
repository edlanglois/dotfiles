m4_include(env_config.m4)m4_dnl
[Default Applications]
m4_ifdef({<<m4_env_config_BROWSER_APP>>},m4_dnl
text/html=m4_env_config_BROWSER_APP
x-scheme-handler/http=m4_env_config_BROWSER_APP
x-scheme-handler/https=m4_env_config_BROWSER_APP
x-scheme-handler/webcal=m4_env_config_BROWSER_APP
)m4_dnl
m4_ifdef({<<m4_env_config_PDF_READER_APP>>},m4_dnl
application/pdf=m4_env_config_PDF_READER_APP
)m4_dnl
