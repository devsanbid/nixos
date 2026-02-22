# Kitty terminal — GPU-accelerated, Nerd Font, transparent
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.terminal.kitty;
in
{
  options.modules.home.terminal.kitty = {
    enable = lib.mkEnableOption "Kitty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      font = {
        name = "CaskaydiaCove Nerd Font";
        size = 18;
      };

      settings = {
        # ── Appearance ──────────────────────────────────────
        background_opacity = "0.85";
        background = "#000000";
        window_padding_width = 10;
        confirm_os_window_close = 0;
        hide_window_decorations = true;

        # ── Tab bar ─────────────────────────────────────────
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";

        # ── Cursor ──────────────────────────────────────────
        cursor_shape = "beam";
        cursor_blink_interval = "0.5";

        # ── Scrollback ──────────────────────────────────────
        scrollback_lines = 10000;

        # ── Bell ────────────────────────────────────────────
        enable_audio_bell = false;

        # ── URL handling ────────────────────────────────────
        url_style = "curly";
        open_url_with = "default";
        detect_urls = true;

        # ── Shell ───────────────────────────────────────────
        shell = "${lib.getExe pkgs.zsh}";

        clear_all_shortcuts = true;

        # ── Shell integration ──────────────────────────────
        shell_integration = "no-rc";
      };

      keybindings = {
        "ctrl+shift+t" = "new_tab_with_cwd";
        "ctrl+shift+enter" = "new_window_with_cwd";
        "ctrl+shift+equal" = "change_font_size all +1.0";
        "ctrl+shift+minus" = "change_font_size all -1.0";
        "ctrl+shift+0" = "change_font_size all 0";
      };

      # ── Theme ─────────────────────────────────────────────
      themeFile = "tokyo_night_night";
    };
  };
}
