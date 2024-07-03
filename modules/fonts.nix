{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
      jetbrains-mono 
      iosevka
  ];
}
