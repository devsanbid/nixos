# Home-Manager: Niri scrollable tiling compositor
# Keybindings mapped similar to Hyprland for consistency
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.desktop.niri;
in
{
  options.modules.home.desktop.niri = {
    enable = lib.mkEnableOption "Niri window manager (Home-Manager)";
  };

  config = lib.mkIf cfg.enable {
    programs.niri = {
      settings = {
        # ── Input ─────────────────────────────────────────────
        input = {
          keyboard.xkb.layout = "us";
          touchpad = {
            tap = true;
            dwt = true;
            natural-scroll = true;
          };
          mouse = {
            accel-speed = 0.3;
            scroll-factor = 1.5;
          };
        };

        # ── Layout ────────────────────────────────────────────
        layout = {
          gaps = 16;
          center-focused-column = "never";
          preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
          ];
          default-column-width = { proportion = 0.5; };
          focus-ring = {
            enable = true;
            width = 4;
            active.color = "#33ccff";
            inactive.color = "#595959";
          };
          border.enable = false;
          struts = {
            left = 0;
            right = 0;
            top = 0;
            bottom = 0;
          };
        };

        # ── Appearance ────────────────────────────────────────
        prefer-no-csd = true;

        # ── Environment (similar to Hyprland) ─────────────────
        environment = {
          XCURSOR_SIZE = "24";
          QT_QPA_PLATFORM = "wayland";
          QT_QPA_PLATFORMTHEME = "qt6ct";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          GDK_BACKEND = "wayland,x11";
          SDL_VIDEODRIVER = "wayland";
          CLUTTER_BACKEND = "wayland";
          XDG_CURRENT_DESKTOP = "niri";
          XDG_SESSION_TYPE = "wayland";
        };

        # ── Startup ───────────────────────────────────────────
        spawn-at-startup = [
          { argv = [ "waybar" ]; }
          { argv = [ "swaync" ]; }
          { argv = [ "swww-daemon" ]; }
          { argv = [ "nm-applet" "--indicator" ]; }
        ];

        # ── Keybindings (matching Hyprland!) ─────────────────
        binds = {
          # ── Core (same as Hyprland) ─────────────────────
          "Mod+Q".action.spawn = "kitty";
          "Mod+C".action.close-window = [];
          "Mod+M".action.quit.skip-confirmation = true;
          "Mod+E".action.spawn = "thunar";
          "Mod+V".action.toggle-window-floating = [];
          "Mod+R".action.spawn = "fuzzel";
          "Mod+F".action.maximize-column = [];
          "Mod+Shift+F".action.fullscreen-window = [];
          "Mod+B".action.spawn = "firefox";
          "Mod+N".action.spawn = [ "swaync-client" "-t" "-sw" ];
          "Mod+L".action.spawn = [ "bash" "-c" "swaylock || hyprlock" ];
          "Mod+Backspace".action.spawn = "wlogout";

          # ── Clipboard (Mod+Shift+V since Mod+V is float) ─
          "Mod+Shift+V".action.spawn = [ "bash" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy" ];

          # ── Screenshot (same as Hyprland) ───────────────
          "Print".action.screenshot = [];
          "Mod+Print".action.screenshot-window = [];
          "Mod+Shift+Print".action.spawn = [ "bash" "-c" "grim -g \"$(slurp)\" - | swappy -f -" ];

          # ── Focus (vim-style h/j/k, arrow keys for full set) ─
          "Mod+H".action.focus-column-left = [];
          "Mod+J".action.focus-window-down = [];
          "Mod+K".action.focus-window-up = [];

          "Mod+Left".action.focus-column-left = [];
          "Mod+Down".action.focus-window-down = [];
          "Mod+Up".action.focus-window-up = [];
          "Mod+Right".action.focus-column-right = [];

          # ── Move windows (vim-style + arrows) ───────────
          "Mod+Shift+H".action.move-column-left = [];
          "Mod+Shift+J".action.move-window-down = [];
          "Mod+Shift+K".action.move-window-up = [];
          "Mod+Shift+L".action.move-column-right = [];

          "Mod+Shift+Left".action.move-column-left = [];
          "Mod+Shift+Down".action.move-window-down = [];
          "Mod+Shift+Up".action.move-window-up = [];
          "Mod+Shift+Right".action.move-column-right = [];

          # ── Resize (same as Hyprland Ctrl+hjkl) ────────
          "Mod+Ctrl+H".action.set-column-width = "-5%";
          "Mod+Ctrl+L".action.set-column-width = "+5%";
          "Mod+Ctrl+K".action.set-window-height = "-5%";
          "Mod+Ctrl+J".action.set-window-height = "+5%";

          # ── Workspaces 1-10 (same as Hyprland) ─────────
          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;
          "Mod+0".action.focus-workspace = 10;

          "Mod+Shift+1".action.move-column-to-workspace = 1;
          "Mod+Shift+2".action.move-column-to-workspace = 2;
          "Mod+Shift+3".action.move-column-to-workspace = 3;
          "Mod+Shift+4".action.move-column-to-workspace = 4;
          "Mod+Shift+5".action.move-column-to-workspace = 5;
          "Mod+Shift+6".action.move-column-to-workspace = 6;
          "Mod+Shift+7".action.move-column-to-workspace = 7;
          "Mod+Shift+8".action.move-column-to-workspace = 8;
          "Mod+Shift+9".action.move-column-to-workspace = 9;
          "Mod+Shift+0".action.move-column-to-workspace = 10;

          # ── Special workspace (Hyprland togglespecialworkspace) ─
          "Mod+S".action.focus-workspace = 11;
          "Mod+Shift+S".action.move-column-to-workspace = 11;

          # ── Waybar toggle (same as Hyprland) ────────────
          "Mod+W".action.spawn = [ "bash" "-c" "killall waybar || waybar" ];

          # ── Niri-specific (column management) ───────────
          "Mod+Tab".action.focus-workspace-previous = [];
          "Mod+Comma".action.consume-window-into-column = [];
          "Mod+Period".action.expel-window-from-column = [];
          "Mod+Shift+Q".action.quit.skip-confirmation = true;

          # ── Media / Fn keys (same as Hyprland) ──────────
          "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" ];
          "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
          "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
          "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "s" "5%+" ];
          "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "s" "5%-" ];
          "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
          "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];
          "XF86AudioNext".action.spawn = [ "playerctl" "next" ];
        };

        # ── Window Rules ──────────────────────────────────────
        window-rules = [
          {
            matches = [{ app-id = "^pavucontrol$"; }];
            open-floating = true;
          }
          {
            matches = [{ app-id = "^nm-connection-editor$"; }];
            open-floating = true;
          }
          {
            matches = [{ app-id = "^blueman-manager$"; }];
            open-floating = true;
          }
          {
            matches = [{ app-id = "^thunar$"; }];
            open-floating = true;
          }
          {
            matches = [
              { app-id = "^firefox$"; }
              { app-id = "^brave-browser$"; }
            ];
            opacity = 0.9;
          }
          {
            matches = [
              { app-id = "^kitty$"; }
              { app-id = "^Alacritty$"; }
            ];
            opacity = 0.8;
          }
        ];
      };
    };
  };
}
