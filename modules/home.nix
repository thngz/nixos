{ pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [ (import "${home-manager}/nixos") ];

  programs.home-manager.enable = true;

  home.username = "gkiviv";
  home.homeDirectory = "/home/gkiviv";
  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    userName = "gkiviv";
    userEmail = "georgkivivali7@gmail.com";
  };
  home.file = { ".config/nvim/".source = ../programs/nvim; };
}
