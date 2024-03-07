{pkgs, ...}:
{ 
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager = {
    xterm.enable = false;
    xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
    };
  };

  services.xserver.displayManager.defaultSession = "xfce";
  
  services.xserver.windowManager.i3 = {
     enable = true;

     extraPackages = with pkgs; [
        rofi
        i3status
        i3blocks
     ];
  };
  
  services.xserver = {
    xkb.layout = "us,ee";
    xkbVariant = "";
    xkbOptions = "ctrl:swapcaps, grp:rctrl_toggle";
  };
}
