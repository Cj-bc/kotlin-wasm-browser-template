{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    utils.url = "github:Cj-bc/my-nix-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachSystems [ "x86_64-linux" "aarch64-linux" ] (system:
      let pkgs = import nixpkgs { system = system; };
      in {
        packages.${system}.default = pkgs.stdenv.mkDerivation {
          buildInputs = [ pkgs.jdk25 ];
        };

        devShells.${system}.default = pkgs.mkShell {
          packages = [ pkgs.jdk25 ];
        };
      }
    );
}
