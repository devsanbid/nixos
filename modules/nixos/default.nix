# NixOS System Modules — imports all system-level configuration
{ ... }:

{
  imports = [
    ./core
    ./desktop
    ./hardware
    ./network
    ./security
    ./services
    ./users
    ./programs
    ./packages
    ./environment
    ./fonts
    ./apps
    ./gaming.nix
    ./home-manager-auto.nix  # Auto-activate home-manager + snapshots
  ];
}
