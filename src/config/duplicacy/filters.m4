m4_dnl TODO: Try to support m4_env_config_XDG_(DATA|CACHE)_HOME
m4_dnl The problem is that these filters need to be relative to $HOME
-.cache/
-Private/
-Dropbox/
-.dropbox/logs/

# The following patterns come from Chromium-based / Electron programs
-.config/*/Cache/
-.config/*/GPUCache/
-.config/*/Code Cache/
-.local/share/*/Cache/
-.local/share/*/GPUCache/
-.local/share/*/Code Cache/

# Slack
-.local/share/*/CacheStorage/
