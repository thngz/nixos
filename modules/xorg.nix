{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.xorg;

  i3Startup = ''
    exec --no-startup-id xsetroot -solid "#333333"
    exec --no-startup-id "setxkbmap -option ctrl:nocaps"

    exec --no-startup-id dex-autostart --autostart --environment i3

    exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork

    exec --no-startup-id nm-applet
  '';

  i3AudioBindings = ''
    set $refresh_i3status killall -SIGUSR1 i3status
    bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
    bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
    bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
    bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status
  '';

  i3WindowBindings = ''
    floating_modifier $mod

    tiling_drag modifier titlebar

    bindsym $mod+Shift+Return exec ghostty

    # kill focused window
    bindsym $mod+Shift+q kill

    # A more modern dmenu replacement is rofi:
    bindsym $mod+d exec "rofi -modi drun,run -show drun"

    #clipman
    bindsym $mod+Shift+v exec --no-startup-id "xfce4-popup-clipman"

    # screenshots
    bindsym $mod+Shift+s exec --no-startup-id "flameshot gui"
  '';

  i3FocusBindings = ''
    # change focus (horizontal goes through papersway to scroll paper columns)
    bindsym $mod+h exec papersway-msg focus left
    bindsym $mod+k focus up
    bindsym $mod+j focus down
    bindsym $mod+l exec papersway-msg focus right

    # alternatively, you can use the cursor keys:
    bindsym $mod+Left exec papersway-msg focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right exec papersway-msg focus right
  '';

  i3MoveBindings = ''
    # move focused window (horizontal goes through papersway)
    bindsym $mod+Shift+h exec papersway-msg move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l exec papersway-msg move right

    # alternatively, you can use the cursor keys:
    bindsym $mod+Shift+Left exec papersway-msg move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right exec papersway-msg move right
  '';

  # Note: split / stacking / tabbed / layout / focus-parent bindings are
  # intentionally omitted because they conflict with papersway's column model
  # (per App::papersway(1p) recommendations).
  i3LayoutBindings = ''
    # enter fullscreen mode for the focused container
    bindsym $mod+f fullscreen toggle

    # toggle tiling / floating
    bindsym $mod+Shift+space floating toggle

    # change focus between tiling / floating windows
    bindsym $mod+space focus mode_toggle
  '';

  i3PaperswayBindings = ''
    # create a new empty paper workspace to the right
    bindsym $mod+n exec papersway-msg fresh-workspace
    # same, but drag the focused window along
    bindsym $mod+Shift+n exec papersway-msg fresh-workspace take

    # change how many columns are visible at once
    bindsym $mod+equal exec papersway-msg cols incr
    bindsym $mod+minus exec papersway-msg cols decr

    # merge focused window into neighbor column / expel back out
    bindsym $mod+comma exec papersway-msg absorb-expel left
    bindsym $mod+period exec papersway-msg absorb-expel right
  '';

  i3Workspaces = ''
    # Define names for default workspaces for which we configure key bindings later on.
    # We use variables to avoid repeating the names in multiple places.
    set $ws1 "1"
    set $ws2 "2"
    set $ws3 "3"
    set $ws4 "4"
    set $ws5 "5"
    set $ws6 "6"
    set $ws7 "7"
    set $ws8 "8"
    set $ws9 "9"
    set $ws10 "10"

    # switch to workspace
    bindsym $mod+1 workspace number $ws1
    bindsym $mod+2 workspace number $ws2
    bindsym $mod+3 workspace number $ws3
    bindsym $mod+4 workspace number $ws4
    bindsym $mod+5 workspace number $ws5
    bindsym $mod+6 workspace number $ws6
    bindsym $mod+7 workspace number $ws7
    bindsym $mod+8 workspace number $ws8
    bindsym $mod+9 workspace number $ws9
    bindsym $mod+0 workspace number $ws10

    # move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace number $ws1
    bindsym $mod+Shift+2 move container to workspace number $ws2
    bindsym $mod+Shift+3 move container to workspace number $ws3
    bindsym $mod+Shift+4 move container to workspace number $ws4
    bindsym $mod+Shift+5 move container to workspace number $ws5
    bindsym $mod+Shift+6 move container to workspace number $ws6
    bindsym $mod+Shift+7 move container to workspace number $ws7
    bindsym $mod+Shift+8 move container to workspace number $ws8
    bindsym $mod+Shift+9 move container to workspace number $ws9
    bindsym $mod+Shift+0 move container to workspace number $ws10
  '';

  i3ControlBindings = ''
    # reload the configuration file
    bindsym $mod+Shift+c reload
    # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
    bindsym $mod+Shift+r restart
    # exit i3 (logs you out of your X session)
    bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"
  '';

  i3ResizeMode = ''
    # resize window (you can also use the mouse for that)
    mode "resize" {
            bindsym j resize shrink width 10 px or 10 ppt
            bindsym k resize grow height 10 px or 10 ppt
            bindsym l resize shrink height 10 px or 10 ppt
            bindsym semicolon resize grow width 10 px or 10 ppt

            # same bindings, but for the arrow keys
            bindsym Left resize shrink width 10 px or 10 ppt
            bindsym Down resize grow height 10 px or 10 ppt
            bindsym Up resize shrink height 10 px or 10 ppt
            bindsym Right resize grow width 10 px or 10 ppt

            # back to normal: Enter or Escape or $mod+r
            bindsym Return mode "default"
            bindsym Escape mode "default"
            bindsym $mod+r mode "default"
    }

    bindsym $mod+r mode "resize"
  '';

  i3StatusConfig = pkgs.writeText "i3status-config" ''
    general {
            output_format = "i3bar"
            colors = true
            interval = 5
    }

    order += "disk /"
    order += "disk /run/media/gkiviv/main"
    order += "battery 0"
    order += "memory"
    order += "tztime tallinn"

    battery 0 {
            format = "%status %percentage, remaining: %remaining"
            status_chr = "⚡ CHR"
            status_bat = "🔋 BAT"
            status_unk = "? UNK"
            status_full = "☻ FULL"
            path = "/sys/class/power_supply/BAT%d/uevent"
            low_threshold = 10
    }


    tztime tallinn {
            format = "%Y-%m-%d %H:%M:%S %Z"
            timezone = "Europe/Tallinn"
    }

    memory {
            format = "USED RAM: %used"
            threshold_degraded = "10%"
            format_degraded = "MEMORY: %free"
    }


    disk "/" {
            format = "%free"
    }

    disk "/run/media/gkiviv/main" {
            format = "%free"
    }
  '';

  # papersway --i3status runs `exec "i3status"` with no args, so it reads
  # i3status's default config at /etc/xdg/i3status/config (installed below via
  # environment.etc). That's how we keep the disk/battery/memory/time layout.
  i3Bar = ''
    bar {
        status_command ${pkgs.perl5Packages.Apppapersway}/bin/papersway --i3status
    }
  '';
in
{
  options.xorg = {
    enable = lib.mkEnableOption "enable xorg";
    modKey = lib.mkOption {
      default = "Mod4";
      description = ''
        main orchestrator key
      '';
    };
  };

  config = lib.mkIf cfg.enable {

    # Installed system-wide so `papersway --i3status`, which execs i3status
    # without arguments, still picks up our custom disk/battery/memory layout.
    environment.etc."xdg/i3status/config".source = i3StatusConfig;

    services.xserver.enable = true;
    services.xserver.xautolock.time = 40;
    services.displayManager.sddm.enable = true;
    services.xserver.desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    services.xserver.xkb = {
      layout = "us,ee";
      variant = "";
      options = "ctrl:swapcaps, grp:rctrl_toggle";
    };

    services.displayManager.defaultSession = "xfce+i3";
    services.xserver.windowManager.i3 = {
      enable = true;
      configFile = pkgs.writeText "i3.cfg" ''
        set $mod ${cfg.modKey}

        font pango:Jetbrains Mono 12

        # papersway recommends disabling focus wrap-around
        focus_wrapping no

        ${i3Startup}
        ${i3AudioBindings}
        ${i3WindowBindings}
        ${i3FocusBindings}
        ${i3MoveBindings}
        ${i3LayoutBindings}
        ${i3PaperswayBindings}
        ${i3Workspaces}
        ${i3ControlBindings}
        ${i3ResizeMode}
        ${i3Bar}
      '';
      extraPackages = with pkgs; [
        rofi
        i3status
        i3blocks
        xfce4-clipman-plugin
        perl5Packages.Apppapersway
        xdotool
      ];
    };
  };
}
