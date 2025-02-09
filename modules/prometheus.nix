{ config, pkgs, ... }: {

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
      {
        job_name = "crowdsec";
        static_configs = [{ targets = [ "10.0.0.1:6060" ]; }];

      }
    ];

  };
  services.grafana = {
    enable = true;
    port = 3000;
    addr = "192.168.40.107";
  };
}

