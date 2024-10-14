{ lib, config, pkgs, inputs, ... }:

let cfg = config.development;
in {
  options.development = {
    enable = lib.mkEnableOption "enable development module";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      python3
      lua-language-server
      ripgrep
      tmux
      clang
      distrobox
      flyctl
      gnumake
      nil
      nixfmt
      vim
      dbeaver-bin
    ];

    programs.neovim = {
      enable = true;
      withNodeJs = true;
      withPython3 = true;
    };

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

  };
}
