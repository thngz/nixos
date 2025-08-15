{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    anki
    obs-studio
    firefox
        
    (chromium.override { enableWideVine = true; })
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
