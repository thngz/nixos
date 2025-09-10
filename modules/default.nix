{ ... }: {

  environment.localBinInPath = true;
  # nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      # "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

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

