{ inputs, pkgs, ... }:
let
  emacs = pkgs.emacsWithPackagesFromUsePackage {
    package = pkgs.emacs;
    config = ../programs/emacs/init.el;
    extraEmacsPackages = epkgs: [ epkgs.use-package epkgs.treesit-grammars.with-all-grammars ];
    alwaysEnsure = true;
  };

in {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

  home-manager.users.gkiviv = {

    home.packages = [ emacs ];
    home.file.".emacs.d/init.el".text = builtins.readFile ../programs/emacs/init.el;

    services.emacs = {
      enable = true;
      client.enable = true;
    };

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
    home.file = { ".config/nvim/".source = ../programs/nvim; };
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
