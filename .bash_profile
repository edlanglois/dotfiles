#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

eval $(keychain --eval --agents ssh -Q --quiet id_rsa)
