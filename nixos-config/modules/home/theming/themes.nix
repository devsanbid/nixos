# Themes — base16 color schemes
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.theming.themes;
in
{
  options.modules.home.theming.themes = {
    enable = lib.mkEnableOption "Color theme collection";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."themes" = {
      source = ../../../themes;
      recursive = true;
    };
    xdg.configFile."bookmarks" = {
      source = ../../../bookmarks;
      recursive = true;
    };
  };
}
