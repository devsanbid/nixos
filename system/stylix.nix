{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    opacity = {
      applications = 0.85;
      desktop = 0.85;
      popups = 1.0;
    };
    polarity = "dark";
    targets = {
      chromium.enable = true;
      fish.enable = true;
      gnome.enable = true;
      grub.enable = true;
      gtk.enable = true;
    };
  };
}
