{
  description = "Development environment with direnv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        formatter = pkgs.nixfmt-tree;
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            direnv
            treefmt
            nixfmt-rfc-style
          ];

          shellHook = ''
            echo "Development environment loaded"
            echo "Available tools: direnv, treefmt, nixfmt"
          '';
        };
      }
    );
}
