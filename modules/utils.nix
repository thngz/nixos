{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmux
    python3
    lua-language-server
    clang
    ripgrep
    gnumake
    nil
    nixfmt-classic
    vim
    snixembed
    vlc
    qdigidoc
    flameshot
  ];

  virtualisation.docker.enable = true;

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
}
