{ lib, config, pkgs, ... }:
let cfg = config.prometheus;
in {
  options.prometheus = {
        enable = lib.mkEnableOption "enable prometheus"; 
        grafanaIP = lib.mkOption {
            default = 127.0.0.1;
            description = "Address on which grafana starts running";
        }

        grafanaIP = lib.mkOption {
            default = 127.0.0.1;
            description = "Address on which grafana starts running";
        }

        enableCrowdSecScrape = lib.mkEnableOption "Whether or not to turn on crowdsec metrics scrape";
            
        crowdSecIP = lib.mkOption {
            default = "127.0.0.1";
            description = "Crowdsec metrics endpoint";
        }
    };

  config = lib.mkIf cfg.enable {

    services.prometheus = {

      enable = true;
      port = 9001;
      globalConfig.scrape_interval = "10s";

      exporters = {
        node = {
          enable = true;
          port = 9000;
          enabledCollectors = [ "systemd" ];
          extraFlags = [
            "--collector.ethtool"
            "--collector.softirqs"
            "--collector.tcpstat"
            "--collector.wifi"
          ];

        };
      };
      scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [{
            targets = [
              "127.0.0.1:${
                toString config.services.prometheus.exporters.node.port
              }"
            ];
          }];
        }
          config = lib.mkIf cfg.enable {
        {
          job_name = "crowdsec";
          static_configs = [{ targets = [ "10.0.0.1:6060" ]; }];
        }
      ];

    };
  };
  services.grafana = {
    enable = true;
    port = 3000;
    addr = config.grafanaIP;
  };
}

