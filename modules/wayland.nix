{ lib, config, pkgs, ... }:
let cfg = config.wayland_desktop;
in {
  options.wayland_desktop = {
    enable = lib.mkEnableOption "enable wayland";
    modKey = lib.mkOption {
      default = "Mod4";
      description = ''
        main orchestrator key
      '';
    };
  };

  config = lib.mkIf cfg.enable {


    # programs.sway = {
    #   enable = true;
    #   wrapperFeatures.gtk = true;
    #   extraPackages = with pkgs; [
    #     wl-clipboard
    #     grim
    #     mako
    #     wdisplays
    #     waybar
    #     rofi
    #     networkmanagerapplet
    #     # alacritty
    # tuigreet
    #     # swaynag
    #   ];
    # };

    # xdg.portal = {
    #   enable = true;
    #   extraPortals =
    #     [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    # };

    # services.displayManager.sddm.enable = true;
    # services.displayManager.sddm.wayland.enable = true;
    # services.desktopManager.plasma6.enable = true;

    environment.sessionVariables = {
      XKB_DEFAULT_LAYOUT = "us,ee";
      XKB_DEFAULT_OPTIONS = "ctrl:swapcaps,grp:rctrl_toggle";
    };

    services.greetd = {
      enable = true;
      settings.default_session.command =
        "${pkgs.tuigreet}/bin/tuigreet --cmd sway";
    };
  };
}

