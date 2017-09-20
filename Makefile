SHELL=/bin/bash -o pipefail

M4_DOTFILES=\
	.bash_aliases\
	.bash_profile\
	.bashrc\
	.config/fish/config.fish\
	.config/fish/functions/fish_prompt.fish\
	.config/fish/functions/pbcopy.fish\
	.config/fish/functions/pbpaste.fish\
	.config/fish/functions/R.fish\
	.config/fish/functions/torch-activate.fish\
	.config/flake8\
	.config/i3/config\
	.config/i3blocks/config\
	.config/locale.conf\
	.config/termite/config\
	.gitconfig\
	.gitignore_global\
	.hgrc\
	.profile\
	.pylintrc\
	.Rprofile\
	.ssh/config\
	.theanorc\
	.tmux.conf\
	.toprc\
	.vimrc\
	.xbindkeysrc\
	.xinitrc\
	.Xmodmap\
	.xprofile\
	.Xresources\

DOTFILES=\
	$(M4_DOTFILES)\
	.config/fontconfig/conf.d/10-powerline-symbols.conf\
	.config/i3blocks/scripts/battery-label\
	.config/i3blocks/scripts/gpu-usage\
	.config/i3blocks/scripts/weather\
	.config/nvim\
	.config/xss-lock/transfer-sleep-lock-i3lock.sh\
	.fonts/PowerlineSymbols.otf\
	.tmuxline.conf\
	.virtualenvs/global_requirements.txt\
	bin/print256colours\
	bin/tmuxm\

DOTDIRS=\
	.vim

ENV_CONFIG_FILES=$(addprefix env/,\
	battery\
	browser\
	cuda\
	default-shell\
	dmenu\
	git-push-default-simple\
	github_id\
	gsimplecal\
	i3blocks\
	i3lock\
	icon\
	keychain\
	locale\
	nvidia-smi\
	osx\
	playerctl\
	pulseaudio\
	python\
	root\
	ruby\
	setxkbmap\
	terminal\
	tmux\
	torch\
	virtualfish\
	wifi\
	xbacklight\
	xbindkeys\
	xdotool\
	xinput\
	xmodmap\
	xss-lock\
)

DOTFILES_DIR=$(shell pwd)
INSTALL_DIR=$(HOME)
INSTALLED_DOTFILES=$(addprefix $(INSTALL_DIR)/,$(DOTFILES))
INSTALLED_DOTDIRS=$(addprefix $(INSTALL_DIR)/,$(DOTDIRS))
# Sort to remove duplicates
INSTALLATION_DIRS = $(sort $(dir $(INSTALLED_DOTFILES) $(INSTALLED_DOTDIRS)))

M4_CONFIG_GEN_FILES=$(M4_DOTFILES) Makefile-binaries
ENV_CONFIG_M4_FILES=$(addsuffix .m4,$(ENV_CONFIG_FILES))

INSTALLED_SYSTEM_FILES=$(shell find system/ -type f -printf "/%P\n")
INSTALLATION_DIRS += $(sort $(dir $(INSTALLED_SYSTEM_FILES)))

USER_CONFIG_PREFIX=m4_user_config_
ENV_CONFIG_PREFIX=m4_env_config_
# Hopefully unlikely to appear in the dotfiles.
QUOTE_START=??[[<<
QUOTE_END=>>]]??

WARNING_PREFIX=$(shell echo "$$(tput setaf 172)WARNING$$(tput sgr0):")

PYGMENTIZE:=$(shell command -v pygmentize)

.PHONY: build install install-dotfiles install-system install-all  \
	set-persistent-configs clean show show-config vim \
	vim-update-plugins vim-ycm

build: $(DOTFILES) Makefile-binaries

# Build Dotfiles
# --------------
# - Build each dotfile from the corresponding .m4 file, user_config.m4, and
#   env_config.m4.
# - Custom build for .tmuxline.conf
define M4_CONFIG_GEN_TEMPLATE
$1 : % : %.m4 $(wildcard $1.local) user_config.m4 env_config.m4
	echo "m4_changequote(${QUOTE_START},${QUOTE_END})m4_dnl" | \
		cat - $$< | \
		m4 --prefix-builtins > $$@
endef

$(foreach M4_CONFIG_GEN_FILE, $(M4_CONFIG_GEN_FILES), \
	$(eval $(call M4_CONFIG_GEN_TEMPLATE, $(M4_CONFIG_GEN_FILE))))

.config/xss-lock/transfer-sleep-lock-i3lock.sh : % : %.m4 $(wildcard %.local) user_config.m4 env_config.m4
	echo "m4_changequote(${QUOTE_START},${QUOTE_END})m4_dnl" | \
		cat - $< | \
		m4 --prefix-builtins > $@
	chmod u+x $@

