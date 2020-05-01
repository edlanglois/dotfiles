MAKEFLAGS += -L
SHELL=/bin/bash -o pipefail
BUILD_DIR=build
SOURCE_DIR=src
UTILS_DIR=utils

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

# The following variables need to be defined
# for each TYPE = bin | config | data | home | system
#
# <TYPE>_FIRST_BUILD
# 	- Names % where BUILD_DIR/<TYPE>/% does not depend on any other files in the
# 		same directory.
# <TYPE>_BUILD
# 	- Names % where BUILD_DIR/<TYPE>/% is required for install
# <TYPE>_INSTALL
# 	- Names % where <TYPE>_INSTALL_PREFIX/% is an install target
# <TYPE>_EXIST
# 	- Names % where <TYPE>_INSTALL_PREFIX/% should exist (never updated)
#
# These variables are used to define the make targets (build and install)
# and to create templated rules that depend on the target directory existing.
#
# Useful intermediate variables:
# <TYPE>_FBI (or a subset of FBI)
# 	- Intersections of <TYPE>_FIRST_BUILD, <TYPE>_BUILD, <TYPE>_INSTALL
# <TYPE>_LINKS
# 	- Names % where <TYPE>_INSTALL_PREFIX/% is a symbolic link to a file
# <TYPE>_DLINKS
# 	- Names % where <TYPE>_INSTALL_PREFIX/% is a symbolic link to a directory

# Files can be installed directly from SOURCE_DIR or from BUILD_DIR
# Files in BUILD_DIR can depend on other build files.

# Bin
# ---
BIN_FIRST_BUILD:=
BIN_BUILD:=
BIN_LINKS:=
BIN_DLINKS:=
BIN_EXIST:=$(BIN_LINKS) $(BIN_DLINKS)
BIN_INSTALL:=\
	backtrace\
	combinediff-careful\
	dblp-makebib\
	dfix\
	geolocate\
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
	xopen\

# Config
# ------
CONFIG_FBI_SYSTEMD:=\
	systemd/user/duplicacy-backup.service\
	systemd/user/duplicacy-backup.timer\
	systemd/user/duplicacy-prune.service\
	systemd/user/duplicacy-prune.timer\
	systemd/user/low-battery.service\
	systemd/user/low-battery.timer\
	systemd/user/ssh-agent.service\

CONFIG_FBI_VIM:=\
	vim/plugin/settings/airline.vim\
	vim/plugin/settings/tmuxline.vim\
	vim/vimrc\
	vim/ycm_extra_conf.py\

CONFIG_I3BLOCKS_CONTRIB:=\
	battery/battery\
	cpu_usage/cpu_usage\
	memory/memory\
	temperature/temperature\
	volume/volume\
	wifi/wifi\

CONFIG_FBI:=\
	$(CONFIG_FBI_SYSTEMD)\
	$(CONFIG_FBI_VIM)\
	$(addprefix i3blocks/scripts/,$(notdir $(CONFIG_I3BLOCKS_CONTRIB)))\
	bash/aliases\
	bash/bashrc\
	bash/profile\
	conky/default-popup.lua\
	duplicacy-web/settings.json\
	duplicacy/filters\
	env_profile\
	fish/config.fish\
	fish/functions/ccopy.fish\
	fish/functions/cpaste.fish\
	fish/functions/fish_prompt.fish\
	fish/functions/hostname-icon.fish\
	fish/functions/ip.fish\
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
	npm/config\
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

CONFIG_LINKS:=
CONFIG_DLINKS:=\
	chromium\
	duplicacy-web/bin\
	duplicacy-web/stats\
	duplicacy/cache\
	launcher-main\
	libreoffice\
	Slack\

CONFIG_EXIST:=$(CONFIG_LINKS) $(CONFIG_DLINKS)

CONFIG_FB:=\
	$(addsuffix .link,$(CONFIG_LINKS))\
	$(addsuffix .dlink,$(CONFIG_DLINKS))\

CONFIG_FIRST_BUILD:=\
	$(CONFIG_FBI)\
	$(CONFIG_FB)\

CONFIG_BUILD:=\
	$(CONFIG_FBI)\
	$(CONFIG_FB)\

