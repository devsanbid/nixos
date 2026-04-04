{ pkgs, inputs, ... }:
{
  # install package
  environment.systemPackages = with pkgs; [
  inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  grim slurp wl-clipboard tesseract imagemagick zbar curl
  translate-shell wl-screenrec ffmpeg gifski
  imagemagick
  evtest
  libsForQt5.qt5.qtgraphicaleffects
  ];
}
