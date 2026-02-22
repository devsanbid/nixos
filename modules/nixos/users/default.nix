# Users — primary user + sandesh
{ pkgs, username, ... }:

{
  users.users = {
    ${username} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = username;
      extraGroups = [
        "networkmanager"
        "kvm"
        "vboxusers"
        "adbusers"
        "libvirtd"
        "docker"
        "podman"
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

  users.groups.libvirtd.members = [ username ];
  users.extraGroups.vboxusers.members = [ username ];

  security.sudo.extraConfig = "${username} ALL=(ALL:ALL) SETENV: ALL";
}