CONFIG_INSTALL_FISH_FOREIGN_ENV:=$(addprefix fish/plugins/foreign-env/,\
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

CONFIG_INSTALL_VIM_DIRECT:=\
	$(shell cd "$(SOURCE_DIR)/config" && find vim -type f -not -name '*.m4')

CONFIG_INSTALL:=\
	$(CONFIG_INSTALL_FISH_FOREIGN_ENV)\
	$(CONFIG_INSTALL_VIM_DIRECT)\
	$(CONFIG_FBI)\
	fontconfig/fonts.conf\
	gkrellm/user-config-cpu\
	gkrellm/user-config-memory\
	i3blocks/scripts/battery-label\
	i3blocks/scripts/conky-toggle\
	i3blocks/scripts/date-calendar\
	i3blocks/scripts/gkrellm-toggle\
	i3blocks/scripts/gpu-usage\
	i3blocks/scripts/music\
	i3blocks/scripts/ssid\
	i3blocks/scripts/weather\
	pudb/pudb.cfg\
	python/startup.py\
	zathura/zathurarc\

# Data
# ----
DATA_LINKS:=
DATA_DLINKS:=\
	libreoffice/4/cache\
	Slack/Cache\
	Steam/appcache\

DATA_EXIST=$(DATA LINKS) $(DATA_DLINKS)

DATA_FB:=\
	$(addsuffix .link,$(DATA_LINKS))\
	$(addsuffix .dlink,$(DATA_DLINKS))\

# Custom install for Steam Desktop
SOURCE_STEAM_DESKTOP:=/usr/share/applications/steam.desktop
DATA_STEAM_DESKTOP:=applications/steam.desktop

DATA_FIRST_BUILD:=\
	$(DATA_FB)\
	$(DATA_STEAM_DESKTOP).sed\

DATA_BI:=
ifneq ("$(wildcard $(SOURCE_STEAM_DESKTOP))","")
DATA_BI+=$(DATA_STEAM_DESKTOP)
endif

DATA_BUILD:=\
	$(DATA_FB)\
	$(DATA_BI)\

DATA_FONTS:=\
	fonts/PowerlineSymbols.otf\

DATA_VUNDLE_DIR:=vim/bundle/Vundle.vim

DATA_INSTALL:=\
	$(DATA_FONTS)\
	$(DATA_BI)\
	$(DATA_VUNDLE_DIR)\
	tig/.\
	wget/.\

# Home
# ----
HOME_FBI:=\
	.ssh/config\

# To avoid putting files here, only include if the relevant program exists.
HOME_LINKS:=\
	.bash_profile\
	.bashrc\
	.pam_environment\
	.profile\
	.xprofile\

HOME_DLINKS:=

ifneq ($(strip $(shell command -v duplicacy-web)),)
HOME_DLINKS += .duplicacy-web
endif
ifneq ($(strip $(shell command -v gkrellm)),)
HOME_DLINKS += .gkrellm2
endif
ifneq ($(strip $(shell command -v imwheel)),)
HOME_LINKS += .imwheelrc
endif
ifneq ($(strip $(shell command -v firefox)),)
HOME_DLINKS += .mozilla
endif
ifneq ($(strip $(shell command -v thunderbird)),)
HOME_DLINKS += .thunderbird
endif
ifneq ($(strip $(shell command -v lightdm || command -v gdm)),)
HOME_LINKS += .Xresources
endif
ifneq ($(strip $(shell command -v zotero)),)
HOME_DLINKS += .zotero
endif

HOME_EXIST=$(HOME_LINKS) $(HOME_DLINKS)

HOME_FB:=\
	$(addsuffix .link,$(HOME_LINKS))\
	$(addsuffix .dlink,$(HOME_DLINKS))\

HOME_FIRST_BUILD:=\
	$(HOME_FBI)\
	$(HOME_FB)\

HOME_BUILD:=\
	$(HOME_FBI)\
	$(HOME_FB)\

HOME_INSTALL:=\
	$(HOME_FBI)\
	$(HOME_INSTALL)\

# System
# ------

SYSTEM_FBI:=\
	etc/systemd/system/getty@tty1.service.d/override.conf\
	etc/X11/xorg.conf.d/30-touchpad.conf\
	etc/X11/xorg.conf.d/80-monitor.conf\

SYSTEM_FIRST_BUILD:=\
	$(SYSTEM_FBI)\

SYSTEM_BUILD:=\
	$(SYSTEM_FBI)\

SYSTEM_INSTALL:=\
	$(SYSTEM_FBI)\
	etc/udev/rules.d/90-backlight.rules\
	etc/X11/xorg.conf.d/90-keyboard.conf\

# Environment
# -----------
ENV_FIRST_BUILD:=\
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
	touchpad\
	user\
	virtualfish\
	wifi\

ENV_CONFIG_TARGETS=$(addsuffix .m4,\
	$(addprefix $(BUILD_DIR)/env/,$(ENV_FIRST_BUILD)))

# Combined
# --------
FIRST_BUILD_TARGETS:=$(addprefix $(BUILD_DIR)/,\
	$(addprefix bin/,$(BIN_FIRST_BUILD))\
	$(addprefix config/,$(CONFIG_FIRST_BUILD))\
	$(addprefix data/,$(DATA_FIRST_BUILD))\
	$(addprefix env/,$(ENV_FIRST_BUILD))\
	$(addprefix home/,$(HOME_FIRST_BUILD))\
	$(addprefix system/,$(SYSTEM_FIRST_BUILD))\
)

BUILD_TARGETS:=$(addprefix $(BUILD_DIR)/,\
	$(addprefix bin/,$(BIN_BUILD))\
	$(addprefix config/,$(CONFIG_BUILD))\
	$(addprefix data/,$(DATA_BUILD))\
	$(addprefix home/,$(HOME_BUILD))\
	$(addprefix system/,$(SYSTEM_BUILD))\
)

INSTALL_TARGETS:=\
	$(addprefix $(BIN_DIR)/,$(BIN_INSTALL))\
	$(addprefix $(CONFIG_DIR)/,$(CONFIG_INSTALL))\
	$(addprefix $(DATA_DIR)/,$(DATA_INSTALL))\
	$(addprefix $(HOME_DIR)/,$(HOME_INSTALL))\

INSTALL_EXIST_TARGETS:=\
	$(addprefix $(BIN_DIR)/,$(BIN_EXIST))\
	$(addprefix $(CONFIG_DIR)/,$(CONFIG_EXIST))\
	$(addprefix $(DATA_DIR)/,$(DATA_EXIST))\
	$(addprefix $(HOME_DIR)/,$(HOME_EXIST))\

INSTALL_SYSTEM_TARGETS:=$(addprefix $(SYSTEM_PREFIX)/,$(SYSTEM_INSTALL))

INSTALLED_SYSTEMD_CONFIGS:=$(addprefix $(CONFIG_DIR)/,$(CONFIG_FBI_SYSTEMD))
INSTALLED_FONTS:=$(addprefix $(DATA_DIR)/,$(DATA_FONTS))

############
# Commands #
############

.PHONY: build install install-user install-system clean help

build: $(BUILD_TARGETS)

install: install-user systemd-reload font-cache

install-user: $(INSTALL_TARGETS) | $(INSTALL_EXIST_TARGETS)

install-system: $(INSTALL_SYSTEM_TARGETS)

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

show               : Run most `show-*` commands.
show-dirs          : Print the install directories.
show-config        : Print the user and environment configuration.
show-wants         : Print a list of desirable programs that are not
                     checked by the environment configuration (show-config).
show-links         : Print information about files that should be links.

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

################
##  Build M4  ##
################

USER_CONFIG_PREFIX:=m4_user_config_
ENV_CONFIG_PREFIX:=m4_env_config_
# Hopefully unlikely to appear in the dotfiles.
QUOTE_START:=??[[<<
QUOTE_END:=>>]]??

# TODO: Support %.local dependencies
# Add a list of files that might have .local dependencies and template the
# dependence

$(BUILD_DIR)/%: $(SOURCE_DIR)/%.m4 \
		$(BUILD_DIR)/user_config.m4 $(BUILD_DIR)/env_config.m4
	echo "m4_changecom()m4_changequote($(QUOTE_START),$(QUOTE_END))m4_dnl" | \
		cat - "$<" | \
		m4 --prefix-builtins -I "$(BUILD_DIR)" > "$@"
	! grep m4_ "$@" || (echo "Undefined m4 variables" && rm "$@" && false)

##############################
##  Build I3Blocks Contrib  ##
##############################

define BUILD_I3BLOCKS_CONTRIB_TEMPLATE
$(BUILD_DIR)/config/i3blocks/scripts/$(notdir $1):\
		$(SOURCE_DIR)/config/i3blocks/i3blocks-contrib/$1\
		| $(BUILD_DIR)/config/i3blocks/scripts/.
	cp -v "$$<" "$$@"
endef

$(foreach CONTRIB_SCRIPT,$(CONFIG_I3BLOCKS_CONTRIB),\
	$(eval $(call BUILD_I3BLOCKS_CONTRIB_TEMPLATE,$(CONTRIB_SCRIPT))))

###################
##  Build Steam  ##
###################

$(BUILD_DIR)/data/$(DATA_STEAM_DESKTOP):\
		$(BUILD_DIR)/data/$(DATA_STEAM_DESKTOP).sed\
		$(SOURCE_STEAM_DESKTOP)
	sed -f "$<" "$(SOURCE_STEAM_DESKTOP)" > "$@"

#########################
##  Build Environment  ##
#########################

$(BUILD_DIR)/env/%.m4: $(SOURCE_DIR)/env/% \
		$(SOURCE_DIR)/env/env_utils\
		$(BUILD_DIR)/env/paths.sh\
		$(UTILS_DIR)/config_replace.sh
	source "$(BUILD_DIR)/env/paths.sh" && \
		"$<" | \
		$(UTILS_DIR)/config_replace.sh \
			"$(ENV_CONFIG_PREFIX)" "$(QUOTE_START)" "$(QUOTE_END)" | \
		(echo "m4_dnl $<" && cat) > "$@"

$(BUILD_DIR)/env/colours.m4: $(SOURCE_DIR)/env/colours.toml

$(BUILD_DIR)/user_config.m4: user.cfg\
		$(UTILS_DIR)/config_replace.sh\
		| $(BUILD_DIR)/.
	sed -e 's/\s*#.*$$//' -e '/^\s*$$/d' $< | \
		$(UTILS_DIR)/config_replace.sh \
			"${USER_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" > $@

$(BUILD_DIR)/env/paths.sh: user.cfg | $(BUILD_DIR)/env/.
	grep -e '^ *[A-Z_]*\(HOME\|PREFIX\) *=' user.cfg | \
		sed -e "s/^/export /" > "$@"

$(BUILD_DIR)/env/absolute_paths.m4: user.cfg\
		$(UTILS_DIR)/config_replace.sh\
		| $(BUILD_DIR)/env/.
	# Will fail if $HOME contains | characters
	sed user.cfg -n -e "s|=~|=$(HOME)|" -e "/\(HOME\|PREFIX\)=/p" |\
		$(UTILS_DIR)/config_replace.sh \
			"${ENV_CONFIG_PREFIX}" "${QUOTE_START}" "${QUOTE_END}" |\
		(echo "m4_dnl $<" && cat) > "$@"

$(BUILD_DIR)/env_config.m4: $(ENV_CONFIG_TARGETS) \
		$(BUILD_DIR)/env/absolute_paths.m4 |\
		$(BUILD_DIR)/.
	cat $^ > "$@"

########################
##  Show Information  ##
########################
.PHONY: show show-dirs show-config show-wants show-links

show: show-dirs show-config show-wants

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

show-wants: $(SOURCE_DIR)/env/wants $(SOURCE_DIR)/env/env_utils
	@"$<" | ( echo "# wants" && cat ) | $(COLORIZE_CONFIG)

show-links: build $(UTILS_DIR)/check-links
	@$(UTILS_DIR)/check-links


###############
##  Install  ##
###############

# Args: INSTALL_DIR SOURCE_TYPE
define INSTALL_TEMPLATE
$1/%: $(SOURCE_DIR)/$2/%
	@cp -v "$$<" "$$@"

$1/%: $(BUILD_DIR)/$2/%
	@cp -v "$$<" "$$@"

$1/%: | $(BUILD_DIR)/$2/%.link
	DEST="$$$$(grep -m 1 "[^[:space:]]" "$$(patsubst $1/%,$(BUILD_DIR)/$2/%.dlink,$$@)")"; \
	[ -n "$$$$DEST" ] && ! [ -d "$$@" ] && \
	ln -s -f "$$$$DEST" "$$@"

$1/%: | $(BUILD_DIR)/$2/%.dlink
	DEST="$$$$(grep -m 1 "[^[:space:]]" "$$(patsubst $1/%,$(BUILD_DIR)/$2/%.dlink,$$@)")"; \
	[ -n "$$$$DEST" ] && ! [ -d "$$@" ] && \
	ln -s -f "$$$$DEST" "$$@" && \
	mkdir -p "$$$$DEST"
endef

$(eval $(call INSTALL_TEMPLATE,$(BIN_DIR),bin))
$(eval $(call INSTALL_TEMPLATE,$(CONFIG_DIR),config))
$(eval $(call INSTALL_TEMPLATE,$(DATA_DIR),data))
$(eval $(call INSTALL_TEMPLATE,$(HOME_DIR),home))
$(eval $(call INSTALL_TEMPLATE,$(SYSTEM_PREFIX),system))

#################################
##  Install Link Dependencies  ##
#################################

$(DATA_DIR)/libreoffice/4/cache: | $(CONFIG_DIR)/libreoffice

$(DATA_DIR)/Slack/Cache: | $(CONFIG_DIR)/Slack

###########
##  Vim  ##
###########
.PHONY: vim vim-vundle vim-plugins vim-ycm vim-tmuxline

vim: vim-vundle vim-plugins vim-ycm vim-tmuxline

VUNDLE_TARGET:=$(DATA_DIR)/$(DATA_VUNDLE_DIR)
vim-vundle: | $(VUNDLE_TARGET)

$(VUNDLE_TARGET): | $(dir $(VUNDLE_TARGET)).
	cd $(dir $@) && git clone https://github.com/VundleVim/Vundle.vim.git

vim-plugins: vim-vundle
	vim +PluginInstall +PluginUpdate +qall

YCM_DIR:=$(DATA_DIR)/vim/bundle/YouCompleteMe
YCM_CORE:=$(YCM_DIR)/third_party/ycmd/ycm_core.so
YCM_GIT_CHECKOUT:=$(YCM_DIR)/.git/logs/HEAD

PYTHON := $(shell command -v python3 || command -v python)

vim-ycm: $(YCM_CORE)

$(YCM_CORE): $(YCM_GIT_CHECKOUT)
	cd $(YCM_DIR) && \
		$(PYTHON) ./install.py --clang-completer \
		$$(if [[ "$$(uname -r)" == *ARCH* ]]; then echo --system-libclang; fi)


TMUXLINE_CONFIG:=tmux/tmuxline.conf
TMUXLINE_TARGET:=$(CONFIG_DIR)/$(TMUXLINE_CONFIG)
RANDOM_ID:=$(shell echo $$RANDOM)

vim-tmuxline: $(TMUXLINE_TARGET)

$(TMUXLINE_TARGET): \
	| $(dir $(TMUXLINE_TARGET)).
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

#########################
##  Persisent Configs  ##
#########################
.PHONY: persistent-configs

persistent-configs: $(BUILD_DIR)/make/persistent-configs

$(BUILD_DIR)/make/persistent-configs: \
		$(UTILS_DIR)/set-persistent-configs.sh \
		$(INSTALLED_SYSTEMD_FILES) \
		| $(BUILD_DIR)/make/
	$(UTILS_DIR)/set-persistent-configs.sh
	touch "$@"

######################
##  Systemd Reload  ##
######################
.PHONY: systemd-reload

systemd-reload: $(BUILD_DIR)/make/systemd-reload

SYSTEMCTL := $(shell command -v systemctl 2>/dev/null)
ifdef SYSTEMCTL
$(BUILD_DIR)/make/systemd-reload: \
		$(INSTALLED_SYSTEMD_CONFIGS) \
		| $(BUILD_DIR)/make/.
	systemctl --user daemon-reload
else
$(BUILD_DIR)/make/systemd-reload: | $(BUILD_DIR)/make/.
endif
	touch "$@"

##################
##  Font Cache  ##
##################
.PHONY: font-cache

font-cache: $(BUILD_DIR)/make/font-cache

$(BUILD_DIR)/make/font-cache: $(INSTALLED_FONTS) | $(BUILD_DIR)/make/.
	fc-cache -v $(DATA_DIR)/fonts/
	touch "$@"


########################
##  Make Directories  ##
########################
define MKDIR_DEPENDENCY_TEMPLATE
$1: | $(dir $1).
endef

# Targets that might be the first in their directory
ORIGINAL_TARGETS:=\
	$(FIRST_BUILD_TARGETS)\
	$(INSTALL_TARGETS)\
	$(INSTALL_LINK_TARGETS)\
	$(INSTALL_SYSTEM_TARGETS)\
	$(TMUXLINE_TARGET)\
	$(BUILD_DIR)/.\
	$(BUILD_DIR)/make/.\
# Exclude directories
ORIGINAL_FILE_TARGETS:=$(filter-out %/.,$(ORIGINAL_TARGETS))

$(foreach TARGET,$(ORIGINAL_FILE_TARGETS),\
	$(eval $(call MKDIR_DEPENDENCY_TEMPLATE,$(TARGET))))

# Use a template so that this rule is preferred over the generic install copy
# rule.
.PRECIOUS: %/.

define MKDIR_TEMPLATE

$1.:
	mkdir -p "$$@"
endef
$(foreach TARGET_DIR,\
	$(sort $(BUILD_DIR)/ $(BUILD_DIR)/make/ $(dir $(ORIGINAL_TARGETS))),\
	$(eval $(call MKDIR_TEMPLATE,$(TARGET_DIR))))
