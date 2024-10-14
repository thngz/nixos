{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    kitty
    tree
    direnv
    dumb-init
    xclip
    wget
    starship
    rlwrap
        
  ];
  programs.fish.enable = true;
  programs.starship.enable = true;
}
