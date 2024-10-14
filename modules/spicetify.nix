{ inputs, pkgs, ... }: {
  imports = [ inputs.spicetify-nix.nixosModules.default ];

  programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [ adblock hidePodcasts ];
    };
}
