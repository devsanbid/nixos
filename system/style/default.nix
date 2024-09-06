{ lib, pkgs, ... }:

let
  themePath = "../../../themes/tomorrow-night/tomorrow-night.yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes/tomorrow-night/polarity.txt"));
  myLightDMTheme = if themePolarity == "light" then "Adwaita" else "Adwaita-dark";
  backgroundUrl = builtins.readFile (./. + "../../../themes/tomorrow-night/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + "../../../themes/tomorrow-night/backgroundsha256.txt");
in
{

  stylix.autoEnable = false;
  stylix.polarity = themePolarity;
  stylix.image = pkgs.fetchurl {
   url = backgroundUrl;
   sha256 = backgroundSha256;
  };
  stylix.base16Scheme = ./. + themePath;

  stylix.targets.sddm.enable = true;
  stylix.targets.console.enable = true;

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

}
