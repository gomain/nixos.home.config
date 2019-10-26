self: super:
{
  my-nix-env = with self;
    let
      myEmacs = with super; callPackage ./my-emacs { };
      myNodejs = [ nodejs-slim-10_x ] ++ (with nodePackages_10_x; [ node2nix npm ]);
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
        pciutils
        unzip
        xclip
        zip
      ] ++ myNodejs;
    };
}
