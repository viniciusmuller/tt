  {
    description = "Flake for the tt program";
    inputs.flake-utils.url = "github:numtide/flake-utils";

    outputs = { self, nixpkgs, flake-utils }:
      flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pname = "tt";
        version = "0.1.0";
        app = pkgs.rustPlatform.buildRustPackage {
          inherit pname version;
          src = pkgs.lib.cleanSource ./tt;
          buildInputs = with pkgs; [ alsa-lib ];
          nativeBuildInputs = with pkgs; [ pkg-config ];
          cargoSha256 = "sha256-iVrzP+WTCbBay/P+z2+qc4VtcCmwmxAHDJb2/mDdffk=";
        };
      in {
          devShell = import ./shell.nix { inherit pkgs; };
          defaultApp = app;
        }
      );
  }
