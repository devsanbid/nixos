# Waydroid — Android container with Play Store (gaming-ready)
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.waydroid;
in
{
  options.modules.waydroid = {
    enable = lib.mkEnableOption "Waydroid Android container with Play Store";
  };

  config = lib.mkIf cfg.enable {

    # ── Overlay to fix iptables vs iptables-legacy in Waydroid ──
    nixpkgs.overlays = [
      (final: prev: {
        waydroid = prev.waydroid.overrideAttrs (old: {
          postPatch = (old.postPatch or "") + ''
            sed -i 's/iptables-legacy/iptables/g' tools/interfaces/config/net.sh || true
            sed -i 's/iptables-legacy/iptables/g' data/scripts/waydroid-net.sh || true
          '';
        });
      })
    ];

    # ── Core Waydroid Service ──────────────────────────────────
    virtualisation.waydroid.enable = true;

    # ── Kernel Modules ─────────────────────────────────────────
    # binder_linux & ashmem_linux are required for Android container IPC
    boot.kernelModules = [ "binder_linux" "ashmem_linux" ];

    # ── Helper Packages ────────────────────────────────────────
    environment.systemPackages = with pkgs; [
      waydroid
      python3          # Waydroid helper scripts
      lzip             # For ARM translation layer install
      wl-clipboard     # Clipboard sharing between host and Android
    ];

    # ── Firewall — Allow Waydroid Bridge Network ───────────────
    # Waydroid creates a bridge (waydroid0) for container networking
    networking.firewall.trustedInterfaces = [ "waydroid0" ];

  };
}
