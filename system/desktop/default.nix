# Desktop environment and display manager configuration
{ pkgs, ... }: {

  imports = [
    ./services.nix
  ];

  # Display Manager
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Disable KDE Wallet - prevents password prompts on every login
  # Use gnome-keyring instead (enabled in home.nix)
  programs.kdeconnect.enable = false;  # Disable kdeconnect to reduce KDE deps
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kwallet
    kwallet-pam
    kwalletmanager
  ];

  # X Server
  services.xserver = {
    enable = true;
    xkb = { layout = "us"; variant = ""; };
  };

  # Hyprland specific
  services.hypridle.enable = true;

  # XDG Portal - required for screen capture in OBS/Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
      pkgs.xdg-desktop-portal-hyprland  # Screen sharing for Hyprland
    ];
    # Prefer Hyprland portal for screen capture
    config.common.default = [ "hyprland" "gtk" ];
  };

  # GNOME Keyring for password management (auto-unlock with login)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
