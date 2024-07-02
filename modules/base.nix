{ lib, pkgs, inputs, ... }:

{
  main-user.enable = true;
  main-user.userName = "gkiviv";
    
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
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

  services.printing.enable = true;
  services.mullvad-vpn.enable = true;

  networking.firewall = {
      enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
  # enable docker
  virtualisation.docker.enable = true;
 
  services.xserver.xautolock.time = 40;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "gkiviv" = import ./home.nix; };
  };

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    firefox
    starship
    xclip
    inputs.nil.packages."${pkgs.system}".default
    inputs.nixfmt.packages."${pkgs.system}".default
    pavucontrol
    vim
    direnv
    dumb-init
    tree
    parsec-bin
  ];

  programs.fish.enable = true;
  programs.starship.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  fonts.packages = with pkgs; [
      jetbrains-mono 
      iosevka
  ];
}
