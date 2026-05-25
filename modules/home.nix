{ inputs, pkgs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.users.gkiviv = {

    home.username = "gkiviv";
    home.homeDirectory = "/home/gkiviv";
    home.stateVersion = "23.11";

    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "gkiviv";
          email = "georgkivivali7@gmail.com";
        };

        merge.tool = "meld";
        mergetool.keepBackup = false;
        mergetool.meld.cmd = "meld $LOCAL $BASE $REMOTE --output $MERGED";
      };

      # extraConfig = {
      # };
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };

    services.syncthing = {
      enable = true;
    };

    home.file = {
      ".config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom.json".source =
        ../programs/cosmic/custom.json;
    };

    programs.rofi = {
      enable = true;
    };

    services.network-manager-applet = {
      enable = true;
    };

    programs.ghostty = {
      enable = true;
      settings = {
        font-size = 16;
        font-family = "iosevka";
        theme = "Monokai Pro Light Sun";
      };
      enableFishIntegration = true;
    };

    programs.lazygit = {
      enable = true;

      enableFishIntegration = true;

      settings = {
        git = {
          pagers = [
            {
              pager = "delta --light true --paging=never --side-by-side";
            }
          ];
        };
      };
    };

    programs.zellij = {
      enable = true;
      settings = {
        theme = "catppuccin-latte";
      };
    };

  };

}
