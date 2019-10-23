self: super:
{
  my-nix-env = with self;
    let
      myEmacs = import ./my-emacs self;
    in buildEnv {
      name = "my-nix-env";
      paths = [
        myEmacs
        keepassxc
      ];
    };
}
