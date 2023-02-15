{ emacs, emacsPackagesFor }:
let
  emacsWithPackages = (emacsPackagesFor emacs).emacsWithPackages;
  myEmacsPackages = epkgs:
    with epkgs;
    let
      emacsPkgs = [ graphviz-dot-mode ];
      # curl: (22) The requested URL returned error: 404
      # error: cannot download ace-window-0.9.0.el from any mirror
      elpaPkgs = with elpaPackages; [ /* ace-window */ ];
      melpaStablePkgs = with melpaStablePackages; [
        auto-complete
        company
        edit-server
        flyspell-correct
        haskell-mode
        js2-mode
        js2-refactor
        json-mode
        markdown-mode
        move-text
        nix-mode
        sudo-edit
        tide
        typescript-mode
        unisonlang-mode
        web-mode
        xref-js2
        yaml-mode
      ];
      melpaPkgs = with melpaPackages; [
        # purescript-mode changed to local git clone ~/purescript-mode
        dhall-mode
        flycheck
        lsp-mode
        lsp-treemacs
        magit
        psc-ide
        psci
        repl-toggle
        rustic
        slime # mode for Lisp
        treemacs
        treemacs-magit
      ];
    in emacsPkgs ++ elpaPkgs ++ melpaStablePkgs ++ melpaPkgs;
in emacsWithPackages myEmacsPackages

# overrides = oldAttrs: {
#   name = "emacs-with-packages-and-emacsd";
#   # relative path to .emacs.d directory; it is copied to nix/store/...
#   home = ./home;
#   # make directory $out/home and copy contents from ./home
#   # these will be installed (symlinked) in ~/.nix-profile/home
#   # intended tobe copied into ~/ of target user installation
#   #buildCommand = let
#   #  extraCommand = ''
#   #    install -dm 755 $out/home
#   #    cp -dr --no-preserve=ownership $home/. $out/home/.
#   #  '';
#   #in oldAttrs.buildCommand + extraCommand;
