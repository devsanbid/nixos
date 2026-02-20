# Hyprland Rice — JaKooLit config with DMS integration
# Sources the full hyprland_2.0 directory
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.theming.hyprland-rice;
in
{
  options.modules.home.theming.hyprland-rice = {
    enable = lib.mkEnableOption "Hyprland JaKooLit rice (config/hyprland_2.0)";
  };

  config = lib.mkIf cfg.enable {
    # Source the full JaKooLit Hyprland config (modular scripts, animations, etc.)
    xdg.configFile."hypr" = {
      source = ../../../config/hyprland_2.0;
      recursive = true; # Allow DMS to write theme files
    };
  };
}
