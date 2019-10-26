self: super:
{
  my-nix-env = with self;
    let
      myEmacs = with super; callPackage ./my-emacs { };
    in buildEnv {
      name = "my-nix-env";
      paths = [
        xorg.appres
        chromium
        cypress
        myEmacs
        expect
        keepassxc
        nixfmt
        nodejs-10_x
        nodePackages.node2nix
        nodePackages.npm
        pciutils
        unzip
        xclip
        zip
      ];
    };
}
