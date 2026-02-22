# Wallust — color scheme generation from wallpapers
{ config, lib, ... }:

let
  cfg = config.modules.home.theming.wallust;
in
{
  options.modules.home.theming.wallust = {
    enable = lib.mkEnableOption "Wallust color theming";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."wallust" = {
      source = ../../../config/wallust;
      recursive = true;
    };
  };
}
