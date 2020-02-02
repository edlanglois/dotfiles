MAKEFLAGS += -L
SHELL=/bin/bash -o pipefail
BUILD_DIR=build
SRC_DIR=src
UTILS_DIR=utils
DOTFILES_DIR:=$(shell pwd)

# Check that given variables are set and all have non-empty values,
# die with an error otherwise.
#
# Params:
#   1. Variable name(s) to test.
#   2. (optional) Error message to print.
#
# Source:
# https://stackoverflow.com/a/10858332 by Eldar Abusalimov
check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))

HOME_DIR := $(shell sed -n -e 's/^HOME=\(.*\)/\1/p' user.cfg)
$(call check_defined, HOME_DIR)

LOCAL_PREFIX := $(shell sed -n -e 's/^LOCAL_PREFIX=\(.*\)/\1/p' user.cfg)
$(call check_defined, LOCAL_PREFIX)
BIN_DIR := $(LOCAL_PREFIX)/bin

CONFIG_DIR := $(shell sed -n -e 's/^XDG_CONFIG_HOME=\(.*\)/\1/p' user.cfg)
$(call check_defined, CONFIG_DIR)

DATA_DIR := $(shell sed -n -e 's/^XDG_DATA_HOME=\(.*\)/\1/p' user.cfg)
$(call check_defined, DATA_DIR)

CACHE_DIR := $(shell sed -n -e 's/^XDG_CACHE_HOME=\(.*\)/\1/p' user.cfg)
$(call check_defined, CACHE_DIR)

SYSTEM_PREFIX := $(shell sed -n -e 's/^SYSTEM_PREFIX=\(.*\)/\1/p' user.cfg)
$(call check_defined, SYSTEM_PREFIX)

# Meant to be used by env/ scripts ONLY
# Echo to force ~ expansion
export HOME_DIR := $(shell echo $(HOME_DIR))
export LOCAL_PREFIX  := $(shell echo $(LOCAL_PREFIX))
BIN_DIR := $(shell echo $(BIN_DIR))
export CONFIG_DIR := $(shell echo $(CONFIG_DIR))
export DATA_DIR := $(shell echo $(DATA_DIR))
export CACHE_DIR := $(shell echo $(CACHE_DIR))
export SYSTEM_PREFIX := $(shell echo $(SYSTEM_PREFIX))

I3BLOCKS_SCRIPT_DIR := $(CONFIG_DIR)/i3blocks/scripts

# Incomplete files can be created when pipes / scripts fail
# so delete the target when the rule fails.
.DELETE_ON_ERROR:

WARNING_PREFIX:=$(shell echo "$$(tput setaf 172)WARNING$$(tput sgr0):")

# Environment configuration files
ENV_CONFIG_FILES:=\
	battery\
	browser\
	colours\
	cuda\
	dpi\
	git-push-default-simple\
	github_id\
	go\
	lock\
	modules\
	mujoco\
	netuser\
	nvidia-smi\
	osx\
	perl\
	programs\
	python\
	root\
	ruby\
	sys-monitor\
	tmux\
	torch\
	user\
	virtualfish\
	wifi\

ENV_CONFIG_BUILD_FILES=$(addsuffix .m4,\
	$(addprefix $(BUILD_DIR)/env/,$(ENV_CONFIG_FILES)))

# Bin
# ---
BIN_RAW_DOTFILES:=\
	backtrace\
	combinediff-careful\
	dblp-makebib\
	dfix\
	duplicacy-backup\
	get-gitignore\
	git-w\
	gr\
	low-battery-action\
	mdlynx\
	pip-deps\
	pip-update-all\
	plot\
	print24bitcolours\
	print256colours\
	tmuxm\

BIN_M4_DOTFILES:=
BIN_BUILT_DOTFILES:=$(BIN_M4_DOTFILES)
BIN_DOTFILES:=$(BIN_RAW_DOTFILES) $(BIN_BUILT_DOTFILES)

