{ pkgs, ... }:

{

  documentation.man.generateCaches = false;
  users.users.gkiviv = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  time.timeZone = "Europe/Tallinn";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_IDENTIFICATION = "et_EE.UTF-8";
    LC_MEASUREMENT = "et_EE.UTF-8";
    LC_MONETARY = "et_EE.UTF-8";
    LC_NAME = "et_EE.UTF-8";
    LC_NUMERIC = "et_EE.UTF-8";
    LC_PAPER = "et_EE.UTF-8";
    LC_TELEPHONE = "et_EE.UTF-8";
    LC_TIME = "et_EE.UTF-8";
  };

  programs.fish.enable = true;
  programs.starship.enable = true;
  environment.shellAliases = { vim = "nvim"; };
  virtualisation.docker = {
    enable = true;
    extraOptions = "";
  };

  environment.localBinInPath = true;
  # nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings = {
    substituters = [
      # "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
      "https://ros.cachix.org"   
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
    ];
  };
  nix.settings.trusted-users = [ "root" "gkiviv" ];

  services.pcscd.enable = true;
}
