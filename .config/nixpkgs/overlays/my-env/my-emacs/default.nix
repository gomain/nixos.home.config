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

  overrides = oldAttrs: {
    name = "emacs-git-with-packages-and-emacsd";
    # path to ./home directory; it is copied to nix/store/...
    # make directory $out/home and copy contents from ./home
    # contents will be linked to in ~/.nix-profile/home
    home = ./home;
    buildCommand = ''
      ${oldAttrs.buildCommand}
      echo creating $out/home/\.\.\.
      set -x
      install -dm 755 $out/home/
      cp -dr --no-preserve=ownership $home/. $out/home
      set +x
    '';
  };
 in myEmacsWithPackages.overrideAttrs overrides


