# ╔══════════════════════════════════════════════════════════════╗
# ║  HOST: Work                                                  ║
# ║  Desktop: Hyprland (primary) + KDE + Niri                   ║
# ║  Features: DMS shell, full dev tools, waybar                ║
# ╚══════════════════════════════════════════════════════════════╝
{ ... }:

{
  imports = [
    ../common
  ];

  # ── Desktop Environments ──────────────────────────────────
  modules.desktop = {
    hyprland.enable = true;   # Primary compositor
    kde.enable = true;        # Fallback DE
    niri.enable = true;       # Experimental tiling
  };

  # ── Work-specific system packages ─────────────────────────
  # postman and gitkraken are in modules/nixos/packages/development.nix
}
