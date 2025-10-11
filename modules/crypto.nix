{pkgs, ...}:
{
    services.pcscd.enable = true;

    environment.systemPackages = with pkgs; [
        pinentry-curses
    ];

    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
    };
}
