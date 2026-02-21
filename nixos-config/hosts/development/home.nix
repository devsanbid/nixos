# HOME: Development — KDE-focused, no DMS, no waybar
{ ... }:

{
  imports = [ ../common/home.nix ];

  # KDE has its own panel — disable waybar
  modules.home.apps.waybar.enable = false;
}
