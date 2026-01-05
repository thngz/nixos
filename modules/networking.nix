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

    allowedTCPPorts = [ 22 8080 ]; # SSH, TurtleBot web interface
    allowedUDPPorts =
      [ 7400 7401 7402 7403 11811 ]; # FastRTPS + Discovery Server
    allowedUDPPortRanges = [{
      from = 7400;
      to = 7499;
    }];
    # allowedTCPPorts = [ 9000 9001 3000 5000 6969 5173];
  };

  services.openssh.enable = true;
  programs.ssh.startAgent = true;
  services.gnome.gcr-ssh-agent.enable = false;
}
