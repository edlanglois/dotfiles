#
# ~/.bash_profile
#
if [[ -f ~/.profile ]]; then
	source ~/.profile;
elif [[ -f ~/.bashrc ]]; then
	source ~/.bashrc;
fi

eval $(keychain --eval --agents ssh -Q --quiet id_rsa)
