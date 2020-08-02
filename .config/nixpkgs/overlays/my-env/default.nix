self: super:
let
  myEmacs = super.callPackage ./my-emacs { };
  my-nix-env = super.buildEnv {
    name = "my-nix-env";
    paths = with self; [
      aesop
      bat
      chromium
      expect
      file
      firefox
      git
      imagemagick # provides `import` command used to take screenshots
      inotify-tools
      keepassxc
      libreoffice
      multimarkdown # provides `markdown` command used by emacs' `markdown-mode`
      myEmacs
      nix-prefetch-git
      nixfmt # used by emacs command: nix-format-buffer
      pciutils
      rclone
      tmux
      unzip
      xclip
      xorg.appres
      zip
    ];
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

