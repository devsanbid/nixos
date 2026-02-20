# Cava — audio visualizer
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.apps.cava;
in
{
  options.modules.home.apps.cava = {
    enable = lib.mkEnableOption "Cava audio visualizer";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."cava" = {
      source = ../../../config/cava;
      recursive = true;
    };
  };
}
