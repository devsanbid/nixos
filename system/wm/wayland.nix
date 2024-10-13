{ config, pkgs, ... }:

{
  imports = [ ./pipewire.nix
              ./dbus.nix
            ];
}
