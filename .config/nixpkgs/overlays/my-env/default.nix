self: super:
{

  myEmacs = import ./my-emacs self;

  my-nix-env = with self; buildEnv {
    name = "my-nix-env";
     paths = [
       my-emacs
       keepassxc
    ];
  };
}