# Config
# ------
CONFIG_FISH_FOREIGN_ENV_DOTFILES:=$(addprefix fish/plugins/foreign-env/,\
	functions/fenv.apply.fish\
	functions/fenv.fish\
	functions/fenv.main.fish\
	functions/fenv.parse.after.fish\
	functions/fenv.parse.before.fish\
	functions/fenv.parse.diff.fish\
	functions/fenv.parse.divider.fish\
	LICENSE\
	README.md\
)

CONFIG_RAW_VIM_DOTFILES:=\
	$(shell cd "$(SRC_DIR)/config" && find vim -type f -not -name '*.m4')

CONFIG_RAW_DOTFILES:=\
	$(CONFIG_FISH_FOREIGN_ENV_DOTFILES)\
	$(CONFIG_RAW_VIM_DOTFILES)\
	fontconfig/fonts.conf\
	gkrellm/user-config-cpu\
	gkrellm/user-config-memory\
	i3blocks/scripts/battery-label\
	i3blocks/scripts/conky-toggle\
	i3blocks/scripts/date-calendar\
	i3blocks/scripts/gkrellm-toggle\
	i3blocks/scripts/gpu-usage\
	i3blocks/scripts/weather\
	pudb/pudb.cfg\
	python/startup.py\
	zathura/zathurarc\

CONFIG_M4_SYSTEMD_DOTFILES:=\
	systemd/user/duplicacy-backup.service\
	systemd/user/duplicacy-backup.timer\
	systemd/user/low-battery.service\
	systemd/user/low-battery.timer\
	systemd/user/ssh-agent.service\

CONFIG_M4_VIM_DOTFILES:=\
	vim/plugin/settings/airline.vim\
	vim/plugin/settings/tmuxline.vim\
	vim/vimrc\
	vim/ycm_extra_conf.py\

CONFIG_M4_DOTFILES:=\
	bash/aliases\
	bash/bashrc\
	bash/profile\
	conky/default-popup.lua\
	duplicacy/filters\
	env_profile\
	fish/config.fish\
	fish/functions/fish_prompt.fish\
	fish/functions/hostname-icon.fish\
	fish/functions/ip.fish\
	fish/functions/pbcopy.fish\
	fish/functions/pbpaste.fish\
	fish/functions/R.fish\
	fish/functions/tmux.fish\
	fish/functions/torch-activate.fish\
	flake8\
	gem/config.yaml\
	git/config\
	git/ignore\
	gsimplecal/config\
	gtk-3.0/settings.ini\
	hg/hgrc\
	i3/config\
	i3blocks/config\
	imwheel/config\
	isort.cfg\
	latexmk/latexmkrc\
	locale.conf\
	matplotlib/matplotlibrc\
	procps/toprc\
	profile\
	pylint/config\
	security/pam_env.conf\
	task/config\
	terminator/config\
	termite/config\
	theano/config\
	tmux/tmux.conf\
	user-dirs.dirs\
	wgetrc\
	xbindkeys/config\
	xinit/xinitrc\
	xinit/Xmodmap\
	xinit/Xresources\
	xinit/xserverrc\
	xprofile\
	yapf/style\
	yay/config.json\
	$(CONFIG_M4_SYSTEMD_DOTFILES)\
	$(CONFIG_M4_VIM_DOTFILES)\

CONFIG_VIM_DOTFILES:=$(CONFIG_RAW_VIM_DOTFILES) $(CONFIG_M4_VIM_DOTFILES)


CONFIG_I3BLOCKS_CONTRIB_SCRIPTS:=\
	battery/battery\
	cpu_usage/cpu_usage\
	essid/essid\
	mediaplayer/mediaplayer\
	memory/memory\
	temperature/temperature\
	volume/volume\
	wifi/wifi\

CONFIG_BUILT_DOTFILES:=\
	$(CONFIG_M4_DOTFILES)\
	$(CONFIG_TMUXLINE)\
	$(addprefix i3blocks/scripts/,$(notdir $(CONFIG_I3BLOCKS_CONTRIB_SCRIPTS)))\

