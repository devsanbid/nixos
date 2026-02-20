# DankMaterialShell dependencies
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    quickshell
    matugen
    lm_sensors
    wl-clipboard
    cliphist
    cava
    khal
    vdirsyncer
    ddcutil
    i2c-tools
    qt6.qtmultimedia
    fprintd
    adw-gtk3
    accountsservice
    power-profiles-daemon
    networkmanager
    bluez
    blueman
    playerctl
    wttrbar
    fd
    mlocate
    plocate
    libappindicator-gtk3
    polkit_gnome
  ];

  services.accounts-daemon.enable = true;
  hardware.i2c.enable = true;
  services.fprintd.enable = true;
}
