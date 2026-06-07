{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.niri;
  noctalia =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  options.niri = {
    enable = lib.mkEnableOption "enable niri";
    modKey = lib.mkOption {
      default = "Mod1";
      description = "main orchestrator key";
    };
  };

  config = lib.mkIf cfg.enable (
    let
      mod =
        if cfg.modKey == "Mod1" then
          "Alt"
        else if cfg.modKey == "Mod4" then
          "Super"
        else
          cfg.modKey;

    in
    {
      programs.niri = {
        enable = true;
        package = pkgs.niri.overrideAttrs {
          doCheck = false;
        };

      };

      environment.systemPackages = with pkgs; [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        wl-clipboard
        rofi
        grim
        slurp
        swappy
        mako
        cliphist
        networkmanagerapplet
        wdisplays
        brightnessctl
        polkit_gnome
        dex
        xwayland-satellite
      ];

      services.greetd = {
        enable = true;
        settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
      };

      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
        config.niri.default = [
          "gnome"
          "gtk"
        ];
      };

      security.pam.services.swaylock = { };

      services.gnome.gnome-keyring.enable = true;

      home-manager.users.gkiviv =
        { lib, ... }:
        {
          programs.niri.settings = {
            input = {
              keyboard.xkb = {
                layout = "us,ee";
                options = "ctrl:nocaps,grp:rctrl_toggle";
              };
              touchpad = {
                tap = true;
                natural-scroll = true;
              };
            };

            environment = {
              CLUTTER_BACKEND = "wayland";
              GDK_BACKEND = "wayland,x11";
              MOZ_ENABLE_WAYLAND = "1";
              NIXOS_OZONE_WL = "1";
              QT_QPA_PLATFORM = "wayland";
              QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
              ELECTRON_OZONE_PLATFORM_HINT = "auto";

              XDG_SESSION_TYPE = "wayland";
              XDG_CURRENT_DESKTOP = "niri";
              DISPLAY = ":0";
            };

            layout = {
              gaps = 8;
              center-focused-column = "on-overflow";
              preset-column-widths = [
                { proportion = 0.33333; }
                { proportion = 0.5; }
                { proportion = 0.66667; }
              ];
            };

            outputs."*".background-color = "#333333";

            binds =
              with lib;
              (mkMerge [
                {
                  "${mod}+Shift+Return".action.spawn = [ "ghostty" ];
                  # "${mod}+Escape".action.spawn = [ "swaylock" ];
                  "${mod}+Escape".action.spawn = noctalia "lockScreen lock";
                  "${mod}+Shift+E".action.spawn = noctalia "sessionMenu toggle";
                  "${mod}+Shift+Q".action.close-window = { };
                  "${mod}+D".action.spawn = noctalia "launcher toggle";
                  "${mod}+Shift+V".action.spawn = noctalia "launcher clipboard";

                  "${mod}+Shift+S".action.spawn = [
                    "sh"
                    "-c"
                    "grim -g \"$(slurp)\" - | swappy -f -"
                  ];

                  "${mod}+H".action.focus-column-left = { };
                  "${mod}+L".action.focus-column-right = { };
                  "${mod}+K".action.focus-window-up = { };
                  "${mod}+J".action.focus-window-down = { };

                  "${mod}+Left".action.focus-column-left = { };
                  "${mod}+Right".action.focus-column-right = { };
                  "${mod}+Up".action.focus-window-up = { };
                  "${mod}+Down".action.focus-window-down = { };

                  "${mod}+Shift+H".action.move-column-left = { };
                  "${mod}+Shift+L".action.move-column-right = { };
                  "${mod}+Shift+K".action.move-window-up = { };
                  "${mod}+Shift+J".action.move-window-down = { };

                  "${mod}+Shift+Left".action.move-column-left = { };
                  "${mod}+Shift+Right".action.move-column-right = { };
                  "${mod}+Shift+Up".action.move-window-up = { };
                  "${mod}+Shift+Down".action.move-window-down = { };

                  "${mod}+F".action.fullscreen-window = { };
                  "${mod}+Shift+Space".action.reset-window-height = { };
                  "${mod}+Space".action.toggle-window-floating = { };

                  "${mod}+N".action.consume-or-expel-window-right = { };
                  "${mod}+Equal".action.set-column-width = "+10%";
                  "${mod}+Minus".action.set-column-width = "-10%";
                  "${mod}+Comma".action.consume-window-into-column = { };
                  "${mod}+Period".action.expel-window-from-column = { };

                  "${mod}+R".action.switch-preset-column-width = { };
                }
                (builtins.listToAttrs (
                  map (n: {
                    name = "${mod}+${toString (if n == 10 then 0 else n)}";
                    value.action.focus-workspace = n;
                  }) (lib.range 1 10)
                ))
                (builtins.listToAttrs (
                  map (n: {
                    name = "${mod}+Shift+${toString (if n == 10 then 0 else n)}";
                    value.action.move-column-to-workspace = n;
                  }) (lib.range 1 10)
                ))
              ]);

            spawn-at-startup = [
              { command = [ "noctalia-shell" ]; }
            ];
            prefer-no-csd = true;

            cursor.size = 12;
          };
        };
    }
  );
}
