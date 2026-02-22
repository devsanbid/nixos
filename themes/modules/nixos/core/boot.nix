# Secure Boot via Lanzaboote + Lenovo Legion support
{ config, lib, pkgs, ... }:

{
  # ── Lanzaboote (Secure Boot) ──────────────────────────────
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  # ── Kernel modules ────────────────────────────────────────
  boot.kernelModules = [ "acpi_ec" "wmi" "ec_sys" "thinkpad_acpi" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    lenovo-legion-module
  ];

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # ── Performance tuning ────────────────────────────────────
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;
    "vm.vfs_cache_pressure" = 50;
  };

  services.fstrim.enable = true;

  environment.systemPackages = with pkgs; [ sbctl efibootmgr ];
}
