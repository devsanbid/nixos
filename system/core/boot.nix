# Boot configuration - Lanzaboote Secure Boot
{ config, lib, pkgs, ... }: {

  # Secure Boot with Lanzaboote
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  # Kernel configuration
  boot.kernelModules = [ "acpi_ec" "wmi" "ec_sys" "thinkpad_acpi" ];
  boot.extraModulePackages = with pkgs; [
    linuxKernel.packages.linux_6_12.lenovo-legion-module
  ];

  # Kernel parameters for NVIDIA
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # System performance tweaks
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;
    "vm.vfs_cache_pressure" = 50;
  };

  # SSD optimization
  services.fstrim.enable = true;

  # Secure boot tooling
  environment.systemPackages = with pkgs; [ sbctl efibootmgr ];
}
