# Rofi — wayland launcher with 20+ mode configs
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.apps.rofi;
in
{
  options.modules.home.apps.rofi = {
    enable = lib.mkEnableOption "Rofi application launcher";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    # Source the full rofi config directory (calc, clipboard, emoji, etc.)
    xdg.configFile."rofi" = {
      source = ../../../config/rofi;
      recursive = true;
    };
  };
}
