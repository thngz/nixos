{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-ld, home-manager, ... }@inputs:
    let system = "x86_64-linux";
    in {

      system = "x86_64-linux";
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };

        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true; # This works.
        };
        modules = [
          ./hosts/default/hardware-configuration.nix
          nix-ld.nixosModules.nix-ld
          home-manager.nixosModules.home-manager
          {
            xorg.enable = true;
            xorg.modKey = "Mod1";
            system.stateVersion = "23.11";
            development.enable = true;
          }
          ./modules
        ];
      };


      nixosConfigurations.laptop2 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true; # This works.
        };
        modules = [
          # home-manager.nixosModules.default {
          #       pkgs = pkgs;
          #  }
          nix-ld.nixosModules.nix-ld
             
          ./hosts/laptop2/hardware-configuration.nix
          {
            xorg.enable = true;
            xorg.modKey = "Mod1";
            system.stateVersion = "23.11";
            development.enable = true;
          }
          ./modules
        ];
      };

	
      nixosConfigurations.p16 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true; # This works.
        };
        modules = [
          nix-ld.nixosModules.nix-ld
             
          ./hosts/p16/hardware-configuration.nix
          {
            xorg.enable = false;
            wayland_desktop.enable = true;
            wayland_desktop.modKey = "Mod1";
            system.stateVersion = "25.11";
            development.enable = true;
          }
          ./modules
        ];
      };

    };
}
