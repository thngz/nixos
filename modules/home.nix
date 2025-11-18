{ inputs, pkgs, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  # nixpkgs.config.allowUnfree = true;
  home-manager.users.gkiviv = {

    home.username = "gkiviv";
    home.homeDirectory = "/home/gkiviv";
    home.stateVersion = "23.11";

    programs.git = {
      enable = true;
      userName = "gkiviv";
      userEmail = "georgkivivali7@gmail.com";
      lfs.enable = true;
    };

    programs.neovim = {
      enable = true;
      withNodeJs = true;
      withPython3 = true;
    };

    services.syncthing = { enable = true; };
    home.file = {
      ".config/nvim/".source = ../programs/nvim;
    };

    programs.swaylock = { enable = true; };

    programs.rofi = { enable = true; };

    services.swayidle = { enable = true; };
    services.network-manager-applet = { enable = true; };

    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {

        mainBar = {
          position = "bottom";
          layer = "top";
          height = 30;
          modules-left = [ "sway/workspaces" "sway/mode" ];
          modules-right = [ "clock" "memory" "disk" "battery" "tray" ];
          clock = { format = "{:%Y-%m-%d %H:%M}"; };

          battery = {
            format = "{icon} {capacity}%, remaining: {time}";
            format-charging = "⚡ CHR {capacity}%, remaining: {time}";
            format-full = "☻ FULL";
            states = { warning = 10; };
            format-icons = [ "🔋" ];
          };

          memory = { format = "USED RAM: {used:0.1f}G"; };

          disk = {
            format = "{free}";
            path = "/";
          };
        };

      };

      style = ''
        * {
          border: none;
          font-family: Jetbrains Mono;
          font-size: 16px;
        }
        window#waybar {
          background-color: #000000;
          color: #ffffff;
        }
        #workspaces button {
          background-color: transparent;
          color: #ffffff;
        }
        #disk, #memory, #battery, #clock {
            padding: 0 10px;
            margin: 0 5px;
            border-left: 1px solid #333333;
        }
        #workspaces button.focused {
          background-color: #333333;
        }
      '';
    };

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps

      systemd.enable = true;
      config = rec {
        modifier = "Mod1";
        terminal = "alacritty";
        fonts = {
          names = [ "JetBrains Mono" ];
          size = 13.0;

        };

        keybindings = {
          "${modifier}+Shift+Return" = "exec ${terminal}";
          "${modifier}+d" = "exec rofi -show drun";
          "${modifier}+Shift+s" = "exec flameshot gui";
          "${modifier}+Shift+q" = "kill";

          # Focus
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          # Move
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          # Layouts
          "${modifier}+v" = "splitv";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          # Workspaces
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          # Reload/exit
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";
          "${modifier}+Shift+e" =
            "exec swaynag -t warning -m 'Exit Sway?' -B 'Yes' 'swaymsg exit'";

          # Media keys
          "XF86AudioRaiseVolume" =
            "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" =
            "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" =
            "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        };
        bars = [ ];
      };
    };

    home.packages = with pkgs; [
      grim
      wl-clipboard
      mako # notifications
    ];

    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal = { family = "Iosevka"; };
          size = 16;
        };
      };
    };
  };

}
