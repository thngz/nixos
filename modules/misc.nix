{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    parsec-bin
    discord
    okular
    anki
    obs-studio
  ];
}
