# Waybar — status bar for Hyprland/Niri
# Sources existing config directory with 40+ presets
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.apps.waybar;
in
{
  options.modules.home.apps.waybar = {
    enable = lib.mkEnableOption "Waybar status bar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = false; # Managed by compositor
    };

    # Source the full waybar config directory (40+ presets)
    xdg.configFile."waybar" = {
      source = ../../../config/waybar;
      recursive = true;
    };
  };
}
