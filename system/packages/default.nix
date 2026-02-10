# System packages - organized by category
{ pkgs, inputs, zen-browser, ... }: {

  imports = [
    ./system-tools.nix
    ./browsers.nix
    ./desktop-apps.nix
    ./development.nix
    ./flutter.nix
    ./jupyter.nix
    ./multimedia.nix
    ./gaming.nix
    ./productivity.nix
    ./cli-tools.nix
    ./libraries.nix
    ./dms.nix
    ./roxy-browser  # RoxyBrowser from .deb
  ];
}
