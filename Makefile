DOTFILES=\
	.Rprofile\
	.bash_aliases\
	.bash_profile\
	.bashrc\
	.config/fish/config.fish\
	.config/fish/functions/R.fish\
	.config/fish/functions/fish_prompt.fish\
	.config/flake8\
	.gitconfig\
	.gitignore_global\
	.hgrc\
	.profile\
	.pylintrc\
	.tmux.conf\
	.tmuxline.conf\
	.vimrc\

M4_CONFIG_GEN_FILES=$(DOTFILES) Makefile-binaries

USER_CONFIG_PREFIX=m4_user_config_
# Hopefully unlikely to appear in the dotfiles.
QUOTE_START=??[[<<
QUOTE_END=>>]]??

.PHONY: build

build: $(DOTFILES) Makefile-binaries

define M4_CONFIG_GEN_TEMPLATE
$1 : % : %.m4 user_config.m4
	echo "m4_changequote(${QUOTE_START},${QUOTE_END})m4_dnl" | \
		cat - $$< | \
		m4 --prefix-builtins > $$@
endef

$(foreach M4_CONFIG_GEN_FILE, $(M4_CONFIG_GEN_FILES), \
	$(eval $(call M4_CONFIG_GEN_TEMPLATE, $(M4_CONFIG_GEN_FILE))))

user_config.m4: user.cfg config_replace.sh
	./config_replace.sh "${USER_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" < $< > $@

clean:
	rm -f user_config.m4
	rm -f $(DOTFILES)
	rm -f Makefile-binaries
