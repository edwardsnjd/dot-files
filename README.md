# Dotfiles

Personal config files and scripts for automatically installing my daily driver tooling.

This is all very specific to my workflow and preferences.  See `README.md` files scattered around this repo for some more detail on the individual pieces.

## Dependencies

Config:

- [Git](https://git-scm.com/)
- [Stow](https://www.gnu.org/software/stow/)

Tools:

- [Homebrew](https://brew.sh/) (for MacOS packages)
- [apt](https://en.wikipedia.org/wiki/APT_(software)) (for Linux packages)
- [Chocolatey](https://chocolatey.org/) (for Windows packages)

## Structure

```
├── configuration/      # 📄 Personal config and scripts
└── tools/
    ├── apt/            # 📦 Linux tooling (WSL)
    ├── chocolatey/     # 📦 Windows tooling
    ├── homebrew/       # 📦 MacOS tooling (home)
    └── homebrew-work/  # 📦 MacOS tooling (work)
```

## Usage

**Bootstrapping a new system**

1. Pick an `install` script for the tools:

    ```
    tools/
    ├── apt/
    │   └── install.sh
    ├── chocolatey/
    │   └── install.ps1
    ├── homebrew/
    │   └── install.sh
    └── homebrew-work/
        └── install.sh
    ```

2. Pick an install script for the config:

    ```
    configuration/
    ├── osx.sh
    ├── ubuntu.sh
    └── windows.sh
    ```

**Updating packages**

1. Run the appropriate `upgrade` script:

    ```
    tools/
    ├── apt/
    │   └── upgrade.sh
    ├── chocolatey/
    │   └── upgrade.ps1
    ├── homebrew/
    │   └── upgrade.sh
    └── homebrew-work/
        └── upgrade.sh
    ```

2. Run the appropriate install script again:

    ```
    configuration/
    ├── osx.sh
    ├── ubuntu.sh
    └── windows.sh
    ```
