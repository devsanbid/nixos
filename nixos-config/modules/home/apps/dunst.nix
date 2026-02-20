# Dunst — notification daemon (Catppuccin theme)
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.apps.dunst;
in
{
  options.modules.home.apps.dunst = {
    enable = lib.mkEnableOption "Dunst notification daemon";
  };

  config = lib.mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          width = 350;
          height = 150;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#89b4fa";
          frame_width = 2;
          corner_radius = 12;
          font = "mononoki Nerd Font 11";
          markup = "full";
          format = "<b>%s</b>\\n%b";
          alignment = "left";
          vertical_alignment = "center";
          icon_position = "left";
          icon_theme = "Tela-circle-dracula-dark";
          max_icon_size = 80;
          padding = 12;
          horizontal_padding = 12;
          text_icon_padding = 12;
          separator_color = "frame";
          separator_height = 2;
          progress_bar = true;
          progress_bar_height = 10;
          progress_bar_frame_width = 1;
          progress_bar_min_width = 150;
          progress_bar_max_width = 300;
          show_indicators = true;
          mouse_left_click = "do_action, close_current";
          mouse_middle_click = "close_all";
          mouse_right_click = "close_current";
        };

        urgency_low = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          frame_color = "#89b4fa";
          timeout = 5;
        };

        urgency_normal = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          frame_color = "#89b4fa";
          timeout = 10;
        };

        urgency_critical = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          frame_color = "#f38ba8";
          timeout = 0;
        };
      };
    };

    # Also source original dunst config for any extra overrides
    xdg.configFile."dunst" = {
      source = ../../../config/dunst;
      recursive = true;
    };
  };
}
