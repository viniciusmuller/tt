{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Project
    rustc
    cargo

    # Development
    clippy
    rustfmt
    rust-analyzer
  ];

  nativeBuildInputs = with pkgs; [
    pkg-config
    alsa-lib
  ];
}
