{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };

     nil = {
        url = "github:oxalica/nil";
        inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hosts/default/hardware-configuration.nix
            ./modules/main-user.nix
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.default
            ./modules/xorg.nix
          ];
        };
     nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
         specialArgs = {inherit inputs;};
         modules = [
            ./hosts/laptop/hardware-configuration.nix
            ./modules/main-user.nix
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.default
            ./modules/xorg.nix
         ];
     };
    };
}
