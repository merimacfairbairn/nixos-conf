{
  description = "Aboba's nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, home-manager, ... }:
    let
    mkHost = hostname: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
	./hosts/${hostname}
	{
	  networking.hostName = hostname;
	  nixpkgs.config.allowUnfree = true;
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
