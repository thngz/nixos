{ pkgs, ... }:
{
  programs.home-manager.enable = true;
 
  home.username = "gkiviv";
  home.homeDirectory = "/home/gkiviv";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  
  home.packages = with pkgs; [
    kitty
    neofetch
    discord
    jetbrains-mono
    okular
    anki
    mullvad-vpn
    obs-studio
  ];

  nixpkgs.config.allowUnfree = true;
  
  programs.git = {
      enable = true;
      userName = "gkiviv";
      userEmail = "georgkivivali7@gmail.com";
  };
  home.file = { ".config/nvim/".source = ../programs/nvim; };
}
