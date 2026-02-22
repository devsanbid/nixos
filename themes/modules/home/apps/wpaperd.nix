# Wpaperd — wallpaper daemon
{ config, lib, ... }:

let
  cfg = config.modules.home.apps.wpaperd;
in
{
  options.modules.home.apps.wpaperd = {
    enable = lib.mkEnableOption "Wpaperd wallpaper daemon";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."wpaperd" = {
      source = ../../../config/wpaperd;
      recursive = true;
    };
  };
}