CONFIG_DOTFILES:=$(CONFIG_RAW_DOTFILES) $(CONFIG_BUILT_DOTFILES)

# Data
# ----
# These directories need to exist for the programs in question to use them
DATA_FONTS:=\
	fonts/PowerlineSymbols.otf

DATA_RAW_DOTFILES:=$(DATA_FONTS)

DATA_MAKE_DIRS:=$(addsuffix /.,\
	tig\
	wget\
)
# Vundle has a custom install rule
DATA_VUNDLE_DIR:=vim/bundle/Vundle.vim
DATA_DOTFILES:=$(DATA_RAW_DOTFILES) $(DATA_MAKE_DIRS) $(DATA_VUNDLE_DIR)

# Home
# ----
# To avoid putting files here, only include if the relevant program exists.
HOME_RAW_DOTFILES:=

HOME_M4_DOTFILES:=\
	.ssh/config\

HOME_M4_LINKS:=\
	.bash_profile\
	.bashrc\
	.pam_environment\
	.profile\
	.xprofile\

ifneq ($(strip $(shell command -v gkrellm)),)
HOME_M4_LINKS += .gkrellm2
endif
ifneq ($(strip $(shell command -v imwheel)),)
HOME_M4_LINKS += .imwheelrc
endif
ifneq ($(strip $(shell command -v lightdm || command -v gdm)),)
HOME_M4_LINKS += .Xresources
endif

HOME_BUILT_DOTFILES:=$(HOME_M4_DOTFILES) $(addsuffix .link,$(HOME_M4_LINKS))
HOME_DOTFILES:=$(HOME_RAW_DOTFILES) $(HOME_M4_DOTFILES)
HOME_LINKS:=$(HOME_M4_LINKS)

# System
# ------
SYSTEM_RAW_DOTFILES:=\
	etc/udev/rules.d/90-backlight.rules\
	etc/X11/xorg.conf.d/30-touchpad.conf\
	etc/X11/xorg.conf.d/90-keyboard.conf\

SYSTEM_M4_DOTFILES:=\
	etc/systemd/system/getty@tty1.service.d/override.conf\
	etc/X11/xorg.conf.d/80-monitor.conf\

SYSTEM_BUILT_DOTFILES:=$(SYSTEM_M4_DOTFILES)
SYSTEM_DOTFILES:=$(SYSTEM_RAW_DOTFILES) $(SYSTEM_BUILT_DOTFILES)

M4_DOTFILES:=\
	$(addprefix bin/,$(BIN_M4_DOTFILES))\
	$(addprefix config/,$(CONFIG_M4_DOTFILES))\
	$(addprefix data/,$(DATA_M4_DOTFILES))\
	$(addprefix home/,$(HOME_M4_DOTFILES))\
	$(addprefix home/,$(addsuffix .link,$(HOME_M4_LINKS)))\
	$(addprefix system/,$(SYSTEM_M4_DOTFILES))\

RAW_DOTFILES:=\
	$(addprefix bin/,$(BIN_RAW_DOTFILES))\
	$(addprefix config/,$(CONFIG_RAW_DOTFILES))\
	$(addprefix data/,$(DATA_RAW_DOTFILES))\
	$(addprefix home/,$(HOME_RAW_DOTFILES))\
	$(addprefix system/,$(SYSTEM_RAW_DOTFILES))\

BUILT_DOTFILES:=$(addprefix build/,\
	$(addprefix bin/,$(BIN_BUILT_DOTFILES))\
	$(addprefix config/,$(CONFIG_BUILT_DOTFILES))\
	$(addprefix data/,$(DATA_BUILT_DOTFILES))\
	$(addprefix home/,$(HOME_BUILT_DOTFILES))\
	$(addprefix system/,$(SYSTEM_BUILT_DOTFILES))\
)

