#!/bin/bash
shopt -s nullglob
shopt -s dotglob

prep_dir=prep
patch_dir=.patch
dotfiles=(.gitconfig .vimrc .bashrc)
dotdirs=(.vim)
patchdirs=(waterloo)

rm -f Makefile
echo "
PREP_DIR:=${prep_dir}
PATCH_DIR:=${patch_dir}
DOTFILES:=${dotfiles[@]}
PREPARED_DOTS:=\$(addprefix \$(PREP_DIR)/, \$(DOTFILES))
DOTDIRS:=${dotdirs[@]}

.PHONY: all prepare linkdirs \$(DOTDIRS)
all: prepare
prepare: \$(PREPARED_DOTS)
install: prepare linkdirs
	cp \$(PREPARED_DOTS) \$(HOME)
clean:
	rm -rf \$(PREP_DIR) \$(PATCH_DIR)
linkdirs: \$(DOTDIRS)
\$(DOTDIRS): % :
	ln -sf \$(CURDIR)/\$@ \$(HOME)/\$@
\$(PREP_DIR):
	mkdir \$(PREP_DIR)
\$(PATCH_DIR):
	mkdir \$(PATCH_DIR)
\$(PREPARED_DOTS): \$(PREP_DIR)/% : % \$(PREP_DIR) \$(PATCH_DIR)/%.patch
	cp \$< \$(PREP_DIR)
	if [ -e \"\$(PATCH_DIR)/\$<.patch\" ]; then \\
	patch \"\$(PREP_DIR)/\$<\" \"\$(PATCH_DIR)/\$<.patch\"; \\
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
			echo "${patchfile}"
			echo "${config_dir}/${patchbase}"
			echo -n "${patchfile} " >> "${config_dir}/${patchbase}"
		done
	fi
done

for dfile in "${dotfiles[@]}"; do
	touch "$config_dir/$dfile"
	d_patches=($(cat "${config_dir}/$dfile"))

	dpatch="$dfile.patch"
	echo "\$(PATCH_DIR)/$dpatch: \$(PATCH_DIR) ${d_patches[@]}" >> Makefile
	if [ -z "$d_patches" ]; then
		continue;
	fi

	echo "	cp ${d_patches[0]} \$(PATCH_DIR)/$dpatch" >> Makefile
	for d_patch in "${d_patches[@]:1}"; do
		echo "	combinediff \$(PATCH_DIR)/$dpatch ${d_patch} > \$(PATCH_DIR)/$dpatch" >> Makefile
	done
done
rm -rf "$config_dir"
