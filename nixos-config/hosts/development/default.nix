# ╔══════════════════════════════════════════════════════════════╗
# ║  HOST: Development                                           ║
# ║  Desktop: Hyprland + KDE (primary for dev) + Niri           ║
# ║  Features: No DMS, KDE panel instead of waybar              ║
# ╚══════════════════════════════════════════════════════════════╝
{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../common
  ];

  networking.hostName = "development";

  # ── Desktop Environments ──────────────────────────────────
  modules.desktop = {
    hyprland.enable = true;
    kde.enable = true;        # Primary DE for development
    niri.enable = true;
  };

  # ── Dev-specific system packages ──────────────────────────
  environment.systemPackages = with pkgs; [
    # Extra dev tools
    android-tools
    scrcpy
  ];
}
