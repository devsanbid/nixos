{ inputs, pkgs, lib, ... }:
{
  # Import wayland config
  imports = [
    ./wayland.nix
  ];

  # Enable Hyprland
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1"; # Enable Display Manager

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        user = "sanbid";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

}
