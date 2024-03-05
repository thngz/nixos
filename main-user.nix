{ lib, config, pkgs, ...}:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable
    	= lib.mkEnableOption "enable user module";

    userName = lib.mkOption {
        default = "gkiviv";
	description = ''
	  username
	'';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
       isNormalUser = true;
       extraGroups = [ "networkmanager" "wheel" ];
       initialPassword = "12345";
       description = "main user";
       shell = pkgs.fish;
    };
  };
}
