{ config, pkgs, inputs, ... }:
# let
#     myEmacs = inputs.emacs-overlay.overlay {
#         package = pkgs.emacsUnstable;
#         config = ./init.el;
#         extraEmacsPackages = epkgs: with epkgs; [
#           use-package
#         ];
#         alwaysEnsure = true;
#     };
# in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
    okular
    anki
    qownnotes
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

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit;
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacsGit;
  };
  
  home.file = { ".config/nvim/".source = ../programs/nvim; };
  # home.file = { ".config/emacs/".source = ../programs/emacs; };
}
