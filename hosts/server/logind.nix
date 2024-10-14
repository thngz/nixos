{ ... }:

{
  services.logind.extraConfig = ''
    LidSwitchIgnoreInhibited=no
    HandleLidSwitch=ignore
  '';
}
