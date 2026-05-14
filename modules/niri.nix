{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.niri;

  waybar-niri-windows = pkgs.buildGoModule {
    pname = "waybar-niri-windows";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "calico32";
      repo = "waybar-niri-windows";
      rev = "main";
      hash = "sha256-7OEyJ4K7JXCdMILxcY5g3ldmSMPAiea5OZcsyvDdL9k=";
    };

    vendorHash = "sha256-jK87vZYfUe8znk65SmJ1mN8qP5K3dtt950hKGWTYXs4=";

    nativeBuildInputs = with pkgs; [ pkg-config ];
    buildInputs = with pkgs; [ gtk3 ];

    buildPhase = ''
      runHook preBuild
      go build -buildmode=c-shared -o waybar-niri-windows.so ./main
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/lib
      cp waybar-niri-windows.so $out/lib/
      runHook postInstall
    '';
  };
in
{
  options.niri = {
    enable = lib.mkEnableOption "enable niri";
    modKey = lib.mkOption {
      default = "Mod4";
      description = "main orchestrator key";
    };
  };

  config = lib.mkIf cfg.enable (let
    mod = if cfg.modKey == "Mod1" then "Alt"
          else if cfg.modKey == "Mod4" then "Super"
          else cfg.modKey;

    powerMenu = pkgs.writeShellScriptBin "niri-power-menu" ''
      choice=$(echo -e "Logout\nSuspend\nReboot\nShutdown" | ${pkgs.rofi}/bin/rofi -dmenu -p "Power Menu")
      case "$choice" in
        Logout) niri msg action quit;;
        Suspend) systemctl suspend;;
        Reboot) systemctl reboot;;
        Shutdown) systemctl poweroff;;
      esac
    '';
  in {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      swaylock
      swayidle
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
      waybar
      powerMenu
    ];

    services.greetd = {
      enable = true;
      settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal-gtk ];
      config.niri.default = [ "gnome" "gtk" ];
    };

    security.pam.services.swaylock = { };

    services.gnome.gnome-keyring.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XKB_DEFAULT_LAYOUT = "us,ee";
      XKB_DEFAULT_OPTIONS = "ctrl:nocaps,grp:rctrl_toggle";
      XCURSOR_SIZE = "24";
    };

    home-manager.users.gkiviv = { lib, ... }: {
      programs.waybar = {
        enable = true;
        style = ''
          .cffi-niri-windows .tile {
            background-color: rgba(255, 255, 255, 0.5);
          }

          .cffi-niri-windows .tile:hover {
            background-color: rgba(255, 255, 255, 0.7);
          }

          .cffi-niri-windows .tile:active {
            background-color: rgb(255, 255, 255);
          }

          .cffi-niri-windows .column {
            border: 1px solid rgba(255, 255, 255, 0.85);
          }

          .cffi-niri-windows .floating {
            border: 2px solid rgba(255, 255, 255, 0.85);
          }
        '';
        settings.mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = [ "niri/workspaces" "cffi/niri-windows" ];
          modules-center = [ "clock" ];
          modules-right = [ "disk#root" "disk#main" "memory" "battery" "tray" ];

          "niri/workspaces" = {
            format = "{name}";
          };
          "niri/window" = {
            max-length = 50;
          };
          "cffi/niri-windows" = {
            module_path = "${waybar-niri-windows}/lib/waybar-niri-windows.so";
            options = {
              mode = "graphical";
              show-floating = "auto";
              floating-position = "right";
              minimum-size = 1;
              spacing = 1;
              icon-minimum-size = 0;
              column-borders = 0;
              floating-borders = 0;
              on-tile-click = "FocusWindow";
              on-tile-middle-click = "CloseWindow";
              on-tile-right-click = "";
              rules = [];
            };
            actions = {
              on-scroll-up = "FocusColumnLeft";
              on-scroll-down = "FocusColumnRight";
            };
          };
          clock = {
            format = "{:%Y-%m-%d %H:%M:%S %Z}";
            timezone = "Europe/Tallinn";
            interval = 1;
          };
          "disk#root" = {
            path = "/";
            format = "{free}";
            interval = 30;
          };
          "disk#main" = {
            path = "/run/media/gkiviv/main";
            format = "{free}";
            interval = 30;
          };
          memory = {
            format = "USED RAM: {used:0.1f}G";
            interval = 5;
          };
          battery = {
            format = "{icon} {capacity}%, remaining: {time}";
            format-charging = "⚡ CHR {capacity}%, remaining: {time}";
            format-icons = [ "🔋" "🔋" "🔋" "🔋" "🔋" ];
            states = {
              warning = 15;
              critical = 10;
            };
          };
          tray = {
            icon-size = 16;
            spacing = 2;
          };
        };
      };

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

        binds = with lib; (mkMerge [
          {
            "${mod}+Shift+Return".action.spawn = ["ghostty"];
            "${mod}+Escape".action.spawn = ["swaylock"];
            "${mod}+Shift+Q".action.close-window = {};
            "${mod}+D".action.spawn = ["rofi" "-modi" "drun,run" "-show" "drun"];
            "${mod}+Shift+V".action.spawn = ["sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"];
            "${mod}+Shift+S".action.spawn = ["sh" "-c" "grim -g \"$(slurp)\" - | swappy -f -"];

            "XF86AudioRaiseVolume".action.spawn = ["pactl" "set-sink-volume" "@DEFAULT_SINK@" "+10%"];
            "XF86AudioLowerVolume".action.spawn = ["pactl" "set-sink-volume" "@DEFAULT_SINK@" "-10%"];
            "XF86AudioMute".action.spawn = ["pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle"];
            "XF86AudioMicMute".action.spawn = ["pactl" "set-source-mute" "@DEFAULT_SOURCE@" "toggle"];

            "${mod}+H".action.focus-column-left = {};
            "${mod}+L".action.focus-column-right = {};
            "${mod}+K".action.focus-window-up = {};
            "${mod}+J".action.focus-window-down = {};

            "${mod}+Left".action.focus-column-left = {};
            "${mod}+Right".action.focus-column-right = {};
            "${mod}+Up".action.focus-window-up = {};
            "${mod}+Down".action.focus-window-down = {};

            "${mod}+Shift+H".action.move-column-left = {};
            "${mod}+Shift+L".action.move-column-right = {};
            "${mod}+Shift+K".action.move-window-up = {};
            "${mod}+Shift+J".action.move-window-down = {};

            "${mod}+Shift+Left".action.move-column-left = {};
            "${mod}+Shift+Right".action.move-column-right = {};
            "${mod}+Shift+Up".action.move-window-up = {};
            "${mod}+Shift+Down".action.move-window-down = {};

            "${mod}+F".action.fullscreen-window = {};
            "${mod}+Shift+Space".action.reset-window-height = {};
            "${mod}+Space".action.toggle-window-floating = {};

            "${mod}+N".action.consume-or-expel-window-right = {};
            "${mod}+Equal".action.set-column-width = "+10%";
            "${mod}+Minus".action.set-column-width = "-10%";
            "${mod}+Comma".action.consume-window-into-column = {};
            "${mod}+Period".action.expel-window-from-column = {};

            "${mod}+Shift+E".action.spawn = ["niri-power-menu"];

            "${mod}+R".action.switch-preset-column-width = {};
          }
          (builtins.listToAttrs (map (n: {
            name = "${mod}+${toString (if n == 10 then 0 else n)}";
            value.action.focus-workspace = n;
          }) (lib.range 1 10)))
          (builtins.listToAttrs (map (n: {
            name = "${mod}+Shift+${toString (if n == 10 then 0 else n)}";
            value.action.move-column-to-workspace = n;
          }) (lib.range 1 10)))
        ]);

        spawn-at-startup = [
          { command = ["waybar"]; }
          { command = ["swayidle" "-w" "timeout" "300" "swaylock -f" "timeout" "600" "niri msg action power-off-monitors" "resume" "niri msg action power-on-monitors" "before-sleep" "swaylock -f"]; }
          { command = ["nm-applet" "--indicator"]; }
          { command = ["wl-paste" "--type" "text" "--watch" "cliphist" "store"]; }
          { command = ["wl-paste" "--type" "image" "--watch" "cliphist" "store"]; }
          { command = ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"]; }
          { command = ["mako"]; }
          { command = ["dex" "--autostart" "--environment" "niri"]; }
        ];

        prefer-no-csd = true;

        cursor.size = 18;
      };
    };
  });
}
