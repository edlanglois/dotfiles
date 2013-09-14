#!/bin/bash
shopt -s nullglob
shopt -s dotglob

prep_dir=prep
patch_dir=.patch
dotfiles=(.bash_aliases .bashrc .gitconfig .hgrc .profile .tmux.conf .vimrc)
dotdirs=(.vim)
patchdirs=($(find * -maxdepth 1 -name applies -exec dirname {} \;))

if cp --help 2>&1 | grep remove-destination &>/dev/null; then
	cpbin=cp
elif [ -x /bin/cp ] && /bin/cp --help 2>&1 | grep remove-destination &>/dev/null; then
	cpbin=/bin/cp
else
	echo "Could not find a valid cp command. Need --remove-destination argument."
fi

rm -f Makefile
echo "# ******************** Autogenerated ******************** 
# * This file was autogenerated by configure.sh         *
# * Any changes will be overwritten on next configure.  *
# *******************************************************

PREP_DIR:=${prep_dir}
PATCH_DIR:=${patch_dir}
DOTFILES:=${dotfiles[@]}
PREPARED_DOTS:=\$(addprefix \$(PREP_DIR)/, \$(DOTFILES))
DOTDIRS:=${dotdirs[@]}

.SUFFIXES:
.PHONY: all prepare linkdirs \$(DOTDIRS)
all: prepare
prepare: \$(PREPARED_DOTS)
install: prepare linkdirs
	${cpbin} --remove-destination \$(PREPARED_DOTS) \$(HOME)
clean:
	rm -rf \$(PREP_DIR) \$(PATCH_DIR)
linkdirs: \$(DOTDIRS)
\$(DOTDIRS): % :
	ln -sf \$(CURDIR)/\$@ \$(HOME)/\$@
\$(PREP_DIR):
	mkdir \$(PREP_DIR)
\$(PATCH_DIR):
	mkdir \$(PATCH_DIR)
\$(PREPARED_DOTS): \$(PREP_DIR)/% : % \$(PATCH_DIR)/%.patch \$(PATCH_DIR)/%.append | \$(PREP_DIR) 
	cp \$< \$(PREP_DIR)
	if [ -s \"\$(PATCH_DIR)/\$<.patch\" ]; then \\
	patch \"\$(PREP_DIR)/\$<\" \"\$(PATCH_DIR)/\$<.patch\"; \\
	fi
	if [ -s \"\$(PATCH_DIR)/\$<.append\" ]; then \\
	cat \"\$(PATCH_DIR)/\$<.append\" >> \"\$(PREP_DIR)/\$<\"; \\
	fi
" > Makefile

config_dir=/tmp/_dotfiles_config
mkdir -p "${config_dir}"
for patchdir in "${patchdirs[@]}"; do
	if "${patchdir}/applies"; then
		for patchfile in "${patchdir}"/*.patch; do
			if [ -z ${patchfile} ]; then
				break;
			fi
			patchbase="$(basename "$patchfile" | sed 's/\.[^.]*$//')"
			echo -n "${patchfile} " >> "${config_dir}/${patchbase}"
		done
		for appendfile in "${patchdir}"/*.append; do
			if [ -z ${appendfile} ]; then
				break;
			fi
			appbase="$(basename "$appendfile" | sed 's/\.[^.]*$//').append"
			echo -n "${appendfile} " >> "${config_dir}/${appbase}"
		done
	fi
done

for dfile in "${dotfiles[@]}"; do
	touch "$config_dir/$dfile"
	d_patches=($(cat "${config_dir}/$dfile"))

	dpatch="$dfile.patch"
	echo "\$(PATCH_DIR)/$dpatch: ${d_patches[@]} | \$(PATCH_DIR)" >> Makefile
	echo "	rm -f \$@ && touch \$@" >> Makefile
	if [ -n "$d_patches" ]; then
		for d_patch in "${d_patches[@]}"; do
			echo "	combinediff \"\$(PATCH_DIR)/$dpatch\" \"${d_patch}\" > \"\$(PATCH_DIR)/$dpatch\"" >> Makefile
		done
	fi

	touch "$config_dir/$dfile.append"
	d_appends=($(cat "$config_dir/$dfile.append"))
	
	dapp="$dfile.append"
	echo "\$(PATCH_DIR)/$dapp: ${d_appends[@]} | \$(PATCH_DIR)" >> Makefile
	echo "	rm -f \$@ && touch \$@" >> Makefile
	if [ -n "$d_appends" ]; then
		for d_app in "${d_appends[@]}"; do
			echo "	cat \"$d_app\" >> \"\$(PATCH_DIR)/$dapp\"" >> Makefile
		done
	fi
done
rm -rf "$config_dir"
