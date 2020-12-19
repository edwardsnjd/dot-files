Install homebrew: https://brew.sh/

Install all packages:

```sh
$ brew bundle install
```

Add a formula:
```sh
$ cat 'brew "foo"' >> Brewfile
$ brew bundle install
```

Rebuild the dump file:
```sh
$ rm Brewfile*
$ brew bundle dump
$ brew bundle install
```