INSTALLED_DOTFILES:=\
	$(addprefix $(BIN_DIR)/,$(BIN_DOTFILES))\
	$(addprefix $(CONFIG_DIR)/,$(CONFIG_DOTFILES))\
	$(addprefix $(DATA_DIR)/,$(DATA_DOTFILES))\
	$(addprefix $(HOME_DIR)/,$(HOME_DOTFILES))\
	$(addprefix $(HOME_DIR)/,$(HOME_LINKS))\

INSTALLED_SYSTEM_DOTFILES:=\
	$(addprefix $(SYSTEM_PREFIX)/,$(SYSTEM_DOTFILES))\

INSTALLED_SYSTEMD_FILES:=\
	$(addprefix $(CONFIG_DIR)/,$(CONFIG_M4_SYSTEMD_DOTFILES))

INSTALLED_FONTS:=\
	$(addprefix $(DATA_DIR)/,$(DATA_FONTS))

.PHONY: build install install-user-dotfiles install-system clean help

build: $(BUILT_DOTFILES)

install: install-user-dotfiles systemd-reload font-cache

install-user-dotfiles: $(INSTALLED_DOTFILES) $(INSTALLED_LINKS)

install-system: $(INSTALLED_SYSTEM_DOTFILES)

clean:
	rm -rf $(BUILD_DIR)

define HELP_MESSAGE
Makefile Commands
=================
build [default]    : Build the dotfiles into $(BUILD_DIR)/
install            : Install user dotfiles.
                     Destinations are specified in user.cfg.
install-system     : Install system dotfiles.
                     Likely requires root permissions.
clean              : Remove build products.
help               : Print this help message

show               : Run all `show-*` commands.
show-dirs          : Print the install directories.
show-config        : Print the user and environment configuration.

vim                : Run all `vim-*` commands.
                     Uses the installed configurations so install first.
vim-vundle         : Install the Vundle vim plugin.
vim-plugins        : Install and update vim plugins.
vim-ycm            : Compile YouCompleteMe for vim.
vim-tmuxline       : Create the tmuxline configuration.

systemd-reload     : Reload user systemd units if any changed.
font-cache         : Create the font cache.
persistent-configs : Set persistent settings that are not file-based.
endef

help:
	@: $(info $(HELP_MESSAGE))


#############################
##  Build Regular Configs  ##
#############################

USER_CONFIG_PREFIX:=m4_user_config_
ENV_CONFIG_PREFIX:=m4_env_config_
# Hopefully unlikely to appear in the dotfiles.
QUOTE_START:=??[[<<
QUOTE_END:=>>]]??

define MKDIR_TEMPLATE
.PRECIOUS: $1/. $1/%/.

$1/.:
	mkdir -p "$$@"

$1/%/.:
	mkdir -p "$$@"

endef

$(eval $(call MKDIR_TEMPLATE,$(BUILD_DIR)))

# Templates are required for evaluating the directory and wildcard prequisites.
# .SECONDEXPANSION could be used instead but it is less portable.
define M4_BUILD_TEMPLATE
$(BUILD_DIR)/$1: \
		$(SRC_DIR)/$1.m4 \
		$(wildcard $(SRC_DIR)/$1.local) \
		$(BUILD_DIR)/user_config.m4 \
		$(BUILD_DIR)/env_config.m4 | $(dir $(BUILD_DIR)/$1).
	echo "m4_changecom()m4_changequote($(QUOTE_START),$(QUOTE_END))m4_dnl" | \
		cat - "$$<" | \
		m4 --prefix-builtins > "$$@" -I "$(BUILD_DIR)"
endef

define EXECUTABLE_M4_BUILD_TEMPLATE
$(call M4_BUILD_TEMPLATE,$1)
	chmod u+x "$$@"
endef

define RAW_BUILD_TEMPLATE
$(BUILD_DIR)/$1: $(SRC_DIR)/$1 | $(dir $(BUILD_DIR)/$1).
	cp -v "$$<" "$$@"
endef

$(foreach DOTFILE,$(M4_DOTFILES),\
	$(eval $(call M4_BUILD_TEMPLATE,$(DOTFILE))))

