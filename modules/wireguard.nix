{ ... }: {
  networking.firewall.allowedUDPPorts = [ 51820 ];
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.0.0.2/24" ];
      listenPort = 51820;

      privateKeyFile = "/root/wgkeys/private";
     
      peers = [{
        publicKey = "5TmuyqSPqNh+F0qs1hdx5yMMMUlnB+HxIJf9OnIpzwg=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "45.77.138.220:51820";
        persistentKeepalive = 25;
      }];
    };
  };
}

