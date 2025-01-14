{ pkgs, lib, ... }:

{

  services.crowdsec = let
    yaml = (pkgs.formats.yaml { }).generate;

    acquisitions_file = yaml "acquisitions.yaml" {
      source = "journalctl";
      journalctl_filter = [ "_SYSTEMD_UNIT=sshd.service" ];
      labels.type = "syslog";
    };
  in {

    enable = true;
    # enrollKeyFile = "/home/gkiviv/.crowdseckey/enroll-key";
    settings = {
      api.server = { listen_uri = "127.0.0.1:8080"; };
      crowdsec_service.acquisition_path = acquisitions_file;

    };

  };

  systemd.services.crowdsec.serviceConfig = {

    ExecStartPre = let
      script = pkgs.writeScriptBin "download-collection" ''
        #!${pkgs.runtimeShell}
        cscli collections install crowdsecurity/linux
        cscli collections install crowdsecurity/nginx
      '';
    in [ "${script}/bin/download-collection" ];
  };
}