$(foreach DOTFILE,$(EXECUTABLE_M4_DOTFILES),\
	$(eval $(call EXECUTABLE_M4_BUILD_TEMPLATE,$(DOTFILE))))

$(foreach DOTFILE,$(RAW_DOTFILES),\
	$(eval $(call RAW_BUILD_TEMPLATE,$(DOTFILE))))

####################
# I3Blocks Contrib #
####################

define BUILD_I3BLOCKS_CONTRIB_TEMPLATE
$(BUILD_DIR)/config/i3blocks/scripts/$(notdir $1) : $(SRC_DIR)/config/i3blocks/i3blocks-contrib/$1 | $(BUILD_DIR)/config/i3blocks/scripts/.
	cp -v "$$<" "$$@"
endef

$(foreach CONTRIB_SCRIPT,$(CONFIG_I3BLOCKS_CONTRIB_SCRIPTS),\
	$(eval $(call BUILD_I3BLOCKS_CONTRIB_TEMPLATE,$(CONTRIB_SCRIPT))))

#########################
# M4 Build Config Files #
#########################

# Depends on user.cfg because env scripts may use the exported environment
# variables that are defined by user.cfg
define ENV_CONFIG_TEMPLATE
$(BUILD_DIR)/env/$1.m4: $(SRC_DIR)/env/$1 $(SRC_DIR)/env/env_utils $(BUILD_DIR)/env/paths.sh \
		| $(dir $(BUILD_DIR)/env/$1).
	source "$(BUILD_DIR)/env/paths.sh" && \
		"$$<" | \
		$(UTILS_DIR)/config_replace.sh \
			"$(ENV_CONFIG_PREFIX)" "$(QUOTE_START)" "$(QUOTE_END)" | \
		(echo "m4_dnl $$<" && cat) > $$@
endef

$(BUILD_DIR)/env/colours.m4: $(BUILD_DIR)/env/colours.toml

$(eval $(call RAW_BUILD_TEMPLATE,env/colours.toml))

$(foreach ENVFILE,$(ENV_CONFIG_FILES),\
	$(eval $(call ENV_CONFIG_TEMPLATE,$(ENVFILE))))

$(BUILD_DIR)/user_config.m4: user.cfg $(UTILS_DIR)/config_replace.sh | $(BUILD_DIR)/.
	sed -e 's/\s*#.*$$//' -e '/^\s*$$/d' $< | \
		$(UTILS_DIR)/config_replace.sh "${USER_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" > $@

$(BUILD_DIR)/env/paths.sh: user.cfg | $(BUILD_DIR)/env/.
	grep -e '^ *[A-Z_]*\(HOME\|PREFIX\) *=' user.cfg | sed -e "s/^/export /" > "$@"

$(BUILD_DIR)/env/absolute_paths.m4: user.cfg $(UTILS_DIR)/config_replace.sh | $(BUILD_DIR)/env/.
	# Will fail if $HOME contains | characters
	sed user.cfg -n -e "s|=~|=$(HOME)|" -e "/\(HOME\|PREFIX\)=/p" |\
		$(UTILS_DIR)/config_replace.sh "${ENV_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" |\
		(echo "m4_dnl $<" && cat) > "$@"

$(BUILD_DIR)/env_config.m4: $(ENV_CONFIG_BUILD_FILES) $(BUILD_DIR)/env/absolute_paths.m4 | $(BUILD_DIR)/.
	cat $^ > "$@"

####################
# Show Information #
####################
.PHONY: show show-dirs show-config

show: show-dirs show-config

show-dirs:
	@echo "HOME_DIR:      $(HOME_DIR)"
	@echo "BIN_DIR:       $(BIN_DIR)"
	@echo "CONFIG_DIR:    $(CONFIG_DIR)"
	@echo "DATA_DIR:      $(DATA_DIR)"
	@echo "CACHE_DIR:     $(CACHE_DIR)"
	@echo "SYSTEM_PREFIX: $(SYSTEM_PREFIX)"

