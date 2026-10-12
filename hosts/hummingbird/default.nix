{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/core
      ../../modules/nixos/services
    ];
 
    main-user.enable = true;
    main-user.userName = "aboba";

    environment.systemPackages = with pkgs; [
      vim 
      wget
      openssh
      git
    ];

    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "26.05"; # Did you read the comment?
}

