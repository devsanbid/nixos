# Distrobox - Run any Linux distribution inside your terminal
{ pkgs, ... }:

{
  # Enable Podman (recommended backend for Distrobox on NixOS)
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;  # Keep false since you have Docker enabled
    defaultNetwork.settings.dns_enabled = true;
  };

  # Install Distrobox and dependencies
  environment.systemPackages = with pkgs; [
    distrobox
    podman
    podman-compose
    xorg.xhost  # Required for GUI apps
  ];

  # Add user to podman group (not strictly required but useful)
  users.users."sanbid".extraGroups = [ "podman" ];
}
