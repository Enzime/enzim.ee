{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.permittedInsecurePackages = [
          "nodejs-16.20.2"
        ];
      };
    in {
      devShells.default = pkgs.mkShell {
        packages = [ (pkgs.yarn.override { nodejs = pkgs.nodejs-16_x; }) pkgs.bashInteractive ];
      };
    });
}
