# NixOS Configuration
# Main entry point - all configuration is organized in ./system modules
{ config, lib, pkgs, inputs, zen-browser, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./system
  ];

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
