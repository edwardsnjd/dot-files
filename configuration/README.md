# Dotfiles

Personal config files.

## Dependencies

- [Git](https://git-scm.com/)
- [Stow](https://www.gnu.org/software/stow/)
- [Homebrew](https://brew.sh/) (for OS X packages)

## Usage

Clone this repo then use stow to install symlinks to the bits you want.

```sh
$ cd ~/projects
$ git clone https://github.com/edwardsnjd/dot-files.git
$ cd dot-files
$ stow --target=/Users/foo bash git tmux vim
```
