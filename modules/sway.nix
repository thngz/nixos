{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.sway;

  swayInput = ''
    input "type:keyboard" {
        xkb_layout  us,ee
        xkb_options ctrl:nocaps,grp:rctrl_toggle
    }

    input "type:touchpad" {
        tap enabled
        natural_scroll enabled
    }
  '';

  swayOutput = ''
    # desktop background (replaces xsetroot on i3)
    output * bg #333333 solid_color
  '';

  swayStartup = ''
    exec dex-autostart --autostart --environment sway

    # idle / lock / sleep (replaces xss-lock + i3lock)
    exec swayidle -w timeout 300 'swaylock -f' timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' before-sleep 'swaylock -f'

    # network tray (swaybar's built-in tray picks this up)
    exec nm-applet --indicator

    # clipboard history watchers (populate cliphist)
    exec wl-paste --type text --watch cliphist store
    exec wl-paste --type image --watch cliphist store

    # polkit agent for authentication prompts (replaces xfce4-session's role)
    exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1

    # notifications
    exec mako
  '';

  swayAudioBindings = ''
    set $refresh_i3status killall -SIGUSR1 i3status
    bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
    bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
    bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
    bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status
  '';

  swayWindowBindings = ''
    floating_modifier $mod

    # (tiling_drag is i3-only and is intentionally omitted)

    bindsym $mod+Shift+Return exec ghostty

    # kill focused window
    bindsym $mod+Shift+q kill

    # launcher (rofi-wayland is a drop-in for rofi)
    bindsym $mod+d exec "rofi -modi drun,run -show drun"

    # clipboard history: cliphist fronted by rofi, paste via wl-copy
    bindsym $mod+Shift+v exec sh -c 'cliphist list | rofi -dmenu | cliphist decode | wl-copy'

    # screenshots: slurp picks a region, grim captures it, swappy opens for edit/annotate
    bindsym $mod+Shift+s exec sh -c 'grim -g "$(slurp)" - | swappy -f -'
  '';

  swayFocusBindings = ''
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

  swayMoveBindings = ''
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
  swayLayoutBindings = ''
    # enter fullscreen mode for the focused container
    bindsym $mod+f fullscreen toggle

    # toggle tiling / floating
    bindsym $mod+Shift+space floating toggle

    # change focus between tiling / floating windows
    bindsym $mod+space focus mode_toggle
  '';

  swayPaperswayBindings = ''
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

  swayWorkspaces = ''
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

  # Dropped `restart` — sway has no `restart` command; use `reload` or log out.
  swayControlBindings = ''
    # reload the configuration file
    bindsym $mod+Shift+c reload
    # exit sway (logs you out of your session)
    bindsym $mod+Shift+e exec "swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your session.' -B 'Yes, exit sway' 'swaymsg exit'"
  '';

  swayResizeMode = ''
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

  swayStatusConfig = pkgs.writeText "i3status-config" ''
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

  # papersway --i3status execs bare `i3status`, which reads
  # /etc/xdg/i3status/config (installed below via environment.etc).
  swayBar = ''
    bar {
        status_command ${pkgs.perl5Packages.Apppapersway}/bin/papersway --i3status
    }
  '';
in
{
  options.sway = {
    enable = lib.mkEnableOption "enable sway";
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
    environment.etc."xdg/i3status/config".source = swayStatusConfig;

    # The sway config itself.
    environment.etc."sway/config".source = pkgs.writeText "sway.config" ''
      set $mod ${cfg.modKey}

      font pango:Jetbrains Mono 12

      # papersway recommends disabling focus wrap-around
      focus_wrapping no

      ${swayInput}
      ${swayOutput}
      ${swayStartup}
      ${swayAudioBindings}
      ${swayWindowBindings}
      ${swayFocusBindings}
      ${swayMoveBindings}
      ${swayLayoutBindings}
      ${swayPaperswayBindings}
      ${swayWorkspaces}
      ${swayControlBindings}
      ${swayResizeMode}
      ${swayBar}
    '';

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      xwayland.enable = true;
      extraPackages = with pkgs; [
        # core sway ecosystem
        swaylock
        swayidle
        sway-contrib.grimshot
        wl-clipboard
        # launcher
        rofi-wayland
        # screenshots
        grim
        slurp
        swappy
        # notifications
        mako
        # clipboard history
        cliphist
        # papersway (daemon invoked from bar's status_command)
        perl5Packages.Apppapersway
        # status line
        i3status
        # network tray
        networkmanagerapplet
        # output/display management GUI
        wdisplays
        # brightness
        brightnessctl
        # polkit agent
        polkit_gnome
        # autostart support for .desktop entries
        dex
      ];
    };

    # Display manager — SDDM with Wayland support.
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.displayManager.defaultSession = "sway";

    # XDG portals (screen share, file pickers).
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    # PAM entry so swaylock can authenticate.
    security.pam.services.swaylock = { };

    # Keyring (replaces xfce4-session's keyring role).
    services.gnome.gnome-keyring.enable = true;

    # Session-wide env vars for Wayland-native apps + libxkbcommon defaults.
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XKB_DEFAULT_LAYOUT = "us,ee";
      XKB_DEFAULT_OPTIONS = "ctrl:nocaps,grp:rctrl_toggle";
      XCURSOR_SIZE = "24";
    };
  };
}
