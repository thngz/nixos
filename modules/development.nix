{ lib, config, pkgs, inputs, ... }:

let cfg = config.development;
in {
  options.development = {
    enable = lib.mkEnableOption "enable development module";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      distrobox
      flyctl
      tokei
      pods
      zed-editor
      jetbrains.datagrip
    ];

  };
}
