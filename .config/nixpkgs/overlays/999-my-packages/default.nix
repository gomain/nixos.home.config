self: super:
{
  myEmacs = import ./my-emacs.nix { super };
  myPackages = with super; buildEnv {
    name = "my-packages";
    paths = [
      myEmacs
    ];
  };
}
