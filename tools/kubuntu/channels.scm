(list (channel
        (name 'edwardsnjd-guix-channel)
        (url "https://github.com/edwardsnjd/guix-channel.git")
        (branch "main")
        (commit
          "15bece21808e2f15cc096b9c8628e3d23fe7ddef"))
      (channel
        (name 'guix)
        (url "https://codeberg.org/guix/guix-mirror")
        (branch "master")
        (commit
          "9245f57207c81ced0b4780f88a97a441a86b7790")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
