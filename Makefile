SHELL=/bin/bash -o pipefail

M4_DOTFILES=\
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
	.vimrc\

DOTFILES=$(M4_DOTFILES) .tmuxline.conf

DOTDIRS=\
	.vim

ENV_CONFIG_FILES=$(addprefix env/,\
	default-shell\
	git-push-default-simple\
	keychain\
	locale\
	osx\
	python\
	root\
	ruby\
	torch\
	virtualfish\
)

DOTFILES_DIR=$(shell pwd)
INSTALL_DIR=$(HOME)
INSTALLED_DOTFILES=$(addprefix $(INSTALL_DIR)/,$(DOTFILES))
INSTALLED_DOTDIRS=$(addprefix $(INSTALL_DIR)/,$(DOTDIRS))

M4_CONFIG_GEN_FILES=$(M4_DOTFILES) Makefile-binaries
ENV_CONFIG_M4_FILES=$(addsuffix .m4,$(ENV_CONFIG_FILES))

USER_CONFIG_PREFIX=m4_user_config_
ENV_CONFIG_PREFIX=m4_env_config_
# Hopefully unlikely to appear in the dotfiles.
QUOTE_START=??[[<<
QUOTE_END=>>]]??

.PHONY: build

build: $(DOTFILES) Makefile-binaries

# Build Dotfiles
# --------------
# - Build each dotfile from the corresponding .m4 file, user_config.m4, and
#   env_config.m4.
# - Custom build for .tmuxline.conf
define M4_CONFIG_GEN_TEMPLATE
$1 : % : %.m4 user_config.m4 env_config.m4
	echo "m4_changequote(${QUOTE_START},${QUOTE_END})m4_dnl" | \
		cat - $$< | \
		m4 --prefix-builtins > $$@
endef

$(foreach M4_CONFIG_GEN_FILE, $(M4_CONFIG_GEN_FILES), \
	$(eval $(call M4_CONFIG_GEN_TEMPLATE, $(M4_CONFIG_GEN_FILE))))

.tmuxline.conf: .vimrc
	rm -f $@
	vim -u ".vimrc" -c "TmuxlineSnapshot $@" -c "q"
	@if [ ! -f $@ ]; then \
		echo $$(tput setaf 1)WARNING$$(tput sgr0): Unable to generate tmuxline snapshot. Install tmuxline vim plugin and remake.;\
		touch $@;\
	fi

# Configuration Files
# -------------------
# - Build user_config.m4 from user.cfg
# - Build env/*.m4 from ENV_CONFIG_FILES
# - Build env_config.m4 from env/*.m4
user_config.m4: user.cfg config_replace.sh
	./config_replace.sh "${USER_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" < $< > $@

env/%.m4: env/%
	$< | ./config_replace.sh "${ENV_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" > $@

env_config.m4: $(ENV_CONFIG_M4_FILES)
	cat $^ > $@

# Install Dotfiles & Dotdirs
# --------------------------
# - Copy dotfiles into INSTALL_DIR
# - Symbolic link dotdirs into INSTALL_DIR
install: $(INSTALLED_DOTFILES) $(INSTALLED_DOTDIRS)

define INSTALL_DOTFILE_TEMPLATE
$1 : $(INSTALL_DIR)/% : %
	@cp -v "$$<" "$$@"
endef

$(foreach INSTALLED_DOTFILE, $(INSTALLED_DOTFILES), \
	$(eval $(call INSTALL_DOTFILE_TEMPLATE, $(INSTALLED_DOTFILE))))

define INSTALL_DOTDIR_TEMPLATE
$1 : $(INSTALL_DIR)/% : | %
	ln -s "$(DOTFILES_DIR)/$$|" "$$@"
endef

$(foreach INSTALLED_DOTDIR, $(INSTALLED_DOTDIRS), \
	$(eval $(call INSTALL_DOTDIR_TEMPLATE, $(INSTALLED_DOTDIR))))

# Clean
# -----
# - Delete all the build products.
clean:
	rm -f user_config.m4 env_config.m4
	rm -f Makefile-binaries
	rm -f $(DOTFILES)
	rm -f $(ENV_CONFIG_M4_FILES)
