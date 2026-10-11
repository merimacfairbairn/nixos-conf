{
  description = "Aboba's nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      mkHost = hostname: lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/${hostname}/default.nix
          home-manager.nixosModules.home-manager

          {
            nixpkgs.config.allowUnfree = true;

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.aboba = import ./hosts/${hostname}/home.nix;
            };
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        hummingbird = mkHost "hummingbird";
	mastodon = mkHost "mastodon";
      };
    };
}

