{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    spotify
    discord
    anki
    obs-studio
    firefox
    qbittorrent
    qdigidoc
    vlc
    foliate
    wireshark
    libreoffice-qt6-still
    kdePackages.filelight
    kdePackages.kdenlive
    safeeyes
    zotero
    temurin-jre-bin-17
    mullvad-vpn
    bruno
    flameshot
    vim
  ];
  services.mullvad-vpn.enable = true;
}
