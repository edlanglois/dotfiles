# Dot-Files
Configuration files along with a system to patch or append to them based on
arbitrary conditions.

Configuration files and directories are stored at the root level of the repository.

## Patches
Patches are stored in sub-directories. Each patch directory must contain an
executable file called `applies` which returns with an exit code of 0 when the
contents of that directory are to be applied.

A file named `CONFIG_FILE.patch` in a patch directory will be applied as a patch
to `CONFIG_FILE` while `CONFIG_FILE.append` will be appended. Use the `.append`
version whenever possible since it is less likely to fail.

Note that patches and appends cannot be applied to the contents of configuration
directories, only to configuration files.

## Installation
```Shell
./configure.sh
make
make install
```

`./configure.sh` checks `applies` in each sub-directory and creates a Makefile
that will apply the appropriate modifications. `configure.sh` must be re-run
whenever you want to re-evaluate existing `applies` or add new patch
directories.

`make` creates patched versions of the configuration files in the `prep/`
directory.

`make install` places the configuration files in your home directory. Soft links
to the configuration folders are also created in your home directory.
_WARNING: This irrecoverably overwrites existing configuration files with the
same names!_

## Adding new files or directories
New configuration files and directories should be placed in the root directory
of the repository. `configure.sh` must be modified whenever configuration files
or directories are added or removed. Configuration file names must be added to
the variable `dotfiles` in `configure.sh` while directories must be added to
`dotdirs`.

A new patch directory is created by placing an executable file named `applies`
within a new directory. `configure.sh` must be re-run after creating or removing
patch directories.

