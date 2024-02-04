{
  description = "Tugrul's NixOS Flake";

  inputs = {
    
    #nix version
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    #home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

       modules = [

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tbu = import ./config;

          }

          ./configuration.nix
        ];
      };
    };
  };
}
