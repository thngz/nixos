{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
    zotero
    temurin-jre-bin-17
  ];

    
  documentation.man.generateCaches = false;

}
