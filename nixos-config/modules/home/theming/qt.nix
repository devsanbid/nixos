# Qt theming — qt5ct, qt6ct, pip, vivid, shortcuts
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.theming.qt;
in
{
  options.modules.home.theming.qt = {
    enable = lib.mkEnableOption "Qt/misc theming configs";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "qt5ct" = {
        source = ../../../config/qt5ct;
        recursive = true;
      };
      "qt6ct" = {
        source = ../../../config/qt6ct;
        recursive = true;
      };
      "pip" = {
        source = ../../../config/pip;
        recursive = true;
      };
      "vivid" = {
        source = ../../../config/vivid;
        recursive = true;
      };
      "short_cut.kksrc" = {
        source = ../../../short_cut.kksrc;
      };
    };
  };
}
