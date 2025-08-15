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
    gnuplot
  ];
  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.bash.shellAliases = {
    vim = "nvim";
  };
}
