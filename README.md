# Dot-Files
Configuration files along with a system to patch or append to them based on
arbitrary conditions.

## Get the Code
Clone this directory recursively with
```Shell
git clone --recursive <url>
```
or if already cloned:
```Shell
git submodule update --init --recursive
```

## Installation
### User Information
In the `dotfiles` directory, create the file `info.cfg` with the lines
```
NAME=<your name>
EMAIL=<your email>
```
see also `info.cfg.example`.

### Configure and Install
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

### Vim Set-up
Vundle is used to manage vim plugins. After initializing all submodules open vim
and run
```Shell
:PluginInstall
```
then navigate to `dotfiles/.vim/bundle/YouCompleteMe` and run
```Shell
./install.sh --clang-completer
```
Navigate to `dotfiles/.vim/bundle/color_coded` and run
```Shell
mkdir build && cd build
cmake ..
make && make install
```

## Flake8
Install flake8 for python linting in VIM (with F7)
```Shell
pip install flake8
```


### Powerline Fonts
Install the [patched powerline fonts](https://github.com/powerline/fonts).

## Configuration
### Patches
Patches are stored in sub-directories. Each patch directory must contain an
executable file called `applies` which returns with an exit code of 0 when the
contents of that directory are to be applied.

A file named `CONFIG_FILE.patch` in a patch directory will be applied as a patch
to `CONFIG_FILE` while `CONFIG_FILE.append` will be appended. Use the `.append`
version whenever possible since it is less likely to fail.

Note that patches and appends cannot be applied to the contents of configuration
directories, only to configuration files.

## Adding new files or directories
New configuration files and directories should be placed in the root directory
of the repository. `configure.sh` must be modified whenever configuration files
or directories are added or removed. Configuration file names must be added to
the variable `dotfiles` in `configure.sh` while directories must be added to
`dotdirs`.

A new patch directory is created by placing an executable file named `applies`
within a new directory. `configure.sh` must be re-run after creating or removing
patch directories.

