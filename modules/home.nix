{ inputs, pkgs, ... }:
let
  vue-ts-mode = pkgs.callPackage ./emacs/vue-mode.nix {
    trivialBuild = pkgs.emacs.pkgs.trivialBuild;
  };

  svelte-ts-mode = pkgs.callPackage ./emacs/svelte-mode.nix {
    trivialBuild = pkgs.emacs.pkgs.trivialBuild;
  };
  emacs = pkgs.emacsWithPackagesFromUsePackage {
    package = pkgs.emacs;
    config = ../programs/emacs/init.el;
    extraEmacsPackages = epkgs: [
      epkgs.use-package
      epkgs.treesit-grammars.with-all-grammars
      vue-ts-mode
      svelte-ts-mode
    ];
    alwaysEnsure = true;
  };

in {
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

    # home.file = {
    #   ".config/zellij".source =
    #     ../programs/zellij/zellij;
    # };
    
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
