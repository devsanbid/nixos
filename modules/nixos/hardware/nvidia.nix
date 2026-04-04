# NVIDIA — Intel+NVIDIA PRIME offload with finegrained power management (Lenovo Legion)
{ config, pkgs, ... }:
{
  # hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;

    powerManagement.enable = true;        # changed from false

    prime = {
      sync.enable = false;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
