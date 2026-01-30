# System packages - organized by category
{ pkgs, inputs, zen-browser, ... }: {

  imports = [
    ./system-tools.nix
    ./browsers.nix
    ./desktop-apps.nix
    ./development.nix
    ./multimedia.nix
    ./gaming.nix
    ./productivity.nix
    ./cli-tools.nix
    ./libraries.nix
  ];
}
