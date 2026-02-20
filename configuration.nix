# NixOS Configuration
# Main entry point - all configuration is organized in ./system modules
{ config, lib, pkgs, inputs, zen-browser, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./system
  ];

  # XanMod Stable — LTS-based kernel with performance optimizations:
  # BBR3 (faster WiFi/network), BORE scheduler, NVIDIA compatible.
  # Fallback: pkgs.linuxPackages_6_12 (vanilla LTS)
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;

  # Note: All configuration has been modularized into ./system/
  # Structure:
  #   system/
  #   ├── core/          - Boot, Nix settings, Locale
  #   ├── hardware/      - Graphics, NVIDIA
  #   ├── network/       - NetworkManager, DNS
  #   ├── desktop/       - SDDM, KDE, Hyprland, services
  #   ├── users/         - User accounts, groups
  #   ├── programs/      - System programs
  #   ├── packages/      - All packages (organized by category)
  #   ├── environment/   - Environment variables
  #   ├── fonts/         - System fonts
  #   └── security/      - SSH, firewall
}
