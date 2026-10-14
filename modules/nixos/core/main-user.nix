{ lib, config, pkgs, home-manager, ... }:

let
  inherit (lib) mkEnableOption mkOption mkIf types;
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = mkEnableOption "Enable user module";

    userName = mkOption {
      type = types.str;
      default = "aboba";
      example = "bob";
      description = "Username for the main user";
    };

    extraGroups = mkOption {
	    type = types.listOf types.str;
	    default = [ ];
	    example = [ "docker" "libvirtd" ];
	    description = "Additional groups for the main user";
    };

    loginShell = mkOption {
        type = types.enum [ "bash" "zsh" "fish" ];
        default = "zsh";
        example = "bash";
        description = "Login shell package for the main user";
    };
  };

  config = mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      shell = pkgs.${cfg.loginShell};
      extraGroups = [
	"wheel"
	"networkmanager"
      ] ++ cfg.extraGroups;
    };

    programs.${cfg.loginShell}.enable = true;
    home-manager.users.${cfg.userName}.programs.${cfg.loginShell}.enable = true;
  };
}
