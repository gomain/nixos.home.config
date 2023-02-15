with import <nixpkgs> { }; {
  allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "vivaldi" "slack" "postman" ];
  permittedInsecurePackages = [ "xpdf-4.03" ];
}
