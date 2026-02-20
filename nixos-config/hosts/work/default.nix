# ╔══════════════════════════════════════════════════════════════╗
# ║  HOST: Work                                                  ║
# ║  Desktop: Hyprland (primary) + KDE + Niri                   ║
# ║  Features: DMS shell, full dev tools, waybar                ║
# ╚══════════════════════════════════════════════════════════════╝
{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../common
  ];

  networking.hostName = "work";

  # ── Desktop Environments ──────────────────────────────────
  modules.desktop = {
    hyprland.enable = true;   # Primary compositor
    kde.enable = true;        # Fallback DE
    niri.enable = true;       # Experimental tiling
  };

  # ── Work-specific system packages ─────────────────────────
  environment.systemPackages = with pkgs; [
    # Extra work tools
    postman
    gitkraken
  ];
}
