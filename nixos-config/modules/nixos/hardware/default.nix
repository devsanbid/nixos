# Hardware modules — GPU, audio, dbus
{ config, pkgs, ... }:

{
  imports = [
    ./nvidia.nix
    ./pipewire.nix
    ./dbus.nix
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
