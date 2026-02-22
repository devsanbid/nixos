# NixOS module: Niri scrollable tiling Wayland compositor
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.desktop.niri;
in
{
  options.modules.desktop.niri = {
    enable = lib.mkEnableOption "Niri window manager";
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    # ── SDDM for login (shared with KDE) ───────────────────
    services.displayManager.sddm.enable = lib.mkDefault true;
    services.displayManager.sddm.wayland.enable = true;

    # ── XDG Portal for wlroots ──────────────────────────────
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    };
  };
}
