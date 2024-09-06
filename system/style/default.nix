{ lib, pkgs, ... }:

let
  themePath = "../../../themes/io/io.yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes/io/polarity.txt"));
  backgroundUrl = builtins.readFile (./. + "../../../themes/io/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + "../../../themes/io/backgroundsha256.txt");
in
{

  stylix.autoEnable = true;
  stylix.enable = true;
  stylix.polarity = themePolarity;
  stylix.image = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };
  stylix.base16Scheme = ./. + themePath;

  stylix.targets.console.enable = true;
  stylix.targets.gnome.enable = true;
  stylix.targets.grub.enable = true;
  stylix.targets.grub.useImage = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.kmscon.enable = true;

}
