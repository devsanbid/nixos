# ╔══════════════════════════════════════════════════════════════╗
# ║  HOST: Development                                           ║
# ║  Desktop: Hyprland + KDE (primary for dev) + Niri           ║
# ║  Features: No DMS, KDE panel instead of waybar              ║
# ╚══════════════════════════════════════════════════════════════╝
{ ... }:

{
  imports = [
    ../common
  ];

  # ── Desktop Environments ──────────────────────────────────
  modules.desktop = {
    hyprland.enable = true;
    kde.enable = true;        # Primary DE for development
    niri.enable = true;
  };

  # ── Dev-specific system packages ──────────────────────────
  # android-tools and scrcpy are in modules/nixos/packages/flutter.nix
}
