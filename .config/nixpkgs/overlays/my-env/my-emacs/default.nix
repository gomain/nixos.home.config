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
  overrides = oldAttrs:
  let
    src = ./.;
    userHome = out + /userHome;
  in {
    pname = "emacs-git-with-packages-and-config";
    buildCommand = ''
      ${oldAttrs.buildCommand}
      echo creating $userHome/.emacs.d
      install -dm 755 $userHome
      cp -dr --no-preserve=ownership $src/.emac.d $userHome
    '';
  };
 in myEmacsWithPackages.overrideAttrs overrides


