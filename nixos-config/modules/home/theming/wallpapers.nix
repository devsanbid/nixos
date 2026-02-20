# Wallpapers
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.theming.wallpapers;
in
{
  options.modules.home.theming.wallpapers = {
    enable = lib.mkEnableOption "Wallpaper collection";
  };

  config = lib.mkIf cfg.enable {
    home.file."Pictures/wallpapers".source = ../../../config/wallpapers;
    xdg.configFile."wallpapers" = {
      source = ../../../config/wallpapers;
      recursive = true;
    };
  };
}
