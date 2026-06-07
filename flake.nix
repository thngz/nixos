{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-ld,
      nixvim,
      home-manager,
      niri-flake,
      noctalia,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };

        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true;
        };
        modules = [
          ./hosts/default/hardware-configuration.nix
          nix-ld.nixosModules.nix-ld
          nixvim.nixosModules.nixvim
          home-manager.nixosModules.home-manager
          niri-flake.nixosModules.niri
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          {
            niri.enable = true;
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
          nix-ld.nixosModules.nix-ld
          niri-flake.nixosModules.niri

          ./hosts/laptop2/hardware-configuration.nix
          {
            xorg.enable = true;
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
          niri-flake.nixosModules.niri

          nixvim.nixosModules.nixvim
          ./hosts/p16/hardware-configuration.nix
          {
            niri.enable = true;
            system.stateVersion = "25.11";
            development.enable = true;
          }
          ./modules
        ];
      };

    };
}
