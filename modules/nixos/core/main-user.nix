{ lib, config, pkgs, ... }:

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
  };

  config = mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      extraGroups = [
	"wheel"
	"networkmanager"
      ] ++ cfg.extraGroups;
    };
  };
}
