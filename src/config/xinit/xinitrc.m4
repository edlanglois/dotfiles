m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
#!/bin/sh

m4_ifdef({<<m4_env_config_SYSTEMCTL>>},m4_dnl
systemctl --no-block --user start xsession.target)

userresources=m4_user_config_XDG_CONFIG_HOME/xinit/Xresources
usermodmap=m4_user_config_XDG_CONFIG_HOME/xinit/Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
userprofile=~/.xprofile

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -f $userprofile ]; then
	. $userprofile
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

m4_ifdef({<<m4_env_config_I3>>},m4_dnl
exec m4_env_config_I3)
