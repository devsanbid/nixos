# Nix settings — flakes, unfree, CUDA, store optimization
{ inputs, ... }:

{
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
    cudaSupport = true;
    permittedInsecurePackages = [
      "electron-36.9.5"
    ];
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "sanbid" ];
    };
    optimise.automatic = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  system.stateVersion = "24.05";
}
