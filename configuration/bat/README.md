# Bat

See the [instructions on adding a theme](https://github.com/sharkdp/bat#adding-new-themes).

Download a theme in '.tmTheme' format:

```sh
mkdir -p bat/.config/bat/themes
cd !$
git clone https://github.com/batpigandme/night-owlish
```

Then after making this available via stow, update the binary cache:

```sh
bat cache --build
```
