# Bat

See the [instructions on adding a theme](https://github.com/sharkdp/bat#adding-new-themes).

[`night-owlish` theme](https://github.com/batpigandme/night-owlish) is my terminal theme, so we add that `tmTheme` file.

There are some minor improvements we can make to this theme, so use `update.sh` to download and patch the theme file:

```bash
./update-theme.sh
```

Then after making this available via stow, update the binary cache:

```sh
bat cache --build
```
