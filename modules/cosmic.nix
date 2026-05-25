{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.cosmic;
in
{
  options.cosmic = {
    enable = lib.mkEnableOption "enable wayland";
    modKey = lib.mkOption {
      default = "Mod1";
      description = ''
        main orchestrator key
      '';
    };
  };

  config = lib.mkIf cfg.enable {

    security.pam.services.swaylock = { };

    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;
    services.desktopManager.cosmic.xwayland.enable = true;

    environment.systemPackages = with pkgs; [ wdisplays ];
    environment.sessionVariables = {
      XKB_DEFAULT_LAYOUT = "us,ee";
      XKB_DEFAULT_OPTIONS = "ctrl:swapcaps,grp:rctrl_toggle";
    };

  };
}
