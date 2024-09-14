{ inputs, pkgs, lib, ... }:
{
  # Import wayland config
  imports = [
    ./wayland.nix
  ];

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
  };

  environment = {
    plasma5.excludePackages = [ pkgs.kdePackages.systemsettings ];
    plasma6.excludePackages = [ pkgs.kdePackages.systemsettings ];
  };

  services.xserver.excludePackages = [ pkgs.xterm ];

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.sddm;
    };

  };
}
