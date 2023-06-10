{ pkgs ? import <nixpkgs> # (fetchTarball
  # "https://github.com/NixOS/nixpkgs/archive/dd14e5d78e90a2ccd6007e569820de9b4861a6c2.tar.gz")
  { } }:
with pkgs;
let
  # inherit (import ../common.nix { inherit pkgs; }) nodeWithBashCompletion;
  # nodejs = nodeWithBashCompletion nodejs-16_x;
  nodejs = nodejs-16_x;
  # $ cd node2nix
  # $ node2nix -16 -i node-packages.json
  # do not inherit `nodejs` when calling import. Let it use itsown.
  node2nix-packages = import ./node2nix/default.nix { inherit pkgs nodejs; };
  amplifycli = node2nix-packages."@aws-amplify/cli".override {
    # without dontNpmInstall, deploy fails with:
    # npm ERR! code ENOTCACHEDn: sill fetchPackageMetKK
    # npm ERR! request to https://registry.npmjs.org/@aws-cdk%2fcloud-assembly-schema failed: cache mode is 'only-if-cached' but no cached response available.
    dontNpmInstall = true;
    postInstall = ''
      ln -s $out/lib/node_modules/@aws-amplify/cli/bin $out/bin
    '';
  };
  rush = node2nix-packages."@microsoft/rush".override {
    # without dontNpmInstall, deploy fails with:
    # npm ERR! code ENOTCACHEDn: sill fetchPackageMetKK
    # npm ERR! request to https://registry.npmjs.org/@aws-cdk%2fcloud-assembly-schema failed: cache mode is 'only-if-cached' but no cached response available.
    dontNpmInstall = true;
    postInstall = ''
      ln -s $out/lib/node_modules/@microsoft/rush/bin $out/bin
    '';
  };
  typescript = node2nix-packages.typescript.override {
    # without dontNpmInstall, deploy fails with:
    # npm ERR! code ENOTCACHEDn: sill fetchPackageMetKK
    # npm ERR! request to https://registry.npmjs.org/@aws-cdk%2fcloud-assembly-schema failed: cache mode is 'only-if-cached' but no cached response available.
    dontNpmInstall = true;
    postInstall = ''
      ln -s $out/lib/node_modules/typescript/bin $out/bin
    '';
  };
  typescript-language-server =
    node2nix-packages.typescript-language-server.override {
      # without dontNpmInstall, deploy fails with:
      # npm ERR! code ENOTCACHEDmsill idealTree buildDepseps
      # npm ERR! request to https://registry.npmjs.org/@octokit%2frest failed: cache mode is 'only-if-cached' but no cached response is available.
      dontNpmInstall = true;
      postInstall = ''
        ln -s $out/lib/node_modules/typescript-language-server/bin $out/bin
      '';
    };
  prisma-stuff = [ prisma-engines ];
  node-packages = with nodePackages; [ pnpm prisma ];
  node-stuff = node-packages ++ [ nodejs yarn rush ];
  typescript-stuff = [ typescript typescript-language-server ];
  aws-stuff = [ amplifycli awscli2 ];
  java = adoptopenjdk-jre-bin; # the java runtime from open jdk
  other-stuff = [ chromium java openssl pgadmin4 ];
in mkShell {
  packages = typescript-stuff ++ prisma-stuff ++ node-stuff ++ aws-stuff
    ++ other-stuff;
  shellHook = ''
    export PATH=/home/joe/.local/bin:$PATH
  '';
}
