# DankMaterialShell dependencies
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    matugen
    lm_sensors
    cliphist
    khal
    vdirsyncer
    ddcutil
    i2c-tools
    qt6.qtmultimedia
    fprintd
    adw-gtk3
    accountsservice
    power-profiles-daemon
    bluez
    blueman
    wttrbar
    mlocate
    plocate
    polkit_gnome
  ];

  services.accounts-daemon.enable = true;
  hardware.i2c.enable = true;
  services.fprintd.enable = true;
}
