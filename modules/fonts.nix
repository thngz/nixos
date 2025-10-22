{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    jetbrains-mono
    iosevka
    courier-prime
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    font-awesome
  ];
}
