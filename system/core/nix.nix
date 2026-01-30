# Nix and Nixpkgs configuration
{ inputs, ... }: {

  # Nixpkgs configuration
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
    cudaSupport = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];

  # Nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "sanbid" ];
    };
    optimise.automatic = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  # System version - DON'T CHANGE THIS
  system.stateVersion = "24.05";
}
