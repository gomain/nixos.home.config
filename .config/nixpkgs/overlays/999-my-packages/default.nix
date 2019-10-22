self: super:
{
  myEmacs = import ./my-emacs.nix { super };
  my-packages = with super; buildEnv {
    name = "my-packages";
    paths = [
      myEmacs
    ];
  };
}
