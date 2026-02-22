# Hardware modules — GPU, audio
{ config, pkgs, ... }:

{
  imports = [
    ./nvidia.nix
    ./pipewire.nix
  ];

  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-ocl
    ];
  };

  services.power-profiles-daemon.enable = true;
  services.usbmuxd.enable = true;
}
