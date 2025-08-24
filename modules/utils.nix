{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmux
    python3
    openssl
    lua-language-server
    clang
    gnumake
    nil
    nixfmt-classic
    vim
    snixembed
    vlc
    qdigidoc
    flameshot
  ];

  virtualisation.docker = {
    enable = true;
    extraOptions = ''
    '';
  };

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
