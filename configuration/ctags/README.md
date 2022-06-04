After using `stow` to link the necessary files to your `~/.config`, the included `.ctags` files should be included in your `~/.ctags` config.

The following will append all ctags files here to your main config.  You might need to go and clear it up afterwards to avoid duplicates etc.

```bash
for f in ~/.config/ctags/*.ctags
do
  echo "--options=$f" >> ~/.ctags
done
```
