{ ... }:
{
  imports = [
    ./nixvim.nix
    ./confs.nix
    ./crypto.nix
    ./xorg.nix
    ./wayland.nix
    ./development.nix
    ./fonts.nix
    ./networking.nix
    ./shell-tools.nix
    ./hardware.nix
    ./home.nix
    ./apps.nix
  ];
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 10d";
}
