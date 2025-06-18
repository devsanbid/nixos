{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-unstable-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    stylix.url = "github:danth/stylix";

    ## secure boot 
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixos-hardware, lanzaboote, stylix, nixpkgs, zen-browser
    , home-manager, nixos-unstable-small, nix-colors, nixvim, ... }@inputs:
    let
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
            inherit zen-browser;
          };

          modules = [
            stylix.nixosModules.stylix
            ./configuration.nix
            lanzaboote.nixosModules.lanzaboote
          ];
        };
      };
      homeConfigurations."sanbid" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit nix-colors;
          inherit inputs;
        };
        modules = [
          stylix.homeManagerModules.stylix
          ./home.nix
          nixvim.homeManagerModules.nixvim
        ];
      };
    };
}
