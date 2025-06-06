{ ... }: {

  environment.localBinInPath = true;
  # nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
  services.pcscd.enable = true;
  imports = [
    ./misc.nix
    ./xorg.nix
    ./development.nix
    ./fonts.nix
    ./networking.nix
    ./shell-utils.nix
    ./utils.nix
    ./hardware.nix
    ./users-groups.nix
    ./communications.nix
    ./home.nix
  ];
}

