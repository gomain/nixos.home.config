self: super:
{
  myEmacs = import ./my-emacs.nix self;

  myPackages = with self; buildEnv {
    name = "my-packages";
     paths = [
      myEmacs
    ];
  };
}
