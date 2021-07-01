# Bat

See the [instructions on adding a theme](https://github.com/sharkdp/bat#adding-new-themes).

[`night-owlish` theme](https://github.com/batpigandme/night-owlish) is my terminal theme, so I dropped in that `tmTheme` file:

```sh
mkdir -p bat/.config/bat/themes
cd !$
curl https://raw.githubusercontent.com/batpigandme/night-owlish/master/tmTheme/night-owlish.tmTheme > night-owlish.tmTheme
```

Manually update some scopes as per other bat themes.  See git history `git log -S "Extend scopes"` for where to make the changes.

Then after making this available via stow, update the binary cache:

```sh
bat cache --build
```
