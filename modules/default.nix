{ ... }: {
  imports = [
    ./confs.nix
    ./xorg.nix
    ./development.nix
    ./fonts.nix
    ./networking.nix
    ./shell-tools.nix
    ./hardware.nix
    ./home.nix
    ./apps.nix
  ];
}

