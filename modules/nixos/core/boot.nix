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
    "fedora.conf" = ''
      title Bazzite (Fedora)
      efi /EFI/fedora/shimx64.efi
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
      echo "Profile: ${config.networking.hostName}" >> /boot/nixos-boot-info.txt
    '';
  };

  system.activationScripts.syncOtherOSBootloaders = {
    text = ''
      # Copy other OS bootloaders to NixOS ESP so systemd-boot can see them
      echo "Syncing other OS EFI entries..."
      
      # We need to find the first ESP (nvme0n1p1)
      ESP1_MOUNT=$(findmnt -n -o TARGET /dev/nvme0n1p1 || true)
      
      # If not mounted, mount it temporarily
      if [ -z "$ESP1_MOUNT" ]; then
        mkdir -p /tmp/other-esp
        mount -t vfat /dev/nvme0n1p1 /tmp/other-esp
        ESP1_MOUNT="/tmp/other-esp"
        MOUNTED_BY_US=1
      else
        MOUNTED_BY_US=0
      fi
      
      if [ -n "$ESP1_MOUNT" ] && [ -d "$ESP1_MOUNT/EFI" ]; then
        mkdir -p /boot/EFI/Microsoft /boot/EFI/fedora /boot/loader/entries
        
        # Copy Windows Boot Manager
        if [ -d "$ESP1_MOUNT/EFI/Microsoft" ]; then
          cp -r "$ESP1_MOUNT/EFI/Microsoft/"* /boot/EFI/Microsoft/ 2>/dev/null || true
        fi
        
        # Copy Fedora/Bazzite
        if [ -d "$ESP1_MOUNT/EFI/fedora" ]; then
          cp -r "$ESP1_MOUNT/EFI/fedora/"* /boot/EFI/fedora/ 2>/dev/null || true
          
          # Manually create the systemd-boot entry for Fedora
          cat <<EOF > /boot/loader/entries/fedora.conf
title Bazzite (Fedora)
efi /EFI/fedora/shimx64.efi
EOF
          echo "Created Bazzite boot entry."
        fi
      fi
      
      # Cleanup
      if [ "$MOUNTED_BY_US" = "1" ]; then
        umount /tmp/other-esp
        rmdir /tmp/other-esp
      fi
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
