# Fastfetch — system info display
{ config, lib, ... }:

let
  cfg = config.modules.home.apps.fastfetch;
in
{
  options.modules.home.apps.fastfetch = {
    enable = lib.mkEnableOption "Fastfetch system info";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."fastfetch" = {
      source = ../../../config/fastfetch;
      recursive = true;
    };
  };
}
