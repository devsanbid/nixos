# Swappy — screenshot annotation
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.apps.swappy;
in
{
  options.modules.home.apps.swappy = {
    enable = lib.mkEnableOption "Swappy screenshot annotation";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."swappy" = {
      source = ../../../config/swappy;
      recursive = true;
    };
  };
}
