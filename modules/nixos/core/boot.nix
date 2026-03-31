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

  # ── Boot Snapshots / Generation Labels ────────────────────
  # Show generation labels in boot menu with timestamps
  boot.loader.systemd-boot.configurationLimit = 5;  # Keep last 20 generations

    virtualisation.libvirtd.enable = true;

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';
  # Enable boot counting for automatic fallback on failed boots
  boot.loader.systemd-boot.extraEntries = {
    # Custom entry for recovery
    "nixos-recovery.conf" = ''
      title NixOS Recovery
      linux /nixos-generation-recovery/kernel
      initrd /nixos-generation-recovery/initrd
      options root="UUID=$(findmnt -n -o UUID /)" init=/nix/var/nix/profiles/system/recovery/bin/switch-to-configuration boot
    '';
  };

  # ── Snapshot Integration ─────────────────────────────────
  # Create snapshot metadata on each rebuild
  system.activationScripts.snapshotBoot = {
    text = ''
      # Create timestamped boot entry label
      current_time=$(date "+%Y-%m-%d %H:%M:%S")
      echo "Booted: ''${current_time}" > /boot/nixos-boot-info.txt

      # Store generation info
      generation=$(readlink /nix/var/nix/profiles/system | grep -o '[0-9]*')
      echo "Generation: ''${generation}" >> /boot/nixos-boot-info.txt
      echo "Profile: $(hostname)" >> /boot/nixos-boot-info.txt
    '';
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
