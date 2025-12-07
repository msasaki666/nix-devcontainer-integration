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
        # VSCode拡張機能などがグローバルに使用するツール
        globalTools = with pkgs; [
          direnv
          nixfmt-tree
        ];
      in
      {
        formatter = pkgs.nixfmt-tree;

        # グローバルにインストールするパッケージセット
        packages.globalTools = pkgs.buildEnv {
          name = "devcontainer-global-tools";
          paths = globalTools;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = globalTools;

          shellHook = ''
            echo "Development environment loaded"
            echo "Available tools: direnv, nixfmt-tree"
          '';
        };
      }
    );
}
