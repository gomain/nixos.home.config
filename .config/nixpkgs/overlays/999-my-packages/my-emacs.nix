pkgs:
let
  myEmacs = pkgs.emacsGit;
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;
  myEmacsPackages = epkgs:
    (with epkgs.elpaPackages; [ ace-window ])
    ++ (with epkgs.melpaStablePackages; [
      edit-server
      nix-mode
      web-mode
      json-mode
      yaml-mode
      sudo-edit
      haskell-mode
      auto-complete
    ]) ++ (with epkgs.melpaPackages; [
      flycheck
    ]) ++ [ ];
in emacsWithPackages myEmacsPackages


