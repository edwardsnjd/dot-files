(list (channel
        (name 'edwardsnjd-guix-channel)
        (url "https://github.com/edwardsnjd/guix-channel.git")
        (branch "main")
        (commit
          "030167af63b3a7113d9d800dd250d1380291b207"))
      (channel
        (name 'guix)
        (url "https://codeberg.org/guix/guix-mirror")
        (branch "master")
        (commit
          "f8c943289780c6498fbdffb0b32d2dc1b248c8c3")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
