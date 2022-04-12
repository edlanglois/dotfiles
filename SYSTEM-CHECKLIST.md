# System Files to Update

## Auto-login
Install `/etc/systemd/system/getty@tty1.service.d/override.conf`
(in `src/system`)
https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console

## `/etc/sudoers`
Use `visudo` for extra safety. Add your user to the `wheel` group and uncomment
```
%wheel ALL=(ALL) ALL
```

## `/etc/login.defs`
```
FAIL_DELAY 1
```
Also consider editing `/etc/security/faillock.conf`.

## `/etc/nsswitch.conf`
For hostname.local DNS on LAN, install `avahi` and add `mdns` to line
```
hosts: files mymachines myhostname mdns resolve [!UNAVAIL=return] dns
```

## `/etc/makepkg.conf`
```
PACKAGER="First Last <email@example.com>"
```

## `/etc/conf.d/wireless-regdom`
From `crda` package. Uncomment country code.

## `/etc/ssh/sshd_config`
If running an ssh server.
```
PermitRootLogin no
PasswordAuthentication no
```

## `/etc/pulse/daemon.conf`
Remove delay when changing volume:
```
enable-deferred-volume = no
```

## `/etc/ImageMagick-7/policy.xml`
To work with trusted pdfs, comment out the line:
```
  <!-- <policy domain="delegate" rights="none" pattern="gs" /> -->
```
https://wiki.archlinux.org/title/ImageMagick

## Paccache
Regularly removes old cached package files
```
systemctl enable --now paccache.timer
```
