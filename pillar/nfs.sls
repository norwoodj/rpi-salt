nfs:
  server:
    exports:
      '/nfs': >
        rp3-sma-kbw-000(rw,sync,no_subtree_check)
        rp3-smi-kbw-nfs-000(rw,sync,no_subtree_check)
        rp3-smi-kbm-git-000(rw,sync,no_subtree_check)
