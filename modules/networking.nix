{ pkgs, ... }: {
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.mullvad-vpn.enable = true;

  networking.firewall = { enable = true; };

  environment.systemPackages = with pkgs; [ mullvad-vpn ];

  services.openssh.enable = true;
  programs.ssh.startAgent = true;
}
