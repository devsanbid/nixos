# System modules index
# This file imports all system configuration modules
{ config, pkgs, inputs, zen-browser, ... }: {
  imports = [
    # Core system configuration
    ./core           # Boot, Nix settings, Locale

    # Hardware
    ./hardware       # Graphics, NVIDIA, firmware

    # Network
    ./network        # NetworkManager, DNS, firewall

    # Desktop & Display
    ./desktop        # SDDM, KDE, Hyprland, services

    # Users & Security
    ./users          # User accounts, groups, sudo
    ./security       # SSH, firewall rules, automount

    # Programs & Packages
    ./programs       # System programs configuration
    ./packages       # All system packages

    # Environment
    ./environment    # Environment variables

    # Fonts
    ./fonts          # System fonts

    # Legacy modules (review for duplicates)
    ./app            # Docker, Flatpak, Virtualization
    ./wm             # Hyprland, Wayland, Pipewire
  ];
}
