# NixOS module: Hyprland window manager (system-level)
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.desktop.hyprland;
in
{
  options.modules.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland window manager";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.hypridle.enable = true;

    # ── XDG Portal for Hyprland ─────────────────────────────
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
      config.common.default = [ "hyprland" "gtk" ];
    };

    # ── Required services ───────────────────────────────────
    security.polkit.enable = true;
  };
}
