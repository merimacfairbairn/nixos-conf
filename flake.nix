{
    description = "Aboba's nixos flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nvim-config = {
            url = "github:merimacfairbairn/nvim";
            flake = false;
        };
    };

    outputs = { nixpkgs, home-manager, ... }@inputs:
        let
        system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = nixpkgs.lib;

    mkHost = hostname: lib.nixosSystem {
        inherit system;

        modules = [
            ./hosts/${hostname}
        inputs.home-manager.nixosModules.default

        {
            nixpkgs.config.allowUnfree = true;

            home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                extraSpecialArgs = { inherit inputs; };

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

