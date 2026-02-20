# System packages — organized by category
{ pkgs, inputs, zen-browser, ... }:

{
  imports = [
    ./cli-tools.nix
    ./desktop-apps.nix
    ./development.nix
    ./browsers.nix
    ./multimedia.nix
    ./productivity.nix
    ./system-tools.nix
    ./libraries.nix
    ./flutter.nix
    ./dms.nix
  ];
}
