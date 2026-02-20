# Users — sanbid (primary), sandesh
{ pkgs, ... }:

{
  users.users = {
    sanbid = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "sanbid";
      extraGroups = [
        "networkmanager"
        "kvm"
        "vboxusers"
        "adbusers"
        "libvirtd"
        "docker"
        "wheel"
        "ydotool"
        "audio"
      ];
    };

    sandesh = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "real users";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  users.groups.libvirtd.members = [ "sanbid" ];
  users.extraGroups.vboxusers.members = [ "sanbid" ];

  security.sudo.extraConfig = "sanbid ALL=(ALL:ALL) SETENV: ALL";
  security.rtkit.enable = true;
}
