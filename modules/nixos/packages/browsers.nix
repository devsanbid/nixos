# Browsers & internet apps
{ pkgs, zen-browser, ... }:

{
  environment.systemPackages = with pkgs; [
    ungoogled-chromium
    brave
    firefox-bin
    vivaldi
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    anydesk
    motrix
    qbittorrent
    tunnelto
    wgnord
  ];
}
