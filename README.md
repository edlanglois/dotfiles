# Dotfiles
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

### Manual Configuration (Optional)
Run `make show-wants` to check other configurations that can only be applied
manually, mostly optional programs to install.
The output of `make show-config` can also be helpful to notice what could be
installed but that output makes no distinction between checks that enable
features and checks that enable configuration for that program.

This repository attempts to install a number of symbolic links.
Check the status of these with `make show-links`.
If the target already exists as a regular file or directory then the link is not
created. You can optionally move the file to the intended link destination
(see the corresponding `.link` file within `build/` to find the destination)
and re-run `make install` to create the links.

### Extras
Decide on a case-by-case basis whether to run these.

Various persistent configurations: `utils/set-persistent-configs.sh`
Powerline symbols: `utils/install-powerline-symbols.sh`
Noto fonts: `utils/install-noto-fonts.sh`
And more in `utils/`

### Help
Run `make help` to see a list of available Makefile commands.

You can run `make show` to show lots of information including
the detected user and environment configurations (`make show-configs`),
install directories (`make show-dirs`),
and desirable programs / manual configurations (`make show-wants`).

## Structure
Dotfiles are organized within the `src/` directory based on where they are to
be installed.
The install paths are configurable in `user.cfg`.
The top-level directories are:

| Source Dir | Install To        | Default Install Path | Description      |
| ---------- | ----------------- | -------------------- | ---------------- |
| bin        | LOCAL\_PREFIX/bin | $HOME/.local/bin     | Executable files |
| config     | XDG\_CONFIG\_HOME | $HOME/.config        | Configurations   |
| data       | XDG\_DATA\_HOME   | $HOME/.local/share   | Program data     |
| home       | HOME              | $HOME                | Configurations   |
| system     | SYSTEM\_PREFIX    | /                    | System configs   |

The directory `src/env` is special, it contains environment detection scripts
and is not installed. See the _Environment Detection_ section for more details.

Within each source directory (`bin`, `config`, etc.) files have the same
relative path as they will have when installed.

There are several kinds of configuration files: raw, M4, and links.
These can be distinguished by their extension, which is stripped before
install.

### Raw files
These files have no special extension and are installed by copying them into the
install location without changes.

### M4 files
These files are configured for the user and environment using the
[M4 preprocessor](https://www.gnu.org/software/m4/m4.html).
Each has the extension `.m4`. User configuration variables are specified in
`user.cfg` and written to `user_config.m4`. Environment configuration variables
are emitted by shell scripts (in `env/`) and saved to `env_config.m4`.

When developing M4 files, macros must be prefixed with `m4_`.
Use `m4_include(user_config.m4)` and `m4_include(env_config.m4)` to import user
and environment configuration variables, respectively.
M4 does not allow escaping of quotes, so to avoid collisions, this project uses
`{<<` and `>>}` as left and right quotes.

### Links
Links end with `.link` or `.dlink` and cause a symbolic link to be installed
pointing to the path given by the contents of the link file.
Directory links (`.dlink`) also create a directory at the link destination.
Link files can also be M4 files (`.link.m4`) in order to make the link
destination (i.e. link file contents) configurable.

### Environment Detection
Executable files in `env/` are used to detect features of the environment that
can be then applied to configure M4 files.
Each script should output any number of lines of the form:
`SETTING_NAME=some value`,
which will be transformed into an m4 macro named `m4_env_config_SETTING_NAME`
with value `some value`.

Scripts can also output comment lines that start with the `#` character.
These are displayed in the output of `make show-config`.

### Environment Variables
New environment variables should be defined in
`src/config/security/pam_env.conf.m4`.
See `man pam_env` for more information about this system.
These assignments take place upon login so changes will not be visible until
logging out and back in.
If possible, conditionally enable the variable creation by checking for the
relevant program in `src/env/programs` (or another script in `src/env/`).

If an existing environment variable needs to be modified or otherwise given
a dynamic assignment (e.g. appending to `$PATH`) then use
`src/config/env_profile.m4`. This file is read on shell startup.

## Development
### Pre-commit
Set up pre-commit hooks by installing the [pre-commit](http://pre-commit.com)
package (`pip install pre-commit`) and running

```bash
pre-commit install
```
