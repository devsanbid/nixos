# Home-Manager: Hyprland window manager configuration
# Full keybindings, animations, decoration, window rules
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.desktop.hyprland;
in
{
  options.modules.home.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland window manager (Home-Manager)";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      settings = {
        # ── Monitor ───────────────────────────────────────────
        monitor = [
          ",preferred,auto,1"
        ];

        # ── Environment ───────────────────────────────────────
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "GDK_BACKEND,wayland,x11,*"
          "QT_QPA_PLATFORM,wayland;xcb"
          "QT_QPA_PLATFORMTHEME,qt6ct"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "SDL_VIDEODRIVER,wayland"
          "CLUTTER_BACKEND,wayland"
        ];

        # ── General ───────────────────────────────────────────
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        # ── Decoration ────────────────────────────────────────
        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 6;
            passes = 3;
            new_optimizations = true;
            xray = true;
            ignore_opacity = true;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
        };

        # ── Animations ────────────────────────────────────────
        animations = {
          enabled = true;
          bezier = [
            "myBezier, 0.05, 0.9, 0.1, 1.05"
            "linear, 0.0, 0.0, 1.0, 1.0"
            "wind, 0.05, 0.9, 0.1, 1.05"
            "winIn, 0.1, 1.1, 0.1, 1.1"
            "winOut, 0.3, -0.3, 0, 1"
            "slow, 0, 0.85, 0.3, 1"
            "overshot, 0.7, 0.6, 0.1, 1.1"
            "bounce, 1.1, 1.6, 0.1, 0.85"
            "sligshot, 1, -1, 0.15, 1.25"
            "nice, 0, 6.9, 0.5, -4.20"
          ];
          animation = [
            "windowsIn, 1, 5, winIn, popin"
            "windowsOut, 1, 5, winOut, popin"
            "windowsMove, 1, 5, wind, slide"
            "border, 1, 10, default"
            "borderangle, 1, 100, linear, loop"
            "fade, 1, 5, overshot"
            "workspaces, 1, 5, wind"
            "windows, 1, 5, bounce, popin"
          ];
        };

        # ── Layout ────────────────────────────────────────────
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        # ── Input ─────────────────────────────────────────────
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = {
            natural_scroll = true;
          };
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
        };

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = true;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        # ── Keybindings ───────────────────────────────────────
        "$mainMod" = "SUPER";

        bind = [
          # ── Core ──────────────────────────────────────────
          "$mainMod, Q, exec, kitty"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, thunar"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, fuzzel"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"
          "$mainMod, F, fullscreen, 0"
          "$mainMod SHIFT, F, fullscreen, 1"

          # ── Screenshot ────────────────────────────────────
          "$mainMod, Print, exec, hyprshot -m window"
          ", Print, exec, hyprshot -m output"
          "$mainMod SHIFT, Print, exec, hyprshot -m region"

          # ── Focus (vim-style) ─────────────────────────────
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          # ── Focus (arrow keys) ────────────────────────────
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # ── Move windows ──────────────────────────────────
          "$mainMod SHIFT, h, movewindow, l"
          "$mainMod SHIFT, l, movewindow, r"
          "$mainMod SHIFT, k, movewindow, u"
          "$mainMod SHIFT, j, movewindow, d"

          # ── Resize ────────────────────────────────────────
          "$mainMod CTRL, h, resizeactive, -20 0"
          "$mainMod CTRL, l, resizeactive, 20 0"
          "$mainMod CTRL, k, resizeactive, 0 -20"
          "$mainMod CTRL, j, resizeactive, 0 20"

          # ── Special ───────────────────────────────────────
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
          "$mainMod, W, exec, killall waybar || waybar"
          "$mainMod, B, exec, firefox"
          "$mainMod, N, exec, swaync-client -t -sw"
          "$mainMod, L, exec, hyprlock"
          "$mainMod, BACKSPACE, exec, wlogout"
        ] ++ (
          # ── Workspaces 1-10 ───────────────────────────────
          builtins.concatLists (builtins.genList (x:
            let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 10)
        );

        # ── Mouse binds ──────────────────────────────────────
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # ── Media / Fn keys ───────────────────────────────────
        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
          ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ];

        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"
        ];
      };

      # ── Extra Config (window rules) ─────────────────────────
      extraConfig = ''
        # Source JaKooLit / DMS configs if they exist
        $configs = $HOME/.config/hypr/configs
        $UserConfigs = $HOME/.config/hypr/UserConfigs

        # Window rules
        windowrule = float, ^(pavucontrol)$
        windowrule = float, ^(nm-connection-editor)$
        windowrule = float, ^(blueman-manager)$
        windowrule = float, ^(thunar)$
        windowrule = center, ^(thunar)$
        windowrule = float, title:^(btop)$
        windowrule = float, title:^(update-sys)$

        # Opacity rules
        windowrule = opacity 0.90, ^(firefox)$
        windowrule = opacity 0.90, ^(brave-browser)$
        windowrule = opacity 0.85, ^(code-url-handler)$
        windowrule = opacity 0.80, ^(kitty)$
        windowrule = opacity 0.80, ^(Alacritty)$
        windowrule = opacity 0.80, ^(thunar)$

        # Draw overlay
        windowrule = stay_focused on, match:class python3, match:title Draw-Screen Overlay
        windowrule = float on, match:class python3, match:title Draw-Screen Overlay
        windowrule = size 100% 100%, match:class python3, match:title Draw-Screen Overlay
        windowrule = move 0 0, match:class python3, match:title Draw-Screen Overlay
        windowrule = no_anim on, match:class python3, match:title Draw-Screen Overlay
        windowrule = decorate off, match:class python3, match:title Draw-Screen Overlay
        windowrule = no_shadow on, match:class python3, match:title Draw-Screen Overlay
      '';
    };
  };
}
