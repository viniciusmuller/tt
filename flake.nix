  {
    description = "TODO: Add description";
    inputs.flake-utils.url = "github:numtide/flake-utils";

    outputs = { self, nixpkgs, flake-utils }:
      flake-utils.lib.simpleFlake {
        inherit self nixpkgs;
        name = "twenty-twenty";
        shell = ./shell.nix;
      };
  }