PYGMENTIZE:=$(shell command -v pygmentize)
ifdef PYGMENTIZE
# pygmentize does not apply the right colours for dark background on
# vim style so use a different style that does work.
COLORIZE_CONFIG:=pygmentize -l 'cfg' -O style=native -f terminal256
else
COLORIZE_CONFIG:=cat
endif

ESCAPED_QUOTE_START=$(subst [,\[,$(subst ],\],$(QUOTE_START)))
ESCAPED_QUOTE_END=$(subst [,\[,$(subst ],\],$(QUOTE_END)))

show-config: user.cfg $(BUILD_DIR)/env_config.m4
ifndef PYGMENTIZE
	@echo "Install pygmentize (python pygments) to view coloured output."
	@echo
endif
	@echo '# User Config' | cat - user.cfg | $(COLORIZE_CONFIG)
	@echo
	@echo '# Environment Config' | cat - $(BUILD_DIR)/env_config.m4 | \
		sed -e "s/^m4_dnl/#/" \
			-e "s/$(ESCAPED_QUOTE_START)//g" \
			-e "s/$(ESCAPED_QUOTE_END)//g" \
			-e "s/^m4_define(m4_env_config_//" \
			-e "s/)m4_dnl$$//" \
			-e "s/,/=/" | \
		$(COLORIZE_CONFIG)

#############
## Install ##
#############

# Args: SOURCE_PREFIX SOURCE_SUBDIR INSTALL_DIR RELATIVE_PATH
# The first blank line is necessary. Foreach separates the evaluations with
# a space but we don't want the rule definition to start with a space.
define INSTALL_FILE_TEMPLATE

$3/$4: $1/$2/$4 | $(dir $3/$4).
	@cp -v "$$<" "$$@"
endef

# Args: SOURCE_PREFIX SOURCE_SUBDIR INSTALL_DIR RELATIVE_PATHS
define INSTALL_FILES_TEMPLATE
$(foreach DOTFILE,$4,$(call INSTALL_FILE_TEMPLATE,$1,$2,$3,$(DOTFILE)))
endef

# Args: SOURCE_PREFIX SOURCE_SUBDIR INSTALL_DIR RELATIVE_PATH
define INSTALL_LINK_TEMPLATE

$3/$4: $1/$2/$4.link | $(dir $3/$4).
	ln -s -f "$$$$(grep -m 1 "[^[:space:]]" "$$<")" "$$@"
endef

# Args: SOURCE_PREFIX SOURCE_SUBDIR INSTALL_DIR RELATIVE_PATHS
define INSTALL_LINKS_TEMPLATE
$(foreach DOTFILE,$4,$(call INSTALL_LINK_TEMPLATE,$1,$2,$3,$(DOTFILE)))
endef

# Args: SOURCE_SUBDIR INSTALL_DIR RAW_DOTFILES BUILT_DOTFILES LINKS
define INSTALL_TEMPLATE
$(call MKDIR_TEMPLATE,$2)
$(call INSTALL_FILES_TEMPLATE,$(SRC_DIR),$1,$2,$3)
$(call INSTALL_FILES_TEMPLATE,$(BUILD_DIR),$1,$2,$4)
$(call INSTALL_LINKS_TEMPLATE,$(BUILD_DIR),$1,$2,$5)
endef

$(eval $(call INSTALL_TEMPLATE,bin,$(BIN_DIR),\
	$(BIN_RAW_DOTFILES),$(BIN_BUILT_DOTFILES)))

$(eval $(call INSTALL_TEMPLATE,config,$(CONFIG_DIR),\
	$(CONFIG_RAW_DOTFILES),$(CONFIG_BUILT_DOTFILES)))

$(eval $(call INSTALL_TEMPLATE,data,$(DATA_DIR),\
	$(DATA_RAW_DOTFILES),$(DATA_BUILT_DOTFILES)))

$(eval $(call INSTALL_TEMPLATE,home,$(HOME_DIR),\
	$(HOME_RAW_DOTFILES),$(HOME_BUILT_DOTFILES),$(HOME_LINKS)))

