# NixOS module: KDE Plasma 6 (latest) desktop environment
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.desktop.kde;
in
{
  options.modules.desktop.kde = {
    enable = lib.mkEnableOption "KDE Plasma 6 desktop environment";
  };

  config = lib.mkIf cfg.enable {
    # ── Display Manager ─────────────────────────────────────
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # ── Plasma 6 ────────────────────────────────────────────
    services.desktopManager.plasma6.enable = true;

    # ── Disable unnecessary KDE components ──────────────────
    programs.kdeconnect.enable = false;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kwallet
      kwallet-pam
      kwalletmanager
    ];

    # ── X11 fallback (SDDM needs it) ───────────────────────
    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
}
