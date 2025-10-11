{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.printing.enable = true;

  services.pulseaudio.enable = false;

  boot.supportedFilesystems = [ "ntfs" ];

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [ pavucontrol clinfo ];
  nix.settings = {
    cores = 6;
    max-jobs = 2;
  };
}
