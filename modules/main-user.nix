{ lib, config, pkgs, ... }:

let cfg = config.main-user;
in {
  options.main-user = {
    enable = lib.mkEnableOption "enable user module";

    userName = lib.mkOption {
      default = "gkiviv";
      description = "  username\n";
    };
  };

  config = lib.mkIf cfg.enable {
  };
}
