pkgs:
let
  emacs = pkgs.emacsGit;
  emacsWithPackages = (pkgs.emacsPackagesNgGen emacs).emacsWithPackages;
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
  myEmacsWithPackages = emacsWithPackages myEmacsPackages;
  myEmacsWithPackagesAndInit = myEmacsWithPackages.overrideAttrs (oldAttr: {
    postPhasesx = ''
      install -dm 755 $out/userHome/.emacs.d
    '';
    });
in myEmacsWithPackagesAndInit


