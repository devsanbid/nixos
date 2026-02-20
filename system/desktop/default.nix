# Desktop environment and display manager configuration
{ pkgs, ... }: {

  imports = [
    ./services.nix
  ];

  # GNOME Keyring for password management (auto-unlock with login)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
