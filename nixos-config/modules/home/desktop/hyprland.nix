# Home-Manager: Hyprland — enable package + systemd integration
# Actual config is sourced from config/hyprland_2.0 via hyprland-rice.nix
{ config, lib, ... }:

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
      # Config is managed by hyprland-rice.nix (config/hyprland_2.0 → ~/.config/hypr)
      extraConfig = "# Config sourced from ~/.config/hypr (managed by hyprland-rice module)";
    };
  };
}
