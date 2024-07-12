{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    parsec-bin
    okular
    anki
    obs-studio
  ];
}
