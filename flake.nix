{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/default/hardware-configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          xorg.enable = true;
          xorg.modKey = "Mod1";
          system.stateVersion = "23.11";
          development.enable = true;
        }
        ./modules
      ];
    };

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.home-manager.nixosModules.default
        ./hosts/laptop/hardware-configuration.nix
        {
          xorg.enable = true;
          xorg.modKey = "Mod4";
          system.stateVersion = "23.11";
          development.enable = true;
        }
        ./modules
      ];
    };


    nixosConfigurations.server = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.home-manager.nixosModules.default
        ./hosts/server/hardware-configuration.nix
        ./hosts/server/logind.nix
        ./modules/wireguard.nix
        ./modules/nginx.nix
        {
          xorg.enable = false;
          xorg.modKey = "Mod4";
          system.stateVersion = "23.11";
          development.enable = false;
        }

        ./modules
      ];
    };

  };
}
