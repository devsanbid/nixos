{ config, pkgs, ... }:

{
  # environment.systemPackages = with pkgs; [ virt-manager distrobox ];
    # users.extraGroups.vboxusers.members = [ "sanbid" ];

  #  virtualisation.virtualbox.host.enable = true;
  #  virtualisation.virtualbox.host.enableExtensionPack = true;
  #  virtualisation.virtualbox.guest.enable = true;
  # virtualisation.libvirtd = {
  #   allowedBridges = [
  #     "nm-bridge"
  #     "virbr0"
  #   ];
  #   enable = true;
  #   qemu.runAsRoot = false;
  # };
}
