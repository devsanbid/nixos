# ╔══════════════════════════════════════════════════════════════╗
# ║  HOST: Personal                                              ║
# ║  Desktop: Hyprland (primary) + KDE + Niri                   ║
# ║  Features: DMS, waybar, gaming, multimedia                  ║
# ╚══════════════════════════════════════════════════════════════╝
{ pkgs, ... }:

{
  imports = [
    ../common
  ];

  # ── Desktop Environments ──────────────────────────────────
  modules.desktop = {
    hyprland.enable = true;   # Primary compositor
    kde.enable = true;        # Fallback DE
    niri.enable = true;       # Experimental
  };

  # ── Personal extras ───────────────────────────────────────
  modules.gaming.enable = true;   # Gaming packages for personal
  modules.waydroid.enable = true;  # Android container with Play Store

  environment.systemPackages = with pkgs; [
    # Personal media/social
    telegram-desktop
  ];
}
