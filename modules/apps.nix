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
    (flameshot.override { enableWlrSupport = true; })
    vim
    mc # midnight commander
    clamav
    bitwarden-desktop
    calibre
    jujutsu
    syncthing
    meld
    helix
    dig
    netbird-ui
    nautilus
    mission-center
    sdrpp
    
    (gnuradio.override {
      extraPackages = with gnuradioPackages; [
        osmosdr
      ];
      extraPythonPackages = with gnuradio.python.pkgs; [
        numpy
      ];
    })
  ];
    
  hardware.rtl-sdr.enable = true;
  services.mullvad-vpn.enable = true;
  services.clamav.updater.enable = true;
  services.clamav.daemon.enable = false;
  services.netbird.enable = true;
}
