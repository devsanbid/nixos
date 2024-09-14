{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-unstable-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, stylix, nixos-unstable-small, nix-colors, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      unstable-small-pkgs = import nixos-unstable-small { inherit system; };
      xdphOverlay = final: prev: {
        inherit (unstable-small-pkgs) xdg-desktop-portal-hyprland;
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ xdphOverlay ];
      };
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs; inherit nix-colors; };

          modules = [ stylix.nixosModules.stylix ./configuration.nix ];
        };
      };
      homeConfigurations."sanbid" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit nix-colors; inherit inputs; };
        modules = [ stylix.homeManagerModules.stylix ./home.nix ];
      };
    };
}

