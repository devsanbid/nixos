# AGS — Widget system
{ config, lib, ... }:

let
  cfg = config.modules.home.theming.ags;
in
{
  options.modules.home.theming.ags = {
    enable = lib.mkEnableOption "AGS widget system";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."ags" = {
      source = ../../../config/ags;
      recursive = true;
    };
  };
}
