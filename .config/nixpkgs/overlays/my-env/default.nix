self: super:
let
  myEmacs = super.callPackage ./my-emacs { };
  my-nix-env = super.buildEnv {
    name = "my-nix-env";
    paths = with self; [
      # removed from nixpkgs
      # aesop
      bat
      bfg-repo-cleaner # tool for rewriting git history
      exercism
      expect
      file
      firefox
      git
      git-lfs
      gh # official github cli
      graphviz
      htop
      imagemagick # provides `import` command used to take screenshots
      insomnia # an api client
      inotify-tools
      ispell # provides `ispell` command used by emacs' `flyspell-mode`
      keepassxc
      libreoffice
      lilypond
      multimarkdown # provides `markdown` command used by emacs' `markdown-mode`
      myEmacs
      nix-prefetch-git
      nixfmt # used by emacs command: nix-format-buffer
      nodePackages.node2nix
      pciutils
      postman # an api client
      rclone
      sbcl # a Common Lisp implementation
      slack
      tdesktop # official client for Telegram chat: telegram-desktop
      tmux
      tree
      unzip
      # vivaldi finds driver but very poor performance
      xclip

      xorg.appres
      zip
      # insecure packages
      # chromium
      # xpdf
    ]
    /* ++ [
         haskellPackages.ghcWithPackages (hsPkgs: with hsPkgs; [ xmonad ])
       ]
    */
    ;
    postBuild = ''
      # echo "...ls -la $out/share..."
      # ls -la $out/share
      echo "Making directory \`$out/share/bash-completion/completions/\` if not exits..."
      mkdir -p $out/share/bash-completion/completions/
      echo "Installing rclone completions..."
      $out/bin/rclone genautocomplete bash $out/share/bash-completion/completions/rclone
    '';
  };
in { inherit my-nix-env; }

