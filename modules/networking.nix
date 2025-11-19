{ pkgs, ... }: {
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  networking.firewall.allowPing = true;
  services.resolved.enable = true;
  networking.enableIPv6 = false;

  networking.firewall = {
    enable = true;
    checkReversePath = false;
    # allowedTCPPorts = [ 9000 9001 3000 5000 6969 5173];
  };
  
  services.openssh.enable = true;
  programs.ssh.startAgent = true;
}
