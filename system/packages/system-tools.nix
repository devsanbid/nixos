# System & Hardware Tools
{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    dmidecode
    gnome-tweaks
    gparted
    inxi
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    lenovo-legion
    lsof
    pciutils
    psmisc
    testdisk
    testdisk-qt
    tree
    udev
    usbimager
    woeusb-ng
    wirelesstools
  ];
}
