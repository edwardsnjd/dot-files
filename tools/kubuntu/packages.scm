;; This "manifest" file can be passed to 'guix package -m' to reproduce
;; the content of your profile.  This is "symbolic": it only specifies
;; package names.  To reproduce the exact same profile, you also need to
;; capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(specifications->manifest
  (list "nb"
        "gnuplot"
        "ansible"
        "wl-clipboard"
        "keepassxc"
        "openscad"
        "newsboat"
        "feedgnuplot"
        "hledger"
        "w3m"
        "openjdk"
        "visidata"
        "graphviz"
        "nushell"
        "encfs"
        "git-delta"
        "bat"
        "fzf"
        "datamash"
        "moreutils"
        "ripgrep"
        "pandoc"
        "du-dust"
        "hexyl"
        "fd"
        "nmap"
        "gcal"
        "make"
        "universal-ctags"
        "recutils"
        "tmux"
        "entr"
        "stow"
        "rlwrap"
        "htop"
        "tree"
        "syncthing"
        "lf"
        "curl"
        "guile"
        "nss-certs"
        "glibc-locales"))
