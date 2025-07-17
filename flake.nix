{
  description = "A nix flake for the cosmere-rpg community project for Foundry VTT.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs =
    {
      self,
      nixpkgs,
      ...
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
            nodejs_20
            nodePackages.pnpm
            (yarn.override { nodejs = nodejs_20; })
          ];
          shellHook = ''
            echo "node `${pkgs.nodejs}/bin/node --version`"

            # TODO: find a way to move this to dependencies instead of running in the shellHook
            npm install @rollup/plugin-typescript --save-dev
          '';
        };
    };
}
