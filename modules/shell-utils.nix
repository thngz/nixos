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
  ];
  programs.fish.enable = true;
  programs.starship.enable = true;
  environment.shellAliases = { vim = "nvim"; };
}
