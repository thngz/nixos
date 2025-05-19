{ pkgs, ... }: {
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  networking.firewall.allowPing = true;
  services.resolved.enable = true;

  services.mullvad-vpn.enable = true;

  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ 9000 9001 3000 5000 6969];
    # allowedTCPPortRanges = [{
    #   from = 26000;
    #   to = 26100;
    # }];
  };
  
  # networking.extraHosts = ''127.0.0.1 nginx'';
    
  environment.systemPackages = with pkgs; [ mullvad-vpn bruno ];

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

}
