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
            inputs.home-manager.nixosModules.default
            {
                i3.enable = true;
                i3.modKey = "Mod1";
                system.stateVersion = "23.11";
            }
          ./modules
          ];
        };
     nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
         specialArgs = {inherit inputs;};
         modules = [
            ./hosts/laptop/hardware-configuration.nix
            inputs.home-manager.nixosModules.default
            {
                i3.enable = true;
                i3.modKey = "Mod4";
                system.stateVersion = "23.11";
            }     
            ./modules
         ];
     };
    };
}
