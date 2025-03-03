{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-unstable-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-unstable-small,
    nix-colors,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs;
          inherit nixos-unstable-small;
          inherit nix-colors;
          inherit inputs;
        };

        modules = [
          ./configuration.nix
        ];
      };
    };
    homeConfigurations."sanbid" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit nix-colors;
        inherit inputs;
      };
      modules = [./home.nix];
    };
  };
}
