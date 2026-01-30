# Hardware configuration - Graphics & NVIDIA
{ config, pkgs, ... }: {

  imports = [
    ./nvidia.nix
  ];

  # Enable redistributable firmware
  hardware.enableRedistributableFirmware = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-ocl
    ];
  };

  # Power management
  services.power-profiles-daemon.enable = true;

  # Apple device support
  services.usbmuxd.enable = true;
}
