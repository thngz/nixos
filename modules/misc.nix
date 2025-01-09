{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    parsec-bin
    okular
    anki
    obs-studio
    firefox
    chromium
    foliate
    wireshark
    nmap
    libreoffice-qt6-still
    kdePackages.filelight
    kdePackages.kdenlive
    safeeyes
  ];
}
