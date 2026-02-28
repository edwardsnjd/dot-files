# Dotfiles

Personal config files.

## Dependencies

- [Stow](https://www.gnu.org/software/stow/)

## Usage

Use the appropriate top level script for your host OS e.g. `osx.sh` to install
the configuration.

## Adding a new package

1. Create a new directory under `configuration/` (e.g., `configuration/pi/`)
2. Place your config files in a subdirectory that matches the target location
   in your home directory (e.g., `configuration/pi/.pi/` → `~/.pi/`)
3. Add the package name to the `stow` command in the relevant OS script(s)
   (`osx.sh`, `kubuntu`, etc.)
