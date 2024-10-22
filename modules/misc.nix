{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    parsec-bin
    okular
    anki
    obs-studio
    firefox
    foliate
    wireshark
    nmap
    libreoffice-qt6-still
  ];
}
