# HOME: Personal — DMS, gaming, multimedia
{ pkgs, ... }:

{
  imports = [ ../common/home.nix ];

  # ── Personal Packages ─────────────────────────────────────
  home.packages = with pkgs; [
    wf-recorder
    (wrapOBS {
      plugins = with obs-studio-plugins; [
        wlrobs obs-pipewire-audio-capture obs-vkcapture obs-vaapi
      ];
    })
    # (callPackage ../../modules/nixos/packages/qoder.nix { })
  ];

  # ── Personal Extras ───────────────────────────────────────
  xdg.desktopEntries.netbeans = {
    name = "netbeans 2";
    icon = "netbeans";
    genericName = "Integrated Development Environment";
    exec = "netbeans --fontsize 24";
    categories = [ "Development" ];
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };

  home.file.".config/kwalletrc".text = ''
    [Wallet]
    Enabled=false
    First Use=false
  '';

  programs.home-manager.enable = true;
}
