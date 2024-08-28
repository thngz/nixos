{ ... }:

{
  networking.firewall.allowedTCPPorts = [80 443];
  services.nginx.enable = true;
  services.nginx.virtualHosts."georgkivivali.com" = {
    root = "/var/www/georgkivivali.com";
    forceSSL = true;
    sslCertificate = "/etc/letsencrypt/live/georgkivivali.com/fullchain.pem";
    sslCertificateKey = "/etc/letsencrypt/live/georgkivivali.com/privkey.pem";
  };

}

