self: super:
{
  my-nix-env = with self;
    let
      myEmacs = super.callPackage ./my-emacs { };
    in buildEnv {
      name = "my-nix-env";
      paths = [
        myEmacs
        keepassxc
      ];
    };
}
