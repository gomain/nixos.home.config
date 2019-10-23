self: super:
{
  myEmacs = import ./my-emacs self;

  myPackages = with self; buildEnv {
    name = "my-packages";
     paths = [
      myEmacs
    ];
  };
}