$(eval $(call INSTALL_TEMPLATE,system,$(SYSTEM_PREFIX),\
	$(SYSTEM_RAW_DOTFILES),$(SYSTEM_BUILT_DOTFILES)))

#######
# Vim #
#######
.PHONY: vim vim-vundle vim-plugins vim-ycm vim-tmuxline

vim: vim-vundle vim-plugins vim-ycm vim-tmuxline

VUNDLE_DIR:=$(DATA_DIR)/$(DATA_VUNDLE_DIR)
vim-vundle: | $(VUNDLE_DIR)

$(VUNDLE_DIR): | $(dir $(VUNDLE_DIR)).
	cd $(dir $@) && git clone https://github.com/VundleVim/Vundle.vim.git

vim-plugins: vim-vundle
	vim +PluginInstall +PluginUpdate +qall

YCM_DIR:=$(DATA_DIR)/vim/bundle/YouCompleteMe
YCM_CORE:=$(YCM_DIR)/third_party/ycmd/ycm_core.so
YCM_GIT_CHECKOUT:=$(YCM_DIR)/.git/logs/HEAD

PYTHON := $(shell which python3 || echo python)

vim-ycm: $(YCM_CORE)

$(YCM_CORE): $(YCM_GIT_CHECKOUT)
	cd $(YCM_DIR) && \
		$(PYTHON) ./install.py --clang-completer \
		$$(if [[ "$$(uname -r)" == *ARCH* ]]; then echo --system-libclang; fi)


TMUXLINE_CONFIG:=tmux/tmuxline.conf
RANDOM_ID:=$(shell echo $$RANDOM)

vim-tmuxline: $(CONFIG_DIR)/$(TMUXLINE_CONFIG)

$(CONFIG_DIR)/$(TMUXLINE_CONFIG): \
	| $(dir $(CONFIG_DIR)/$(TMUXLINE_CONFIG)).
	# Start a new temporary tmux session and in that tmux session run vim
	# and in vim call TmuxlineSnapshot to save the tmuxline configuration to
	# tmuxline.conf
	tmux new-session -d -s 'tmuxline-$(RANDOM_ID)' 'vim -E -c "TmuxlineSnapshot! $@" -c "q"'
	while tmux list-sessions 2>/dev/null | grep 'tmuxline-$(RANDOM_ID)' >/dev/null ; do \
		sleep 0.05; \
	done
	@if [ ! -f "$@" ]; then \
		echo "$(WARNING_PREFIX) Unable to generate tmuxline snapshot. Install tmuxline vim plugin and remake."; \
		false; \
	fi

######################
# Persistent Configs #
######################
.PHONY: persistent-configs

persistent-configs: $(BUILD_DIR)/make/persistent-configs

$(BUILD_DIR)/make/persistent-configs: \
		$(UTILS_DIR)/set-persistent-configs.sh \
		$(INSTALLED_SYSTEMD_FILES) \
		| $(BUILD_DIR)/make/
	$(UTILS_DIR)/set-persistent-configs.sh
	touch "$@"


$(BUILD_DIR)/make/:
	mkdir -p "$@"

##################
# Systemd Reload #
##################
.PHONY: systemd-reload

systemd-reload: $(BUILD_DIR)/make/systemd-reload

SYSTEMCTL := $(shell command -v systemctl 2>/dev/null)
ifdef SYSTEMCTL
$(BUILD_DIR)/make/systemd-reload: \
		$(INSTALLED_SYSTEMD_FILES) \
		| $(BUILD_DIR)/make/
	systemctl --user daemon-reload
else
$(BUILD_DIR)/make/systemd-reload: /make/
endif
	touch "$@"

##############
# Font Cache #
##############
.PHONY: font-cache

font-cache: $(BUILD_DIR)/make/font-cache

$(BUILD_DIR)/make/font-cache: $(INSTALLED_FONTS) | $(BUILD_DIR)/make/
	fc-cache -v $(DATA_DIR)/fonts/
	touch "$@"
