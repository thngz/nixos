
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./main-user.nix
    ];

  main-user.enable = true;
  main-user.userName = "gkiviv";

  # Bootloader.
  boot.loader.grub.enable = true;


  boot.loader.grub.device = "nodev";

  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.

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

  services.xserver.enable = true;

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager = {
    xterm.enable = false;
    xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
    };
  };

  services.xserver.displayManager.defaultSession = "xfce";
  
  services.xserver.windowManager.i3 = {
     enable = true;

     extraPackages = with pkgs; [
        rofi
        i3status
        i3blocks
     ];
  };

  services.xserver = {
    xkb.layout = "us,ee";
    xkbVariant = "";
    xkbOptions = "ctrl:swapcaps, grp:rctrl_toggle";
  };

  services.printing.enable = true;

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
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
       "gkiviv" = import ./home.nix;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    clang
    firefox
    xclip
  ];
  
  programs.fish.enable = true;


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true; 
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "23.11"; # Did you read the comment?
}
