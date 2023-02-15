{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let
  nodeWithBashCompletion = nodejs:
    nodejs.overrideAttrs (old: {
      postInstall = old.postInstall + ''
        # generate bash-completetion
        mkdir -p $out/share/bash-completion/completions/
        $out/bin/node --completion-bash \
          > $out/share/bash-completion/completions/node
      '';
    });
in { inherit nodeWithBashCompletion; }
