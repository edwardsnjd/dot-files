# Vim Setup

Vim is configured via a single `.vimrc` config file.

Plugins are managed by `vim-plugin` and configured in the `.vimrc` file.

## Install `vim-plugin`

```sh
#!/bin/sh

# See: https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Usage

Inside Vim issue commands to update the plugins:

```
:PlugUpdate
```

