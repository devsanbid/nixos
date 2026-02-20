{
  description = "Modern NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    stylix.url = "github:danth/stylix";
    
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      nixosConfigurations = {
        work = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; zen-browser = inputs.zen-browser; };
          modules = [ 
            inputs.stylix.nixosModules.stylix
            inputs.lanzaboote.nixosModules.lanzaboote
            ./hosts/work 
          ];
        };
        development = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; zen-browser = inputs.zen-browser; };
          modules = [ 
            inputs.stylix.nixosModules.stylix
            inputs.lanzaboote.nixosModules.lanzaboote
            ./hosts/development 
          ];
        };
        testing = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; zen-browser = inputs.zen-browser; };
          modules = [ 
            inputs.stylix.nixosModules.stylix
            inputs.lanzaboote.nixosModules.lanzaboote
            ./hosts/testing 
          ];
        };
        personal = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; zen-browser = inputs.zen-browser; };
          modules = [ 
            inputs.stylix.nixosModules.stylix
            inputs.lanzaboote.nixosModules.lanzaboote
            ./hosts/personal 
          ];
        };
      };

      homeConfigurations = {
        "sanbid@work" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; nix-colors = inputs.nix-colors; };
          modules = [ 
            inputs.stylix.homeManagerModules.stylix
            inputs.nixvim.homeManagerModules.nixvim
            inputs.dms.homeModules.dank-material-shell
            inputs.danksearch.homeModules.dsearch
            ./hosts/work/home.nix 
          ];
        };
        "sanbid@development" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; nix-colors = inputs.nix-colors; };
          modules = [ 
            inputs.stylix.homeManagerModules.stylix
            inputs.nixvim.homeManagerModules.nixvim
            inputs.dms.homeModules.dank-material-shell
            inputs.danksearch.homeModules.dsearch
            ./hosts/development/home.nix 
          ];
        };
        "sanbid@testing" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; nix-colors = inputs.nix-colors; };
          modules = [ 
            inputs.stylix.homeManagerModules.stylix
            inputs.nixvim.homeManagerModules.nixvim
            inputs.dms.homeModules.dank-material-shell
            inputs.danksearch.homeModules.dsearch
            ./hosts/testing/home.nix 
          ];
        };
        "sanbid@personal" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; nix-colors = inputs.nix-colors; };
          modules = [ 
            inputs.stylix.homeManagerModules.stylix
            inputs.nixvim.homeManagerModules.nixvim
            inputs.dms.homeModules.dank-material-shell
            inputs.danksearch.homeModules.dsearch
            ./hosts/personal/home.nix 
          ];
        };
      };
    };
}
