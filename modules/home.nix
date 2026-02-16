{ inputs, pkgs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

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


    services.syncthing = { enable = true; };
    
    home.file = {
      ".config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom.json".source =
        ../programs/cosmic/custom.json;
    };

    programs.rofi = { enable = true; };

    services.network-manager-applet = { enable = true; };

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
