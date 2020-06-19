# Dotfiles

Personal config files.

## Dependencies

- [Git](https://git-scm.com/)
- [Stow](https://www.gnu.org/software/stow/)
- [Homebrew](https://brew.sh/) (for OS X packages)

## Usage

Clone this repo then use stow to install symlinks to the bits you want.

```sh
$ git clone https://github.com/edwardsnjd/dot-files.git ~/.dot-files
$ cd ~/.dot-files
$ stow bash git
```
