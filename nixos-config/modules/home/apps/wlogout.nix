# Wlogout — logout/power menu
{ config, lib, ... }:

let
  cfg = config.modules.home.apps.wlogout;
in
{
  options.modules.home.apps.wlogout = {
    enable = lib.mkEnableOption "Wlogout power menu";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."wlogout" = {
      source = ../../../config/wlogout;
      recursive = true;
    };
  };
}