.tmuxline.conf: .vimrc
ifdef TMUX
	rm -f $@
	vim -u ".vimrc" -c "TmuxlineSnapshot $@" -c "q"
	@if [ ! -f $@ ]; then \
		echo "$(WARNING_PREFIX) Unable to generate tmuxline snapshot. Install tmuxline vim plugin and remake."; \
		touch $@; \
	fi
else
	@echo "$(WARNING_PREFIX) Tmuxline config not generated. Re-run from within tmux."
	touch $@
endif

# Configuration Files
# -------------------
# - Build user_config.m4 from user.cfg
# - Build env/*.m4 from ENV_CONFIG_FILES
# - Build env_config.m4 from env/*.m4
user_config.m4: user.cfg config_replace.sh
	sed -e 's/\s*#.*$$//' -e '/^\s*$$/d' $< | \
		./config_replace.sh "${USER_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" > $@

env/%.m4: env/%
	$< | ./config_replace.sh "${ENV_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" | (echo "m4_dnl $<" && cat) > $@

env_config.m4: $(ENV_CONFIG_M4_FILES)
	cat $^ > $@

# Install Dotfiles & Dotdirs
# --------------------------
# - Copy dotfiles into INSTALL_DIR
# - Symbolic link dotdirs into INSTALL_DIR
install: install-dotfiles

set-persistent-configs: $(INSTALL_DIR)/.fonts/PowerlineSymbols.otf
	./set-persistent-configs.sh

install-dotfiles: $(INSTALLED_DOTFILES) $(INSTALLED_DOTDIRS)

define INSTALL_DOTFILE_TEMPLATE
$1 : $(INSTALL_DIR)/% : % | $(dir $1)
	@cp -Rdv "$$<" "$$@"
endef

$(foreach INSTALLED_DOTFILE, $(INSTALLED_DOTFILES), \
	$(eval $(call INSTALL_DOTFILE_TEMPLATE, $(INSTALLED_DOTFILE))))

define INSTALL_DOTDIR_TEMPLATE
$1 : $(INSTALL_DIR)/% : | %
	ln -s "$(DOTFILES_DIR)/$$|" "$$@"
endef

$(foreach INSTALLED_DOTDIR, $(INSTALLED_DOTDIRS), \
	$(eval $(call INSTALL_DOTDIR_TEMPLATE, $(INSTALLED_DOTDIR))))


$(INSTALLATION_DIRS):
	mkdir -p $@

# Install system files
install-all: install install-system
install-system: $(INSTALLED_SYSTEM_FILES)

define INSTALL_SYSTEM_FILE_TEMPLATE
$1 : /% : system/% | $(dir $1)
	cp --interactive "$$<" "$$@"
endef

$(foreach INSTALLED_SYSTEM_FILE, $(INSTALLED_SYSTEM_FILES), \
	$(eval $(call INSTALL_SYSTEM_FILE_TEMPLATE, $(INSTALLED_SYSTEM_FILE))))

# Clean
# -----
# - Delete all the build products.
clean:
	rm -f user_config.m4 env_config.m4
	rm -f Makefile-binaries
	rm -f $(M4_DOTFILES) .tmuxline.conf
	rm -f .config/xss-lock/transfer-sleep-lock-i3lock.sh
	rm -f $(ENV_CONFIG_M4_FILES)

ifdef PYGMENTIZE
COLORIZE_CONFIG:=pygmentize -l 'cfg'
else
COLORIZE_CONFIG:=cat
endif

ESCAPED_QUOTE_START=$(subst [,\[,$(subst ],\],$(QUOTE_START)))
ESCAPED_QUOTE_END=$(subst [,\[,$(subst ],\],$(QUOTE_END)))

# Show Configuration
show: show-config
show-config: user.cfg env_config.m4
ifndef PYGMENTIZE
	@echo "Install pygmentize (python pygments) to view coloured output."
	@echo
endif
	@echo '# User Config' | cat - user.cfg | $(COLORIZE_CONFIG)
	@echo
	@echo '# Environment Config' | cat - env_config.m4 | \
		sed -e "s/^m4_dnl/#/" | \
		sed -e "s/$(ESCAPED_QUOTE_START)//g" | \
		sed -e "s/$(ESCAPED_QUOTE_END)//g" | \
		sed -e "s/^m4_define(m4_env_config_//" | \
		sed -e "s/)m4_dnl$$//" | \
		sed -e "s/,/=/" | \
		$(COLORIZE_CONFIG)

# Update Build vim plugins
vim: vim-update-plugins vim-ycm

vim-update-plugins:
	vim +PluginInstall +PluginUpdate +qall

vim-ycm:
	cd .vim/bundle/YouCompleteMe && \
		./install.py --clang-completer
