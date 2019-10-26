{ emacsGit, emacsPackagesNgGen }:
let
  emacsWithPackages = (emacsPackagesNgGen emacsGit).emacsWithPackages;
  myEmacsPackages = epkgs: with epkgs;
    (with elpaPackages; [ ace-window ])
    ++ (with melpaStablePackages; [
      edit-server
      nix-mode
      web-mode
      json-mode
      yaml-mode
      sudo-edit
      haskell-mode
      auto-complete
    ]) ++ (with melpaPackages; [
      flycheck
    ]) ++ [ ];
  myEmacsWithPackages = emacsWithPackages myEmacsPackages;

  overrides = oldAttrs: {
    name = "emacs-git-with-packages-and-emacsd";
    # path to ./home directory; it is copied to nix/store/...
    home = ./home;
    # make directory $out/home and copy contents from ./home
    # these will installed in ~/.nix-profile/home
    # intended tobe copied into ~/ of target installation
    buildCommand = let
      extraCommand = ''
        install -dm 755 $out/home/
        cp -dr --no-preserve=ownership $home/. $out/home
      '';
    in oldAttrs.buildCommand + extraCommand;
  };
 in myEmacsWithPackages.overrideAttrs overrides


