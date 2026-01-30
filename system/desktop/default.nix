# Desktop environment and display manager configuration
{ pkgs, ... }: {

  imports = [
    ./services.nix
  ];

  # Display Manager
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # X Server
  services.xserver = {
    enable = true;
    xkb = { layout = "us"; variant = ""; };
  };

  # Hyprland specific
  services.hypridle.enable = true;

  # XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
