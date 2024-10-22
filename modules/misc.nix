{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    parsec-bin
    okular
    anki
    obs-studio
    firefox
    libreoffice-qt6-still
    foliate
  ];
}
