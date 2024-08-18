{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    parsec-bin
    okular
    anki
    obs-studio
    firefox
    foliate
  ];
}
