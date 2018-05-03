# Dot-Files
Configuration files with user & system configuration based on M4.


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
In the `dotfiles` directory, copy `user.cfg.example` to `user.cfg` and fill in
the variables.
See `utils/weather-city-id.py` to get your city ID for weather.

### Build and Install
```Shell
make
make install
make vim
```
If you have root access, system-wide configurations are installed with
```Shell
sudo make install-system
```

## Flake8
Install flake8 for python linting in VIM (with F7)
```Shell
pip install flake8
```

## Extras
Various persistent configurations: `utils/set-persistent-configs.sh`
Powerline symbols: `utils/install-powerline-symbols.sh`
Noto fonts: `utils/install-noto-fonts.sh`
And more in `utils/`


## Making Changes
The dotfiles are built for a specific user and system using the
[m4 preprocessor](https://www.gnu.org/software/m4/m4.html). The source for each
dotfile is a `.m4` file. User configuration variables are specified in
`user.cfg` and written to `user_config.m4`. Environment configuration variables
are emitted by shell scripts (in `env/`) and saved to `env_config.m4`.

### New File
To create a new dotfile named `NAME`, create the file `NAME.m4` in the same
location relative to `dotfiles/` that the installed file is to be relative to
`$HOME/`. Add `NAME` to the `DOTFILES` variable in `Makefile`.

The contents of the file will be processed using m4. The file contents will be
passed through unchanged unless m4 macros are present. m4 macros may be used for
configuration, and must be prefixed with `m4_`.

Use `m4_include(user_config.m4)` and `m4_include(env_config.m4)` to import user
and environment configuration variables, respectively.

### New Directory
To create a new directory, create it in `dotfiles/` and add its name to the
`DOTDIRS` variable in `Makefile`. A symbolic link will be created from within
`$HOME` to this directory. 

### New Environment Configuration
Create an executable script in the `env/` directory that outputs lines of the
form `NAME=VALUE`. If no value is necessary, the script can output `NAME=` but
the `=` is always required. The set of variables emitted is permitted to vary.
Add the script to the `ENV_CONFIG_FILES` variable in `Makefile`.

The emitted variables will be saved to `env_config.m4` under the name
`m4_env_config_NAME`, where `NAME` is the name emitted by the script.
