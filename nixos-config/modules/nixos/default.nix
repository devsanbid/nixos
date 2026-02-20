# NixOS System Modules — imports all system-level configuration
{ config, lib, pkgs, inputs, zen-browser, ... }:

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
  ];
}
