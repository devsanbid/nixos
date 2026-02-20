# Alacritty terminal — fast, minimal, transparent
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.terminal.alacritty;
in
{
  options.modules.home.terminal.alacritty = {
    enable = lib.mkEnableOption "Alacritty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        # ── Shell ───────────────────────────────────────────
        terminal.shell = {
          program = "/run/current-system/sw/bin/fish";
          args = [ "--login" ];
        };

        # ── Window ──────────────────────────────────────────
        window = {
          padding = { x = 10; y = 10; };
          opacity = 0.59;
          decorations = "None";
          startup_mode = "Windowed";
        };

        # ── Font ────────────────────────────────────────────
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          bold.family = "JetBrainsMono Nerd Font";
          italic.family = "JetBrainsMono Nerd Font";
          size = 16.0;
        };

        # ── Scrolling ──────────────────────────────────────
        scrolling = {
          history = 10000;
          multiplier = 3;
        };

        # ── Colors (Tokyo Night) ───────────────────────────
        colors = {
          primary = {
            background = "#1a1b26";
            foreground = "#c0caf5";
          };
          normal = {
            black = "#15161e";
            red = "#f7768e";
            green = "#9ece6a";
            yellow = "#e0af68";
            blue = "#7aa2f7";
            magenta = "#bb9af7";
            cyan = "#7dcfff";
            white = "#a9b1d6";
          };
          bright = {
            black = "#414868";
            red = "#f7768e";
            green = "#9ece6a";
            yellow = "#e0af68";
            blue = "#7aa2f7";
            magenta = "#bb9af7";
            cyan = "#7dcfff";
            white = "#c0caf5";
          };
        };

        # ── Cursor ──────────────────────────────────────────
        cursor.style = {
          shape = "Beam";
          blinking = "On";
        };

        # ── Mouse ───────────────────────────────────────────
        mouse.hide_when_typing = true;
      };
    };
  };
}
