{ ... }: {

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ./misc.nix
    ./main-user.nix
    ./xorg.nix
    ./development.nix
    ./fonts.nix
    ./networking.nix
    ./shell-utils.nix
    ./hardware.nix
    ./users-groups.nix
  ];
}

