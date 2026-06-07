# Hardware modules — GPU, audio
{ config, pkgs, ... }:

{
  imports = [
    ./nvidia.nix
    ./pipewire.nix
    ./bluetooth.nix
    # ./tlp.nix
  ];

  hardware.enableRedistributableFirmware = true;
  services.power-profiles-daemon.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-ocl
    ];
  };

  services.usbmuxd.enable = true;
}
