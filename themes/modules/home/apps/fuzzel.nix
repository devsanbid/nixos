# Fuzzel — fast Wayland launcher (Catppuccin Mocha theme)
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.apps.fuzzel;
in
{
  options.modules.home.apps.fuzzel = {
    enable = lib.mkEnableOption "Fuzzel application launcher";
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "Hack Nerd Font:size=14";
          dpi-aware = "no";
          width = 35;
          horizontal-pad = 20;
          vertical-pad = 12;
          inner-pad = 8;
          lines = 10;
          letter-spacing = 0;
          layer = "overlay";
          terminal = "kitty -e";
          prompt = "❯ ";
          icons-enabled = "yes";
          icon-theme = "Papirus-Dark";
        };
        colors = {
          background = "1e1e2efa";       # Catppuccin Mocha Base
          text = "cdd6f4ff";             # Text
          match = "89b4faff";            # Blue
          selection = "313244ff";        # Surface0
          selection-text = "cdd6f4ff";   # Text
          selection-match = "89b4faff";  # Blue
          border = "89b4fa80";           # Blue (50% opacity)
        };
        border = {
          width = 2;
          radius = 16;
        };
      };
    };
  };
}
