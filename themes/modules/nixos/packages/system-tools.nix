# System tools — hardware management, partitioning
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pwvucontrol
    acpi
    brightnessctl
    dmidecode
    gnome-tweaks
    gparted
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    lenovo-legion
    lsof
    pciutils
    psmisc
    testdisk
    testdisk-qt
    udev
    usbimager
    woeusb-ng
    wirelesstools
  ];
}
