{ config, pkgs, ... }:

{
  home.username = "gkiviv";
  home.homeDirectory = "/home/gkiviv";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    lua-language-server
    ripgrep
    kitty
    neofetch
    tmux
    discord
    jetbrains-mono
  ];

  programs.git = {
     enable = true;
     userName = "gkiviv";
     userEmail = "georgkivivali7@gmail.com";
  };

  programs.neovim = {
     enable = true;
     withNodeJs = true;
     withPython3 = true;
  };

  nixpkgs.config.allowUnfree = true;
  
  programs.tmux = {
    enable = true;
    extraConfig = ''
	set-option -sa terminal-overrides ",xterm*:Tc"
	unbind C-b
	set -g prefix C-Space
	bind C-Space send-prefix
	set -g base-index 1
	setw -g pane-base-index 1
    '';
  };

  home.file = {
   ".config/nvim/".source = ../../nvim;
   ".config/i3/config".source = ../../i3/config;
   ".config/i3status/config".source = ../../i3/i3status/config;
  };

  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
