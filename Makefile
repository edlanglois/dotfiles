SHELL=/bin/bash -o pipefail

M4_DOTFILES=\
	.bash_aliases\
	.bash_profile\
	.bashrc\
	.config/fish/config.fish\
	.config/fish/functions/fish_prompt.fish\
	.config/fish/functions/hostname-icon.fish\
	.config/fish/functions/ip.fish\
	.config/fish/functions/pbcopy.fish\
	.config/fish/functions/pbpaste.fish\
	.config/fish/functions/R.fish\
	.config/fish/functions/torch-activate.fish\
	.config/flake8\
	.config/i3/config\
	.config/i3blocks/config\
	.config/locale.conf\
	.config/matplotlib/matplotlibrc\
	.config/terminator/config\
	.config/termite/config\
	.config/user-dirs.dirs\
	.config/yapf/style\
	.env_profile\
	.gitconfig\
	.gitignore_global\
	.hgrc\
	.isort.cfg\
	.latexmkrc\
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

SYSTEMD_FILES=\
	.config/systemd/user/low-battery.service\
	.config/systemd/user/low-battery.timer\

DOTFILES=\
	$(M4_DOTFILES)\
	$(SYSTEMD_FILES)\
	.config/fontconfig/conf.d/10-powerline-symbols.conf\
	.config/fontconfig/fonts.conf\
	.config/i3blocks/scripts/battery-label\
	.config/i3blocks/scripts/date-calendar\
	.config/i3blocks/scripts/gkrellm-toggle\
	.config/i3blocks/scripts/gpu-usage\
	.config/i3blocks/scripts/weather\
	.config/nvim\
	.config/pudb/pudb.cfg\
	.config/xss-lock/transfer-sleep-lock-i3lock.sh\
	.fonts/PowerlineSymbols.otf\
	.gkrellm2/user-config-cpu\
	.gkrellm2/user-config-memory\
	.local/bin/backtrace\
	.local/bin/combinediff-careful\
	.local/bin/dfix\
	.local/bin/get-gitignore\
	.local/bin/git-w\
	.local/bin/gr\
	.local/bin/low-battery-action\
	.local/bin/mdlynx\
	.local/bin/pip-deps\
	.local/bin/plot\
	.local/bin/print24bitcolours\
	.local/bin/print256colours\
	.local/bin/tmuxm\
	.tmuxline.conf\
	.virtualenvs/global_requirements.txt\

DOTDIRS=\
	.vim\
	.config/fish/plugins\

ENV_CONFIG_FILES=$(addprefix env/,\
	battery\
	browser\
	cuda\
	dblpbib\
	dmenu\
	feh\
	fontsize\
	git-push-default-simple\
	github_id\
	gkrellm\
	go\
	gsimplecal\
	i3blocks\
	ip\
	keychain\
	locale\
	lock\
	mujoco\
	netuser\
	nvidia-smi\
	osx\
	paths\
	perl\
	playerctl\
	pulseaudio\
	python\
	root\
	ruby\
	setxkbmap\
	shell\
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
)

UTILS_DIR=utils

DOTFILES_DIR:=$(shell pwd)
INSTALL_DIR:=$(HOME)
INSTALLED_DOTFILES:=$(addprefix $(INSTALL_DIR)/,$(DOTFILES))
INSTALLED_SYSTEMD_FILES:=$(addprefix $(INSTALL_DIR)/,$(SYSTEMD_FILES))
INSTALLED_DOTDIRS:=$(addprefix $(INSTALL_DIR)/,$(DOTDIRS))
# Sort to remove duplicates
INSTALLATION_DIRS:=$(sort $(dir $(INSTALLED_DOTFILES) $(INSTALLED_DOTDIRS)))

M4_CONFIG_GEN_FILES:=$(M4_DOTFILES) Makefile-binaries
ENV_CONFIG_M4_FILES:=$(addsuffix .m4,$(ENV_CONFIG_FILES))

INSTALLED_SYSTEM_FILES:=$(shell find system/ -type f -printf "/%P\n")
INSTALLATION_DIRS+=$(sort $(dir $(INSTALLED_SYSTEM_FILES)))

USER_CONFIG_PREFIX:=m4_user_config_
ENV_CONFIG_PREFIX:=m4_env_config_
# Hopefully unlikely to appear in the dotfiles.
QUOTE_START:=??[[<<
QUOTE_END:=>>]]??

WARNING_PREFIX:=$(shell echo "$$(tput setaf 172)WARNING$$(tput sgr0):")

PYGMENTIZE:=$(shell command -v pygmentize)

RANDOM_ID:=$(shell echo $$RANDOM)

YCM_DIR:=.vim/bundle/YouCompleteMe
YCM_CORE:=$(YCM_DIR)/third_party/ycmd/ycm_core.so
YCM_GIT_CHECKOUT:=$(YCM_DIR)/.git/logs/HEAD

.PHONY: build install install-dotfiles install-system install-all  \
	set-persistent-configs clean show show-config vim \
	vim-update-plugins vim-ycm systemd-reload \

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
	rm -f $@
	# Start a new temporary tmux session and in that tmux session run vim
	# and in vim call TmuxlineSnapshot to save the tmuxline configuration to
	# .tmuxline.conf
	tmux new-session -d -s 'tmuxline-${RANDOM_ID}' 'vim -u ".vimrc" -Es -c "TmuxlineSnapshot $@" -c "q"'
	while tmux list-sessions 2>/dev/null | grep 'tmuxline-${RANDOM_ID}' >/dev/null ; do \
		sleep 0.05; \
	done
	@if [ ! -f $@ ]; then \
		echo "$(WARNING_PREFIX) Unable to generate tmuxline snapshot. Install tmuxline vim plugin and remake."; \
		touch $@; \
	fi

# Configuration Files
# -------------------
# - Build user_config.m4 from user.cfg
# - Build env/*.m4 from ENV_CONFIG_FILES
# - Build env_config.m4 from env/*.m4
user_config.m4: user.cfg $(UTILS_DIR)/config_replace.sh
	sed -e 's/\s*#.*$$//' -e '/^\s*$$/d' $< | \
		$(UTILS_DIR)/config_replace.sh "${USER_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" > $@

env/%.m4: env/%
	$< | $(UTILS_DIR)/config_replace.sh "${ENV_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" | (echo "m4_dnl $<" && cat) > $@

env_config.m4: $(ENV_CONFIG_M4_FILES)
	cat $^ > $@

# Install Dotfiles & Dotdirs
# --------------------------
# - Copy dotfiles into INSTALL_DIR
# - Symbolic link dotdirs into INSTALL_DIR
install: install-dotfiles systemd-reload

set-persistent-configs: $(INSTALL_DIR)/.fonts/PowerlineSymbols.otf
	$(UTILS_DIR)/set-persistent-configs.sh


systemd-reload: .make/systemd-reload

SYSTEMCTL := $(shell command -v systemctl 2>/dev/null)
ifdef SYSTEMCTL
.make/systemd-reload: $(INSTALLED_SYSTEMD_FILES) | .make/
	systemctl --user daemon-reload
else
.make/systemd-reload: .make/
endif
	touch $@

.make/:
	mkdir -p $@

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
	rm -f .make/*

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

PYTHON := $(shell which python3 || echo python)

vim-ycm: $(YCM_CORE)

$(YCM_CORE): $(YCM_GIT_CHECKOUT)
	cd .vim/bundle/YouCompleteMe && \
		$(PYTHON) ./install.py --clang-completer \
		$$(if [[ "$$(uname -r)" == *ARCH* ]]; then echo --system-libclang; fi)
