m4_include(user_config.m4)m4_dnl
ROOT=1 # Set to 0 to install to $HOME

ifeq ($(ROOT),0)
INSTALL_PREFIX=$(HOME)
CHECKINSTALL=
else
INSTALL_PREFIX=/usr
CHECKINSTALL= checkinstall --fstrans=no --backup=no --maintainer=m4_user_config_EMAIL --pkgname=$(1) --provides=$(1)
endif


SOURCE_PREFIX:=$(shell if [ -z "$$SUDO_USER" ]; then echo "$$HOME"; else echo $$(getent passwd "$$SUDO_USER" | cut -d: -f6); fi)
SOURCE_DIR_NAME=src
SOURCE_PATH=$(SOURCE_PREFIX)/$(SOURCE_DIR_NAME)

GIT_REPO_NAME=git
GIT_REPO_ORIGIN_URL=https://github.com/git/$(GIT_REPO_NAME).git
GIT_REPO_PATH=$(SOURCE_PATH)/$(GIT_REPO_NAME)

VIM_REPO_NAME=vim
VIM_REPO_ORIGIN_URL=https://code.google.com/p/vim
VIM_REPO_PATH=$(SOURCE_PATH)/$(VIM_REPO_NAME)

LLVM_REPO_ORIGIN_URL=http://llvm.org/svn/llvm-project/llvm/trunk
LLVM_REPO_PATH=$(SOURCE_PATH)/llvm

CLANG_REPO_ORIGIN_URL=http://llvm.org/svn/llvm-project/cfe/trunk
CLANG_REPO_PATH=$(LLVM_REPO_PATH)/tools/clang

CLANG_TOOLS_REPO_ORIGIN_URL=http://llvm.org/svn/llvm-project/clang-tools-extra/trunk
CLANG_TOOLS_REPO_PATH=$(CLANG_REPO_PATH)/tools/extra

LLVM_COMPILER_RT_ORIGIN_URL=http://llvm.org/svn/llvm-project/compiler-rt/trunk
LLVM_COMPILER_RT_REPO_PATH=$(LLVM_REPO_PATH)/projects/compiler-rt

CLANG_BUILD_PATH=$(SOURCE_PATH)/llvm-build

NUM_CORES=$(shell grep -c ^processor /proc/cpuinfo)
MAKE_THREADS=$(shell expr 2 \* $(NUM_CORES))

.PHONY: all FORCE \
git install-git apt-remove-git update-git-repo \
vim install-vim apt-remove-vim update-vim-repo \
clang install-clang update-clang-repos update-llvm-repo \
update-clang-tools-repo update-llvm-compiler-rt-repo

all: git vim

install: install-git install-vim

########### GIT ##########
git: update-git-repo
	$(MAKE) -C $(GIT_REPO_PATH) prefix=$(INSTALL_PREFIX) all doc info

install-git:
	cd $(GIT_REPO_PATH) && $(call CHECKINSTALL,git) \
		make prefix=$(INSTALL_PREFIX) install install-doc install-html install-info

apt-remove-git:
	apt-get remove git git-man

update-git-repo: FORCE | $(GIT_REPO_PATH)
	git --git-dir $(GIT_DOT_GIT_PATH) fetch origin master:master
	git --git-dir $(GIT_DOT_GIT_PATH) merge origin/master origin
	cd $(GIT_REPO_PATH) && git checkout master

$(GIT_REPO_PATH): | $(SOURCE_PATH)
	git clone $(GIT_REPO_ORIGIN_URL) $(GIT_REPO_PATH)

########### VIM ##########
vim: update-vim-repo $(VIM_REPO_PATH)/Makefile
	$(MAKE) -C $(VIM_REPO_PATH)

$(VIM_REPO_PATH)/Makefile: $(VIM_REPO_PATH)/configure FORCE
	cd $(VIM_REPO_PATH) && \
		./configure --with-features=huge \
		            --enable-multibyte \
		            --enable-rubyinterp \
		            --enable-pythoninterp \
		            --enable-perlinterp \
		            --enable-luainterp \
		            --enable-cscope \
		            --prefix=$(INSTALL_PREFIX)

update-vim-repo: FORCE | $(VIM_REPO_PATH)
	cd $(VIM_REPO_PATH) && hg pull
	cd $(VIM_REPO_PATH) && hg update

$(VIM_REPO_PATH): | $(SOURCE_PATH)
	hg clone $(VIM_REPO_ORIGIN_URL) $(VIM_REPO_PATH)

install-vim:
	cd $(VIM_REPO_PATH) && $(call CHECKINSTALL,vim) \
		make install

apt-remove-vim:
	apt-get remove vim vim-runtime gvim vim-tiny vim-common vim-gui-common

########## LLVM & CLANG ##########

clang: update-clang-repos $(CLANG_BUILD_PATH)/Makefile
	$(MAKE) -C $(CLANG_BUILD_PATH) ENABLE_OPTIMIZED=1

install-clang:
	cd $(CLANG_BUILD_PATH) && $(call CHECKINSTALL,clang) \
		make install

$(CLANG_BUILD_PATH)/Makefile: $(LLVM_REPO_PATH)/configure FORCE | $(CLANG_BUILD_PATH)
	cd $(CLANG_BUILD_PATH) && CC=clang CXX=clang++ $(LLVM_REPO_PATH)/configure --prefix=$(INSTALL_PREFIX)

$(CLANG_BUILD_PATH):
	mkdir -p $(CLANG_BUILD_PATH)

update-clang-repos: update-llvm-repo update-clang-repo update-clang-tools-repo update-llvm-compiler-rt-repo

update-llvm-repo: FORCE | $(LLVM_REPO_PATH)
	cd $(LLVM_REPO_PATH) && svn update

update-clang-repo: FORCE | $(CLANG_REPO_PATH)
	cd $(CLANG_REPO_PATH) && svn update

update-clang-tools-repo: FORCE | $(CLANG_TOOLS_REPO_PATH)
	cd $(CLANG_TOOLS_REPO_PATH) && svn update

update-llvm-compiler-rt-repo: FORCE | $(LLVM_COMPILER_RT_REPO_PATH)
	cd $(LLVM_COMPILER_RT_REPO_PATH) && svn update

$(LLVM_REPO_PATH): | $(SOURCE_PATH)
	svn co $(LLVM_REPO_ORIGIN_URL) $(LLVM_REPO_PATH)

$(CLANG_REPO_PATH): | $(LLVM_REPO_PATH)
	svn co $(CLANG_REPO_ORIGIN_URL) $(CLANG_REPO_PATH)

$(CLANG_TOOLS_REPO_PATH): | $(CLANG_REPO_PATH)
	svn co $(CLANG_TOOLS_REPO_ORIGIN_URL) $(CLANG_TOOLS_REPO_PATH)

$(LLVM_COMPILER_RT_REPO_PATH): | $(LLVM_REPO_PATH)
	svn co $(LLVM_COMPILER_RT_ORIGIN_URL) $(LLVM_COMPILER_RT_REPO_PATH)


LLVM_COMPILER_RT_ORIGIN_URL=http://llvm.org/svn/llvm-project/compiler-rt/trunk
LLVM_COMPILER_RT_REPO_PATH=$(LLVM_REPO_PATH)/projects/compiler-rt

########### General ##########
$(SOURCE_PATH):
	mkdir -p $(SOURCE_PATH)

FORCE: