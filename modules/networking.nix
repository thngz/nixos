{ pkgs, ... }: {
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  services.resolved.enable = true;
    
  # services.mullvad-vpn.enable = true;

  networking.firewall = { enable = true; };
  environment.systemPackages = with pkgs; [ mullvad-vpn bruno];

  services.openssh.enable = true;
  programs.ssh.startAgent = true;
      
}
