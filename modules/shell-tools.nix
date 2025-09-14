{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    ghostty
    tree
    direnv
    dumb-init
    xclip
    wget
    starship
    rlwrap
    lsof
    unzip
    ripgrep
    fzf # find ze files
    gnuplot
    timewarrior
    nmap
    python3
    openssl
    lua-language-server
    clang
    gnumake
    nil
    nixfmt-classic
    snixembed
  ];
    
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
