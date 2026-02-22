# Btop — system monitor (Catppuccin Macchiato theme)
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.apps.btop;
in
{
  options.modules.home.apps.btop = {
    enable = lib.mkEnableOption "Btop system monitor";
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin_macchiato";
        theme_background = false;  # Transparent background
        vim_keys = false;
        rounded_corners = true;
        graph_symbol = "braille";
        shown_boxes = "proc cpu mem net";
        update_ms = 1000;
        proc_sorting = "cpu lazy";
        proc_tree = false;
      };
    };

    # Source theme files
    xdg.configFile."btop/themes" = {
      source = ../../../config/btop/themes;
      recursive = true;
    };
  };
}
