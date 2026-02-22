# Automount — USB, external drives
{ ... }:

{
  services = {
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };
}
