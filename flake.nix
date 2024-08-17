{
  description = "A nix flake for the cosmere-rpg community project for Foundry VTT.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs =
    { self
    , nixpkgs
    , ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      devShells."${system}".default =
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        pkgs.mkShell {
          packages = with pkgs; [
            nodejs_18
            nodePackages.pnpm
            (yarn.override { nodejs = nodejs_18; })
          ];
          shellHook = ''
            echo "node `${pkgs.nodejs}/bin/node --version`"
          '';
        };
    };
}
