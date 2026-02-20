{
  description = "Sanbid's Modern NixOS Configuration — Work / Development / Personal";

  inputs = {
    # ── Core ──────────────────────────────────────────────────
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ── Theming ───────────────────────────────────────────────
    nix-colors.url = "github:misterio77/nix-colors";
    stylix.url = "github:danth/stylix";

    # ── Security ──────────────────────────────────────────────
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ── Desktop ───────────────────────────────────────────────
    niri.url = "github:sodiboo/niri-flake";

    # ── Apps ──────────────────────────────────────────────────
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ── Shell Extensions ──────────────────────────────────────
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
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # ── Helper: create a NixOS system for a given host ──────
      mkHost = hostname: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs;
          zen-browser = inputs.zen-browser;
          hostname = hostname;
        };
        modules = [
          # Flake modules
          inputs.stylix.nixosModules.stylix
          inputs.lanzaboote.nixosModules.lanzaboote

          # Home-Manager as NixOS module (integrated)
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs outputs;
                nix-colors = inputs.nix-colors;
                hostname = hostname;
              };
              users.sanbid = import ./hosts/${hostname}/home.nix;
            };
          }

          # Host-specific config
          ./hosts/${hostname}
        ];
      };
    in
    {
      # ── NixOS Configurations ────────────────────────────────
      nixosConfigurations = {
        work        = mkHost "work";
        development = mkHost "development";
        personal    = mkHost "personal";
      };

      # ── Dev Shell (for working on this config) ──────────────
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [ nil nixd alejandra deadnix statix nh ];
      };
    };
}
