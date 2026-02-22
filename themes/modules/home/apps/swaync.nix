# SwayNC — notification center
{ config, lib, ... }:

let
  cfg = config.modules.home.apps.swaync;
in
{
  options.modules.home.apps.swaync = {
    enable = lib.mkEnableOption "SwayNC notification center";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."swaync" = {
      source = ../../../config/swaync;
      recursive = true;
    };
  };
}
