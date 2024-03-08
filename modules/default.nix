{config, pkgs, ...}:
{
    imports = [
        ./base.nix
        ./main-user.nix
        ./xorg.nix
    ];
}

